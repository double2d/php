# Đồ Án Nhóm: Website Bán Sách (Laravel)

## 1. Phân công công việc nhóm (3 thành viên)
1. **Thành viên 1:** Thiết kế & khởi tạo toàn bộ Cơ sở dữ liệu (Migrations, Models, Relationships, Factories, Seeders) + Phân hệ Quản lý Nhà cung cấp sách & Nhập kho (`/admin/suppliers`).
2. **Thành viên 2:** Giao diện và chức năng của Admin (Quản lý Danh mục, Sách, Đơn hàng, Người dùng, Đánh giá) + Slide PPT.
3. **Thành viên 3:** Giao diện và chức năng của User/Khách hàng (Trang chủ, Chi tiết sách, Giỏ hàng, Đặt hàng, Đánh giá sao, Hồ sơ cá nhân) + Báo cáo Word.

---

## 2. Hướng dẫn cài đặt cho các thành viên trong nhóm

```bash
# 1. Clone dự án về máy
git clone https://github.com/double2d/duan.git
cd duan

# 2. Cài đặt thư viện PHP
composer install

# 3. Tạo file môi trường và khóa ứng dụng
cp .env.example .env
php artisan key:generate

# 4. Tạo database MySQL tên là `bookstore` (hoặc import file `database/bookstore.sql`) và chạy Migration + Seeder
mysql -u root -e "CREATE DATABASE IF NOT EXISTS bookstore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
php artisan migrate:fresh --seed

# 5. Chạy server
php artisan serve
```

---

## 3. Tài khoản đăng nhập mẫu (Đã tạo sẵn qua Seeder)

| Vai trò | Email | Mật khẩu |
| :--- | :--- | :--- |
| **Quản trị viên (Admin)** | `admin@bookstore.vn` | `password123` |
| **Khách hàng 1 (User)** | `user@bookstore.vn` | `password123` |
| **Khách hàng 2 (User)** | `minhanh@gmail.com` | `password123` |

---

## 4. Cấu trúc 12 Bảng Database đã khởi tạo sẵn
- `users`: Tài khoản Admin & Khách hàng (`is_admin`, `is_active`, `phone`, `address`, `avatar`)
- `suppliers`: Nhà cung cấp / Nhà xuất bản sách
- `categories`: Thể loại sách
- `books`: Sách (`supplier_id`, `category_id`, `title`, `slug`, `author`, `isbn`, `cover_image`, `price`, `sale_price`, `stock_quantity`, `pages`, `published_year`, `is_featured`, `is_active`)
- `tags` & `book_tag`: Nhãn sách (Quan hệ N-N)
- `import_receipts` & `import_receipt_details`: Phiếu nhập kho sách từ Nhà cung cấp
- `carts` & `cart_items`: Giỏ hàng của khách hàng
- `orders` & `order_items`: Đơn đặt hàng & Chi tiết đơn hàng
- `reviews`: Đánh giá & Bình luận sách (1–5 sao)
