<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreSupplierRequest;
use App\Http\Requests\UpdateSupplierRequest;
use App\Models\Book;
use App\Models\ImportReceipt;
use App\Models\ImportReceiptDetail;
use App\Models\Supplier;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class SupplierController extends Controller
{
    public function index(): View
    {
        $suppliers = Supplier::withCount('books')
            ->latest()
            ->paginate(10);

        $totalSuppliers = Supplier::count();
        $activeSuppliers = Supplier::where('is_active', true)->count();
        $inactiveSuppliers = $totalSuppliers - $activeSuppliers;

        return view('admin.suppliers.index', compact(
            'suppliers',
            'totalSuppliers',
            'activeSuppliers',
            'inactiveSuppliers'
        ));
    }

    public function create(): View
    {
        return view('admin.suppliers.create');
    }

    public function store(StoreSupplierRequest $request): RedirectResponse
    {
        Supplier::create($request->validated());

        return redirect()
            ->route('admin.suppliers.index')
            ->with('success', 'Thêm mới nhà cung cấp thành công!');
    }

    public function show(Supplier $supplier): View
    {
        $supplier->load([
            'books.category',
            'importReceipts' => fn ($query) => $query->latest(),
            'importReceipts.user',
            'importReceipts.details.book',
        ]);

        return view('admin.suppliers.show', compact('supplier'));
    }

    public function edit(Supplier $supplier): View
    {
        return view('admin.suppliers.edit', compact('supplier'));
    }

    public function update(UpdateSupplierRequest $request, Supplier $supplier): RedirectResponse
    {
        $supplier->update($request->validated());

        return redirect()
            ->route('admin.suppliers.index')
            ->with('success', 'Cập nhật thông tin nhà cung cấp thành công!');
    }

    public function destroy(Supplier $supplier): RedirectResponse
    {
        $booksCount = $supplier->books()->count();

        if ($booksCount > 0) {
            $supplier->update(['is_active' => false]);

            return redirect()
                ->route('admin.suppliers.index')
                ->with('success', "Nhà cung cấp \"{$supplier->name}\" đang có {$booksCount} đầu sách trong hệ thống nên đã được chuyển sang trạng thái Ngừng hợp tác để bảo toàn dữ liệu.");
        }

        $supplier->delete();

        return redirect()
            ->route('admin.suppliers.index')
            ->with('success', 'Đã xóa nhà cung cấp thành công!');
    }

    public function searchAjax(Request $request): JsonResponse
    {
        $keyword = trim((string) $request->query('keyword', ''));
        $status = $request->query('status', '');

        $query = Supplier::withCount('books')->latest();

        if ($keyword !== '') {
            $query->where(function ($subQuery) use ($keyword) {
                $subQuery->where('name', 'like', "%{$keyword}%")
                    ->orWhere('email', 'like', "%{$keyword}%")
                    ->orWhere('phone', 'like', "%{$keyword}%")
                    ->orWhere('tax_code', 'like', "%{$keyword}%");
            });
        }

        if ($status !== '' && in_array($status, ['0', '1'], true)) {
            $query->where('is_active', (bool) $status);
        }

        $suppliers = $query->get()->map(function (Supplier $supplier) {
            return [
                'id' => $supplier->id,
                'name' => $supplier->name,
                'email' => $supplier->email,
                'phone' => $supplier->phone,
                'tax_code' => $supplier->tax_code ?? '—',
                'address' => $supplier->address ?? '—',
                'books_count' => $supplier->books_count,
                'is_active' => $supplier->is_active,
                'urls' => [
                    'show' => route('admin.suppliers.show', $supplier),
                    'import' => route('admin.suppliers.importForm', $supplier),
                    'edit' => route('admin.suppliers.edit', $supplier),
                    'destroy' => route('admin.suppliers.destroy', $supplier),
                ],
            ];
        });

        return response()->json([
            'success' => true,
            'message' => 'OK',
            'data' => $suppliers,
        ]);
    }

    public function importForm(Supplier $supplier): View
    {
        $supplier->load('books.category');

        return view('admin.suppliers.import', compact('supplier'));
    }

    public function processImport(Request $request, Supplier $supplier): RedirectResponse
    {
        $validated = $request->validate([
            'note' => ['nullable', 'string', 'max:1000'],
            'items' => ['required', 'array', 'min:1'],
            'items.*.book_id' => [
                'required',
                'integer',
                'distinct',
                'exists:books,id',
            ],
            'items.*.quantity' => ['required', 'integer', 'min:1', 'max:10000'],
            'items.*.import_price' => ['required', 'numeric', 'min:1000'],
        ], [
            'items.required' => 'Vui lòng chọn ít nhất 1 đầu sách để nhập kho.',
            'items.*.book_id.required' => 'Vui lòng chọn đầu sách.',
            'items.*.book_id.distinct' => 'Mỗi đầu sách chỉ nên xuất hiện 1 dòng trong cùng phiếu nhập.',
            'items.*.quantity.required' => 'Vui lòng nhập số lượng.',
            'items.*.quantity.min' => 'Số lượng nhập tối thiểu là 1.',
            'items.*.import_price.required' => 'Vui lòng nhập đơn giá nhập.',
            'items.*.import_price.min' => 'Đơn giá nhập phải từ 1.000đ trở lên.',
        ]);

        // Đảm bảo tất cả sách thuộc về nhà cung cấp này
        $supplierBookIds = $supplier->books()->pluck('id')->toArray();
        foreach ($validated['items'] as $item) {
            if (! in_array((int) $item['book_id'], $supplierBookIds, true)) {
                return back()
                    ->withInput()
                    ->with('error', 'Có đầu sách không thuộc nhà cung cấp này. Vui lòng kiểm tra lại.');
            }
        }

        DB::transaction(function () use ($validated, $supplier, $request) {
            $totalAmount = 0;

            foreach ($validated['items'] as $item) {
                $totalAmount += ((int) $item['quantity']) * ((float) $item['import_price']);
            }

            $receipt = ImportReceipt::create([
                'supplier_id' => $supplier->id,
                'user_id' => $request->user()->id,
                'total_amount' => $totalAmount,
                'note' => $validated['note'] ?? null,
            ]);

            foreach ($validated['items'] as $item) {
                ImportReceiptDetail::create([
                    'import_receipt_id' => $receipt->id,
                    'book_id' => $item['book_id'],
                    'quantity' => $item['quantity'],
                    'import_price' => $item['import_price'],
                ]);

                // Cộng dồn tồn kho vào bảng books
                Book::where('id', $item['book_id'])->increment('stock_quantity', (int) $item['quantity']);
            }
        });

        return redirect()
            ->route('admin.suppliers.show', $supplier)
            ->with('success', 'Lập phiếu nhập hàng và cập nhật tồn kho sách thành công!');
    }
}
