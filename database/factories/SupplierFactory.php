<?php

namespace Database\Factories;

use App\Models\Supplier;
use Illuminate\Database\Eloquent\Factories\Factory;

class SupplierFactory extends Factory
{
    protected $model = Supplier::class;

    public function definition(): array
    {
        return [
            'name' => 'Nhà cung cấp ' . fake()->company(),
            'email' => fake()->unique()->companyEmail(),
            'phone' => '0' . fake()->numerify('9########'),
            'tax_code' => fake()->numerify('010#######'),
            'address' => fake()->address(),
            'is_active' => fake()->boolean(85),
        ];
    }
}
