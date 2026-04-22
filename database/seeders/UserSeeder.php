<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\DataSiswa;
use App\Models\ProfilSiswa;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        // Admin
        User::create([
            'nama' => 'Administrator',
            'username' => 'admin',
            'email' => 'admin@gmail.com',
            'password' => Hash::make('password'),
            'role' => 'admin',
        ]);

        $kelasList = ['X', 'XI', 'XII'];
        $jurusanList = ['PPLG', 'TPFL', 'BROADCASTING', 'ANIMASI', 'TO'];

        for ($i = 1; $i <= 30; $i++) {

            $user = User::create([
                'nama' => 'Siswa ' . $i,
                'username' => 'user' . $i,
                'email' => 'user' . $i . '@gmail.com',
                'password' => Hash::make('password'),
                'role' => 'peminjam',
            ]);

            $dataSiswa = DataSiswa::create([
                'nisn' => '10' . str_pad($i, 8, '0', STR_PAD_LEFT),
                'nama' => $user->nama,
                'kelas' => collect($kelasList)->random(),
                'jurusan' => collect($jurusanList)->random(),
                'tahun_angkatan' => 2024,
                'tahun_ajaran' => '2024/2025',
                'status' => 'aktif',
            ]);

            ProfilSiswa::create([
                'user_id' => $user->id,
                'nisn' => $dataSiswa->nisn,
                'no_hp' => '08' . rand(1000000000, 9999999999),
                'no_hp_ortu' => '08' . rand(1000000000, 9999999999),
                'alamat' => 'Alamat Siswa ' . $i,
            ]);
        }
    }
}