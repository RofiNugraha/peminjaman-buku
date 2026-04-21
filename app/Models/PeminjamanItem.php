<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PeminjamanItem extends Model
{
    protected $table = 'peminjaman_items';

    protected $fillable = [
        'id_peminjaman',
        'id_buku',
        'qty'
    ];

    public function buku()
    {
        return $this->belongsTo(Buku::class, 'id_buku');
    }

    public function peminjaman()
    {
        return $this->belongsTo(Peminjaman::class, 'id_peminjaman');
    }
}