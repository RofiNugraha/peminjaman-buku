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
            'Matematika',
            'Bahasa Indonesia',
            'Bahasa Inggris',
            'IPA',
            'Fisika',
            'Kimia',
            'Biologi',
            'IPS',
            'Sejarah',
            'Geografi',
            'Ekonomi',
            'PKN',
            'Informatika',
            'Seni Budaya',
            'PJOK',
        ];

        foreach ($kategoris as $nama) {
            Kategori::create([
                'nama_kategori' => $nama,
                'keterangan' => 'Buku mata pelajaran ' . $nama,
            ]);
        }
    }
}