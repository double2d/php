@extends('layouts.admin')

@section('title', 'Chi tiết Nhà cung cấp: ' . $supplier->name)

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-1">{{ $supplier->name }}</h3>
        <span class="badge {{ $supplier->is_active ? 'bg-success' : 'bg-secondary' }}">
            {{ $supplier->is_active ? 'Đang hợp tác' : 'Ngừng hợp tác' }}
        </span>
    </div>
    <div class="d-flex gap-2">
        <a href="{{ route('admin.suppliers.importForm', $supplier) }}" class="btn btn-success">
            <i class="bi bi-box-arrow-in-down me-1"></i>Lập phiếu nhập sách
        </a>
        <a href="{{ route('admin.suppliers.edit', $supplier) }}" class="btn btn-outline-primary">
            <i class="bi bi-pencil-square me-1"></i>Chỉnh sửa
        </a>
        <a href="{{ route('admin.suppliers.index') }}" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-1"></i>Quay lại
        </a>
    </div>
</div>

<!-- Thông tin chung -->
<div class="card border-0 shadow-sm mb-4">
    <div class="card-body">
        <div class="row g-3">
            <div class="col-md-3">
                <div class="text-muted small">Email liên hệ</div>
                <div class="fw-semibold">{{ $supplier->email }}</div>
            </div>
            <div class="col-md-3">
                <div class="text-muted small">Số điện thoại</div>
                <div class="fw-semibold">{{ $supplier->phone }}</div>
            </div>
            <div class="col-md-3">
                <div class="text-muted small">Mã số thuế</div>
                <div class="fw-semibold"><code>{{ $supplier->tax_code ?? 'Chưa cập nhật' }}</code></div>
            </div>
            <div class="col-md-3">
                <div class="text-muted small">Tổng số đầu sách cung cấp</div>
                <div class="fw-bold text-primary">{{ $supplier->books->count() }} đầu sách</div>
            </div>
            <div class="col-12">
                <div class="text-muted small">Địa chỉ trụ sở</div>
                <div>{{ $supplier->address ?? 'Chưa cập nhật địa chỉ' }}</div>
            </div>
        </div>
    </div>
</div>

<!-- Tabs Danh sách sách & Lịch sử phiếu nhập -->
<ul class="nav nav-tabs mb-3" id="supplierDetailTab" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active fw-semibold" id="books-tab" data-bs-toggle="tab" data-bs-target="#books-pane" type="button" role="tab">
            <i class="bi bi-journal-bookmark me-1"></i>Danh sách sách đang cung cấp ({{ $supplier->books->count() }})
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link fw-semibold" id="receipts-tab" data-bs-toggle="tab" data-bs-target="#receipts-pane" type="button" role="tab">
            <i class="bi bi-receipt me-1"></i>Lịch sử phiếu nhập kho ({{ $supplier->importReceipts->count() }})
        </button>
    </li>
</ul>

<div class="tab-content" id="supplierDetailTabContent">
    <!-- Tab 1: Danh sách sách -->
    <div class="tab-pane fade show active" id="books-pane" role="tabpanel">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">Mã sách</th>
                                <th>Tên sách</th>
                                <th>Tác giả</th>
                                <th>Thể loại</th>
                                <th class="text-end">Giá bán</th>
                                <th class="text-center pe-3">Tồn kho hiện tại</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($supplier->books as $book)
                                <tr>
                                    <td class="ps-3">#{{ $book->id }}</td>
                                    <td class="fw-semibold">{{ $book->title }}</td>
                                    <td>{{ $book->author }}</td>
                                    <td>
                                        <span class="badge bg-light text-dark border">
                                            {{ $book->category->name ?? '—' }}
                                        </span>
                                    </td>
                                    <td class="text-end fw-semibold text-danger">
                                        {{ number_format($book->price, 0, ',', '.') }} đ
                                    </td>
                                    <td class="text-center pe-3">
                                        <span class="badge {{ $book->stock_quantity > 10 ? 'bg-success' : 'bg-warning text-dark' }}">
                                            {{ $book->stock_quantity }} cuốn
                                        </span>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">
                                        Nhà cung cấp này chưa có đầu sách nào.
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Tab 2: Lịch sử phiếu nhập -->
    <div class="tab-pane fade" id="receipts-pane" role="tabpanel">
        @forelse ($supplier->importReceipts as $receipt)
            <div class="card border-0 shadow-sm mb-3">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <div>
                        <span class="fw-bold text-primary">Phiếu nhập #{{ $receipt->id }}</span>
                        <span class="text-muted ms-2 small">
                            <i class="bi bi-clock me-1"></i>{{ $receipt->created_at->format('d/m/Y H:i') }}
                        </span>
                        <span class="text-muted ms-2 small">
                            <i class="bi bi-person me-1"></i>Người lập: {{ $receipt->user->name ?? 'N/A' }}
                        </span>
                    </div>
                    <div class="fw-bold text-success">
                        Tổng tiền: {{ number_format($receipt->total_amount, 0, ',', '.') }} đ
                    </div>
                </div>
                <div class="card-body p-0">
                    @if ($receipt->note)
                        <div class="px-3 py-2 bg-light border-bottom small text-muted">
                            <strong>Ghi chú:</strong> {{ $receipt->note }}
                        </div>
                    @endif
                    <div class="table-responsive">
                        <table class="table table-sm mb-0 align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-3">Tên sách</th>
                                    <th class="text-center">Số lượng nhập</th>
                                    <th class="text-end">Đơn giá nhập</th>
                                    <th class="text-end pe-3">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($receipt->details as $detail)
                                    <tr>
                                        <td class="ps-3">{{ $detail->book->title ?? 'Sách đã xóa' }}</td>
                                        <td class="text-center">{{ $detail->quantity }}</td>
                                        <td class="text-end">{{ number_format($detail->import_price, 0, ',', '.') }} đ</td>
                                        <td class="text-end pe-3 fw-semibold">
                                            {{ number_format($detail->quantity * $detail->import_price, 0, ',', '.') }} đ
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        @empty
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center py-4 text-muted">
                    Chưa có lịch sử phiếu nhập hàng nào từ nhà cung cấp này.
                </div>
            </div>
        @endforelse
    </div>
</div>
@endsection
