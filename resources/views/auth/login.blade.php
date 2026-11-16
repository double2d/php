<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Quản trị - Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <div class="fs-1 text-primary mb-2">
                                <i class="bi bi-book-half"></i>
                            </div>
                            <h4 class="fw-bold mb-1">Bookstore Admin</h4>
                            <p class="text-muted small mb-0">Đăng nhập hệ thống Quản lý Nhà cung cấp</p>
                        </div>

                        @if ($errors->any())
                            <div class="alert alert-danger py-2 small">
                                {{ $errors->first() }}
                            </div>
                        @endif

                        <form action="{{ route('login.post') }}" method="POST">
                            @csrf
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Email</label>
                                <input type="email" name="email" class="form-control" value="{{ old('email', 'admin@bookstore.vn') }}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Mật khẩu</label>
                                <input type="password" name="password" class="form-control" value="password123" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập Admin
                                </button>
                            </div>
                        </form>

                        <div class="mt-3 pt-3 border-top small text-muted text-center">
                            Tài khoản test mặc định:<br>
                            <code>admin@bookstore.vn</code> / <code>password123</code>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
