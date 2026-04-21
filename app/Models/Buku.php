<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Buku extends Model
{
    protected $table = 'bukus';

    protected $fillable = [
        'kode_buku',
        'id_kategori',
        'judul',
        'stok',
        'gambar',
        'denda_per_hari',
        'penulis',
        'penerbit',
        'tahun_terbit',
    ];

    protected static function booted()
    {
        static::creating(function ($buku) {

            $last = self::orderBy('id', 'desc')->first();
            $number = $last ? ((int) substr($last->kode_buku, -3)) + 1 : 1;

            $buku->kode_buku = 'BUK-' . str_pad($number, 3, '0', STR_PAD_LEFT);
        });
    }

    public function kategoris()
    {
        return $this->belongsTo(Kategori::class, 'id_kategori');
    }

    public function peminjamans()
    {
        return $this->hasMany(Peminjaman::class, 'id_buku');
    }

    public function peminjamanItems()
    {
        return $this->hasMany(PeminjamanItem::class, 'id_buku');
    }

    public function pengembalianItems()
    {
        return $this->hasMany(PengembalianItem::class, 'id_buku');
    }
}