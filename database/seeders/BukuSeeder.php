<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Buku;
use App\Models\Kategori;

class BukuSeeder extends Seeder
{
    public function run(): void
    {
        $kategoris = Kategori::all();

        foreach ($kategoris as $kategori) {
            $jumlahBuku = rand(3,6);

            for ($i=1; $i <= $jumlahBuku; $i++) {
                $denda = match(strtolower($kategori->nama_kategori)){
                    'kamera','elektronik' => 10000,
                    'proyektor' => 15000,
                    'laptop' => 20000,
                    default => 2000
                };

                Buku::create([
                    'kode_buku' => 'BUK-' . str_pad($kategori->id . $i, 3, '0', STR_PAD_LEFT),
                    'id_kategori'=>$kategori->id,
                    'judul'=>$kategori->nama_kategori.' '.$i,
                    'stok'=>rand(5,15),
                    'denda_per_hari'=>$denda,
                    'gambar'=>'buku/default.png'
                ]);
            }
        }
    }
}