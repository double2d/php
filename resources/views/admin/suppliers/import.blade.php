@extends('layouts.admin')

@section('title', 'Nhập sách từ ' . $supplier->name)

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-1">Lập phiếu nhập kho sách</h3>
        <p class="text-muted mb-0">Nhà cung cấp: <strong class="text-dark">{{ $supplier->name }}</strong> ({{ $supplier->phone }})</p>
    </div>
    <a href="{{ route('admin.suppliers.show', $supplier) }}" class="btn btn-outline-secondary">
        <i class="bi bi-arrow-left me-1"></i>Quay lại chi tiết NCC
    </a>
</div>

@if ($errors->any())
    <div class="alert alert-danger shadow-sm">
        <div class="fw-bold mb-1"><i class="bi bi-exclamation-octagon me-1"></i>Vui lòng kiểm tra lại dữ liệu nhập:</div>
        <ul class="mb-0 ps-3">
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif

@if ($supplier->books->isEmpty())
    <div class="alert alert-warning shadow-sm">
        Nhà cung cấp này hiện chưa có đầu sách nào trong hệ thống để lập phiếu nhập.
    </div>
@else
    <form action="{{ route('admin.suppliers.processImport', $supplier) }}" method="POST" id="importForm">
        @csrf

        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                <h5 class="mb-0 fw-bold">Chi tiết các đầu sách nhập kho</h5>
                <button type="button" id="btnAddRow" class="btn btn-sm btn-outline-primary">
                    <i class="bi bi-plus-circle me-1"></i>Thêm dòng sách
                </button>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table align-middle mb-0" id="importItemsTable">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3" style="width: 42%;">Chọn đầu sách của Nhà cung cấp</th>
                                <th style="width: 18%;">Số lượng nhập</th>
                                <th style="width: 22%;">Đơn giá nhập (VNĐ)</th>
                                <th class="text-end" style="width: 13%;">Thành tiền</th>
                                <th class="text-center pe-3" style="width: 5%;">Xóa</th>
                            </tr>
                        </thead>
                        <tbody id="importRowsContainer">
                            <tr class="import-row">
                                <td class="ps-3">
                                    <select name="items[0][book_id]" class="form-select book-select" required>
                                        <option value="">-- Chọn đầu sách --</option>
                                        @foreach ($supplier->books as $book)
                                            <option value="{{ $book->id }}">
                                                {{ $book->title }} (Tồn: {{ $book->stock_quantity }} | Giá bán: {{ number_format($book->price, 0, ',', '.') }}đ)
                                            </option>
                                        @endforeach
                                    </select>
                                </td>
                                <td>
                                    <input type="number" name="items[0][quantity]" class="form-control qty-input" min="1" value="10" required>
                                </td>
                                <td>
                                    <input type="number" name="items[0][import_price]" class="form-control price-input" min="1000" step="1000" value="50000" required>
                                </td>
                                <td class="text-end fw-semibold row-subtotal">500.000 đ</td>
                                <td class="text-center pe-3">
                                    <button type="button" class="btn btn-sm btn-outline-danger btn-remove-row" disabled>
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                        <tfoot class="table-light">
                            <tr>
                                <td colspan="3" class="text-end fw-bold">Tổng cộng giá trị phiếu nhập:</td>
                                <td class="text-end fw-bold text-success fs-5" id="grandTotalDisplay">500.000 đ</td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body">
                <label for="note" class="form-label fw-semibold">Ghi chú phiếu nhập</label>
                <textarea name="note" id="note" rows="2" class="form-control" placeholder="Nhập ghi chú đợt nhập hàng, số hóa đơn VAT (nếu có)...">{{ old('note') }}</textarea>
            </div>
        </div>

        <div class="d-flex justify-content-end gap-2">
            <a href="{{ route('admin.suppliers.show', $supplier) }}" class="btn btn-light">Hủy</a>
            <button type="submit" class="btn btn-success px-4">
                <i class="bi bi-check2-all me-1"></i>Hoàn tất nhập kho & Cộng tồn kho
            </button>
        </div>
    </form>
@endif
@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', function () {
    const container = document.getElementById('importRowsContainer');
    const btnAddRow = document.getElementById('btnAddRow');
    const grandTotalDisplay = document.getElementById('grandTotalDisplay');

    if (!container) return;

    let rowIndex = 1;

    const bookOptionsHtml = `
        <option value="">-- Chọn đầu sách --</option>
        @foreach ($supplier->books as $book)
            <option value="{{ $book->id }}">
                {{ addslashes($book->title) }} (Tồn: {{ $book->stock_quantity }} | Giá bán: {{ number_format($book->price, 0, ',', '.') }}đ)
            </option>
        @endforeach
    `;

    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN').format(amount) + ' đ';
    }

    function recalculateTotals() {
        let grandTotal = 0;
        const rows = container.querySelectorAll('.import-row');

        rows.forEach((row) => {
            const qty = parseInt(row.querySelector('.qty-input').value || 0, 10);
            const price = parseFloat(row.querySelector('.price-input').value || 0);
            const subtotal = qty * price;
            grandTotal += subtotal;
            row.querySelector('.row-subtotal').textContent = formatCurrency(subtotal);
        });

        grandTotalDisplay.textContent = formatCurrency(grandTotal);

        const removeButtons = container.querySelectorAll('.btn-remove-row');
        removeButtons.forEach(btn => {
            btn.disabled = rows.length === 1;
        });
    }

    btnAddRow.addEventListener('click', function () {
        const tr = document.createElement('tr');
        tr.className = 'import-row';
        tr.innerHTML = `
            <td class="ps-3">
                <select name="items[${rowIndex}][book_id]" class="form-select book-select" required>
                    ${bookOptionsHtml}
                </select>
            </td>
            <td>
                <input type="number" name="items[${rowIndex}][quantity]" class="form-control qty-input" min="1" value="10" required>
            </td>
            <td>
                <input type="number" name="items[${rowIndex}][import_price]" class="form-control price-input" min="1000" step="1000" value="50000" required>
            </td>
            <td class="text-end fw-semibold row-subtotal">500.000 đ</td>
            <td class="text-center pe-3">
                <button type="button" class="btn btn-sm btn-outline-danger btn-remove-row">
                    <i class="bi bi-x-lg"></i>
                </button>
            </td>
        `;
        container.appendChild(tr);
        rowIndex++;
        recalculateTotals();
    });

    container.addEventListener('input', function (e) {
        if (e.target.classList.contains('qty-input') || e.target.classList.contains('price-input')) {
            recalculateTotals();
        }
    });

    container.addEventListener('click', function (e) {
        const removeBtn = e.target.closest('.btn-remove-row');
        if (removeBtn && container.querySelectorAll('.import-row').length > 1) {
            removeBtn.closest('.import-row').remove();
            recalculateTotals();
        }
    });
});
</script>
@endpush
