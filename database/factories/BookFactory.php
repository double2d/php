<?php

namespace Database\Factories;

use App\Models\Book;
use App\Models\Category;
use App\Models\Supplier;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class BookFactory extends Factory
{
    protected $model = Book::class;

    public function definition(): array
    {
        $title = fake()->sentence(4);
        $price = fake()->numberBetween(60, 350) * 1000;
        $hasDiscount = fake()->boolean(40);

        return [
            'supplier_id' => Supplier::factory(),
            'category_id' => Category::inRandomOrder()->value('id') ?? Category::factory(),
            'title' => rtrim($title, '.'),
            'slug' => Str::slug($title) . '-' . fake()->unique()->numberBetween(1000, 99999),
            'author' => fake()->name(),
            'isbn' => '978-604-' . fake()->numerify('##-####-#'),
            'cover_image' => 'https://placehold.co/300x450/e2e8f0/1e293b?text=' . urlencode(Str::limit($title, 18)),
            'price' => $price,
            'sale_price' => $hasDiscount ? $price - 15000 : null,
            'stock_quantity' => fake()->numberBetween(10, 150),
            'pages' => fake()->numberBetween(120, 650),
            'published_year' => fake()->numberBetween(2019, 2026),
            'description' => fake()->paragraph(3),
            'is_featured' => fake()->boolean(30),
            'is_active' => true,
        ];
    }
}
