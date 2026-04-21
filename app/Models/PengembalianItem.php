<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PengembalianItem extends Model
{
    protected $table = 'pengembalian_items';

    protected $fillable = [
        'id_pengembalian',
        'id_buku',
        'qty_baik',
        'qty_hilang',
        'qty_rusak',
        'denda',
    ];

    protected $casts = [
        'denda' => 'integer',
    ];

    public function buku()
    {
        return $this->belongsTo(Buku::class, 'id_buku');
    }

    public function kategoris()
    {
        return $this->belongsTo(Kategori::class, 'id_kategori');
    }

    public function pengembalians()
    {
        return $this->belongsTo(Pengembalian::class, 'id_pengembalian');
    }
}