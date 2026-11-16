<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Category;
use App\Models\ImportReceipt;
use App\Models\ImportReceiptDetail;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Review;
use App\Models\Supplier;
use App\Models\Tag;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Tạo tài khoản Admin và Khách hàng để cả 3 thành viên test
        $admin = User::create([
            'name' => 'Quản trị viên Bookstore',
            'email' => 'admin@bookstore.vn',
            'phone' => '0909000111',
            'address' => '268 Lý Thường Kiệt, Quận 10, TP.HCM',
            'password' => Hash::make('password123'),
            'is_admin' => true,
            'is_active' => true,
        ]);

        $customer1 = User::create([
            'name' => 'Nguyễn Văn Khách',
            'email' => 'user@bookstore.vn',
            'phone' => '0912345678',
            'address' => '123 Nguyễn Huệ, Quận 1, TP.HCM',
            'password' => Hash::make('password123'),
            'is_admin' => false,
            'is_active' => true,
        ]);

        $customer2 = User::create([
            'name' => 'Trần Thị Minh Anh',
            'email' => 'minhanh@gmail.com',
            'phone' => '0987654321',
            'address' => '45 Cầu Giấy, Hà Nội',
            'password' => Hash::make('password123'),
            'is_admin' => false,
            'is_active' => true,
        ]);

        // 2. Tạo 5 Category mẫu
        $categoryNames = [
            'Văn học',
            'Kinh tế',
            'Công nghệ thông tin',
            'Kỹ năng sống',
            'Thiếu nhi',
        ];

        $categories = collect($categoryNames)->map(function (string $name) {
            return Category::create([
                'name' => $name,
                'slug' => Str::slug($name),
                'description' => "Chuyên mục sách {$name} chọn lọc.",
            ]);
        });

        // 3. Tạo 4 Tag mẫu
        $tagNames = [
            'Bán chạy',
            'Sách mới',
            'Khuyên đọc',
            'Giảm giá',
        ];

        $tags = collect($tagNames)->map(function (string $name) {
            return Tag::create([
                'name' => $name,
                'slug' => Str::slug($name),
            ]);
        });

        // 4. Tạo 6 Supplier mẫu, mỗi Supplier kèm 5 cuốn Book và gán ngẫu nhiên 1-2 Tag
        $suppliersData = [
            [
                'name' => 'NXB Trẻ',
                'email' => 'lienhe@nxbtre.com.vn',
                'phone' => '0901234561',
                'tax_code' => '0300521451',
                'address' => '161B Lý Chính Thắng, Quận 3, TP.HCM',
                'is_active' => true,
            ],
            [
                'name' => 'NXB Kim Đồng',
                'email' => 'info@nxbkimdong.com.vn',
                'phone' => '0901234562',
                'tax_code' => '0100112233',
                'address' => '55 Quang Trung, Hai Bà Trưng, Hà Nội',
                'is_active' => true,
            ],
            [
                'name' => 'Nhã Nam',
                'email' => 'contact@nhanam.vn',
                'phone' => '0901234563',
                'tax_code' => '0101859632',
                'address' => '59 Đỗ Quang, Trung Hòa, Cầu Giấy, Hà Nội',
                'is_active' => true,
            ],
            [
                'name' => 'Alpha Books',
                'email' => 'support@alphabooks.vn',
                'phone' => '0901234564',
                'tax_code' => '0102345678',
                'address' => '176 Thái Hà, Đống Đa, Hà Nội',
                'is_active' => true,
            ],
            [
                'name' => 'NXB Giáo Dục',
                'email' => 'contact@nxbgd.vn',
                'phone' => '0901234565',
                'tax_code' => '0100108543',
                'address' => '81 Trần Hưng Đạo, Hoàn Kiếm, Hà Nội',
                'is_active' => true,
            ],
            [
                'name' => 'First News - Trí Việt',
                'email' => 'triviet@firstnews.com.vn',
                'phone' => '0901234566',
                'tax_code' => '0302568974',
                'address' => '11H Nguyễn Thị Minh Khai, Quận 1, TP.HCM',
                'is_active' => false,
            ],
        ];

        $allBooks = collect();

        foreach ($suppliersData as $supplierItem) {
            $supplier = Supplier::factory()
                ->has(
                    Book::factory()
                        ->count(5)
                        ->state(fn () => [
                            'category_id' => $categories->random()->id,
                        ]),
                    'books'
                )
                ->create($supplierItem);

            foreach ($supplier->books as $book) {
                $randomTagIds = $tags->random(rand(1, 2))->pluck('id')->toArray();
                $book->tags()->attach($randomTagIds);
                $allBooks->push($book);
            }

            // Tạo 1 phiếu nhập mẫu cho các nhà cung cấp đang hoạt động
            if ($supplier->is_active && $supplier->books->isNotEmpty()) {
                $firstBook = $supplier->books->first();
                $importPrice = 65000;
                $qty = 20;

                $receipt = ImportReceipt::create([
                    'supplier_id' => $supplier->id,
                    'user_id' => $admin->id,
                    'total_amount' => $importPrice * $qty,
                    'note' => 'Nhập hàng đợt đầu từ ' . $supplier->name,
                ]);

                ImportReceiptDetail::create([
                    'import_receipt_id' => $receipt->id,
                    'book_id' => $firstBook->id,
                    'quantity' => $qty,
                    'import_price' => $importPrice,
                ]);
            }
        }

        // 5. Tạo dữ liệu mẫu Đơn hàng (Orders), Giỏ hàng (Carts) & Đánh giá (Reviews) cho 2 bạn làm Admin và User
        if ($allBooks->count() >= 3) {
            $sampleBooks = $allBooks->random(2);
            $orderTotal = ($sampleBooks[0]->price * 2) + ($sampleBooks[1]->price * 1);

            $order = Order::create([
                'order_code' => 'ORD-' . strtoupper(Str::random(6)),
                'user_id' => $customer1->id,
                'customer_name' => $customer1->name,
                'customer_email' => $customer1->email,
                'customer_phone' => $customer1->phone,
                'shipping_address' => $customer1->address,
                'total_amount' => $orderTotal,
                'payment_method' => 'cod',
                'payment_status' => 'unpaid',
                'status' => 'pending',
                'note' => 'Giao hàng trong giờ hành chính giúp mình.',
            ]);

            OrderItem::create([
                'order_id' => $order->id,
                'book_id' => $sampleBooks[0]->id,
                'quantity' => 2,
                'price' => $sampleBooks[0]->price,
            ]);

            OrderItem::create([
                'order_id' => $order->id,
                'book_id' => $sampleBooks[1]->id,
                'quantity' => 1,
                'price' => $sampleBooks[1]->price,
            ]);

            // Giỏ hàng mẫu cho user@bookstore.vn
            $cart = Cart::create(['user_id' => $customer1->id]);
            CartItem::create([
                'cart_id' => $cart->id,
                'book_id' => $allBooks->last()->id,
                'quantity' => 1,
            ]);

            // Đánh giá mẫu
            Review::create([
                'user_id' => $customer1->id,
                'book_id' => $sampleBooks[0]->id,
                'rating' => 5,
                'comment' => 'Sách in rất đẹp, đóng gói cẩn thận, giao hàng nhanh!',
                'is_approved' => true,
            ]);

            Review::create([
                'user_id' => $customer2->id,
                'book_id' => $sampleBooks[1]->id,
                'rating' => 4,
                'comment' => 'Nội dung sách hay, rất đáng đọc.',
                'is_approved' => true,
            ]);
        }
    }
}
