<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ImportReceiptDetail extends Model
{
    use HasFactory;

    protected $fillable = [
        'import_receipt_id',
        'book_id',
        'quantity',
        'import_price',
    ];

    protected function casts(): array
    {
        return [
            'quantity' => 'integer',
            'import_price' => 'decimal:2',
        ];
    }

    public function importReceipt(): BelongsTo
    {
        return $this->belongsTo(ImportReceipt::class);
    }

    public function book(): BelongsTo
    {
        return $this->belongsTo(Book::class);
    }
}
