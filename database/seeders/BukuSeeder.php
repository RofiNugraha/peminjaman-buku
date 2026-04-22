<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Buku;
use App\Models\Kategori;
use Illuminate\Support\Str;

class BukuSeeder extends Seeder
{
    public function run(): void
    {
        $kelasList = [10, 11, 12];
        $semesterList = [1, 2];

        $penerbitList = [
            'Kemendikbud',
            'Erlangga',
            'Yudhistira',
            'Gramedia',
        ];

        $kategoris = Kategori::all();

        foreach ($kategoris as $kategori) {

            foreach ($kelasList as $kelas) {
                foreach ($semesterList as $semester) {

                    $judul = "Buku {$kategori->nama_kategori} Kelas {$kelas} Semester {$semester}";

                    $kode = 'BK-' 
                        . strtoupper(substr($kategori->nama_kategori, 0, 3))
                        . "-{$kelas}{$semester}-"
                        . rand(100, 999);

                    $stok = rand(15, 40);

                    $denda = 1000;

                    // 🔥 TAMBAHAN SESUAI MIGRASI
                    $penulis = "Tim Penulis {$kategori->nama_kategori}";
                    $penerbit = collect($penerbitList)->random();
                    $tahunTerbit = rand(2018, 2024);

                    Buku::create([
                        'kode_buku' => $kode,
                        'id_kategori' => $kategori->id,
                        'judul' => $judul,
                        'penulis' => $penulis,
                        'penerbit' => $penerbit,
                        'tahun_terbit' => $tahunTerbit,
                        'stok' => $stok,
                        'denda_per_hari' => $denda,
                        'gambar' => 'buku/default.png',
                    ]);
                }
            }
        }
    }
}