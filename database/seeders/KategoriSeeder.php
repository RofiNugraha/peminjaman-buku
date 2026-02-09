<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Kategori;
use Illuminate\Support\Str;

class KategoriSeeder extends Seeder
{
    public function run(): void
    {
        $kategoris = [
            'Laptop',
            'Proyektor',
            'Kamera',
            'Printer',
            'Scanner',
            'Speaker',
            'Monitor',
            'Keyboard',
            'Mouse',
        ];

        foreach ($kategoris as $nama) {
            Kategori::create([
                'nama_kategori' => $nama,
                'keterangan' => 'Kategori untuk perangkat ' . strtolower($nama),
            ]);
        }
    }
}