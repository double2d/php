@extends('layouts.admin')

@section('title', 'Quản lý Nhà cung cấp sách')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-1">Danh sách Nhà cung cấp sách</h3>
        <p class="text-muted mb-0">Quản lý thông tin đối tác xuất bản, phát hành sách và nhập kho</p>
    </div>
    <a href="{{ route('admin.suppliers.create') }}" class="btn btn-primary">
        <i class="bi bi-plus-lg me-1"></i>Thêm nhà cung cấp
    </a>
</div>

<!-- Thẻ thống kê nhanh -->
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="card border-0 shadow-sm">
            <div class="card-body d-flex align-items-center justify-content-between">
                <div>
                    <div class="text-muted small">Tổng số Nhà cung cấp</div>
                    <h3 class="fw-bold mb-0">{{ $totalSuppliers }}</h3>
                </div>
                <div class="fs-1 text-primary opacity-75">
                    <i class="bi bi-buildings"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card border-0 shadow-sm">
            <div class="card-body d-flex align-items-center justify-content-between">
                <div>
                    <div class="text-muted small">Đang hợp tác</div>
                    <h3 class="fw-bold text-success mb-0">{{ $activeSuppliers }}</h3>
                </div>
                <div class="fs-1 text-success opacity-75">
                    <i class="bi bi-check2-circle"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card border-0 shadow-sm">
            <div class="card-body d-flex align-items-center justify-content-between">
                <div>
                    <div class="text-muted small">Ngừng hợp tác</div>
                    <h3 class="fw-bold text-secondary mb-0">{{ $inactiveSuppliers }}</h3>
                </div>
                <div class="fs-1 text-secondary opacity-75">
                    <i class="bi bi-slash-circle"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bộ lọc & Tìm kiếm bất đồng bộ bằng Fetch API -->
<div class="card border-0 shadow-sm mb-4">
    <div class="card-body">
        <div class="row g-3 align-items-center">
            <div class="col-md-6">
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                    <input
                        type="text"
                        id="searchKeyword"
                        class="form-control"
                        placeholder="Tìm theo tên nhà cung cấp, email, số điện thoại, mã số thuế..."
                    >
                </div>
            </div>
            <div class="col-md-4">
                <select id="filterStatus" class="form-select">
                    <option value="">-- Tất cả trạng thái hợp tác --</option>
                    <option value="1">Đang hợp tác</option>
                    <option value="0">Ngừng hợp tác</option>
                </select>
            </div>
            <div class="col-md-2 d-grid">
                <button type="button" id="btnResetFilter" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-counterclockwise me-1"></i>Làm mới
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Bảng danh sách Nhà cung cấp -->
<div class="card border-0 shadow-sm">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3">#</th>
                        <th>Nhà cung cấp</th>
                        <th>Mã số thuế</th>
                        <th>Liên hệ</th>
                        <th class="text-center">Số đầu sách</th>
                        <th class="text-center">Trạng thái</th>
                        <th class="text-end pe-3">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="supplierTableBody">
                    @forelse ($suppliers as $supplier)
                        <tr>
                            <td class="ps-3 fw-semibold">{{ $supplier->id }}</td>
                            <td>
                                <div class="fw-bold text-dark">{{ $supplier->name }}</div>
                                <small class="text-muted">{{ $supplier->address ?? '—' }}</small>
                            </td>
                            <td><code>{{ $supplier->tax_code ?? '—' }}</code></td>
                            <td>
                                <div><i class="bi bi-envelope me-1 text-muted"></i>{{ $supplier->email }}</div>
                                <div><i class="bi bi-telephone me-1 text-muted"></i>{{ $supplier->phone }}</div>
                            </td>
                            <td class="text-center">
                                <span class="badge bg-info text-dark rounded-pill px-3">
                                    {{ $supplier->books_count }} sách
                                </span>
                            </td>
                            <td class="text-center">
                                @if ($supplier->is_active)
                                    <span class="badge bg-success">Đang hợp tác</span>
                                @else
                                    <span class="badge bg-secondary">Ngừng hợp tác</span>
                                @endif
                            </td>
                            <td class="text-end pe-3">
                                <div class="btn-group btn-group-sm">
                                    <a href="{{ route('admin.suppliers.show', $supplier) }}" class="btn btn-outline-info" title="Chi tiết">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    <a href="{{ route('admin.suppliers.importForm', $supplier) }}" class="btn btn-outline-success" title="Nhập sách">
                                        <i class="bi bi-box-arrow-in-down"></i>
                                    </a>
                                    <a href="{{ route('admin.suppliers.edit', $supplier) }}" class="btn btn-outline-primary" title="Sửa">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <form action="{{ route('admin.suppliers.destroy', $supplier) }}" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa/ngừng hợp tác nhà cung cấp này?');">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-outline-danger" title="Xóa">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">
                                Chưa có nhà cung cấp nào trong hệ thống.
                            </td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
    <div class="card-footer bg-white" id="paginationWrapper">
        {{ $suppliers->links('pagination::bootstrap-5') }}
    </div>
</div>
@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.getElementById('searchKeyword');
    const statusSelect = document.getElementById('filterStatus');
    const resetBtn = document.getElementById('btnResetFilter');
    const tableBody = document.getElementById('supplierTableBody');
    const paginationWrapper = document.getElementById('paginationWrapper');
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    const searchUrl = "{{ route('admin.suppliers.search') }}";

    let debounceTimer = null;

    function escapeHtml(str) {
        if (!str) return '';
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    }

    async function fetchSuppliers() {
        const keyword = searchInput.value.trim();
        const status = statusSelect.value;

        const params = new URLSearchParams({ keyword, status });

        try {
            const response = await fetch(`${searchUrl}?${params.toString()}`, {
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'application/json'
                }
            });

            const result = await response.json();

            if (!result.success) return;

            if (keyword !== '' || status !== '') {
                paginationWrapper.classList.add('d-none');
            } else {
                paginationWrapper.classList.remove('d-none');
            }

            if (result.data.length === 0) {
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="7" class="text-center py-4 text-muted">
                            Không tìm thấy nhà cung cấp nào phù hợp với từ khóa.
                        </td>
                    </tr>
                `;
                return;
            }

            tableBody.innerHTML = result.data.map(item => {
                const statusBadge = item.is_active
                    ? '<span class="badge bg-success">Đang hợp tác</span>'
                    : '<span class="badge bg-secondary">Ngừng hợp tác</span>';

                return `
                    <tr>
                        <td class="ps-3 fw-semibold">${item.id}</td>
                        <td>
                            <div class="fw-bold text-dark">${escapeHtml(item.name)}</div>
                            <small class="text-muted">${escapeHtml(item.address)}</small>
                        </td>
                        <td><code>${escapeHtml(item.tax_code)}</code></td>
                        <td>
                            <div><i class="bi bi-envelope me-1 text-muted"></i>${escapeHtml(item.email)}</div>
                            <div><i class="bi bi-telephone me-1 text-muted"></i>${escapeHtml(item.phone)}</div>
                        </td>
                        <td class="text-center">
                            <span class="badge bg-info text-dark rounded-pill px-3">${item.books_count} sách</span>
                        </td>
                        <td class="text-center">${statusBadge}</td>
                        <td class="text-end pe-3">
                            <div class="btn-group btn-group-sm">
                                <a href="${item.urls.show}" class="btn btn-outline-info" title="Chi tiết">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="${item.urls.import}" class="btn btn-outline-success" title="Nhập sách">
                                    <i class="bi bi-box-arrow-in-down"></i>
                                </a>
                                <a href="${item.urls.edit}" class="btn btn-outline-primary" title="Sửa">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                <form action="${item.urls.destroy}" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa/ngừng hợp tác nhà cung cấp này?');">
                                    <input type="hidden" name="_token" value="${csrfToken}">
                                    <input type="hidden" name="_method" value="DELETE">
                                    <button type="submit" class="btn btn-outline-danger" title="Xóa">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                `;
            }).join('');
        } catch (error) {
            console.error('Lỗi khi tìm kiếm nhà cung cấp:', error);
        }
    }

    searchInput.addEventListener('input', function () {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(fetchSuppliers, 300);
    });

    statusSelect.addEventListener('change', fetchSuppliers);

    resetBtn.addEventListener('click', function () {
        searchInput.value = '';
        statusSelect.value = '';
        window.location.href = "{{ route('admin.suppliers.index') }}";
    });
});
</script>
@endpush
