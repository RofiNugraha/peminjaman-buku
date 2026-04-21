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
        // 1. Create Admin
        User::create([
            'nama' => 'Administrator',
            'username' => 'admin',
            'email' => 'admin@gmail.com',
            'password' => Hash::make('password'),
            'role' => 'admin',
        ]);

        // 2. Create Petugas
        User::create([
            'nama' => 'Petugas Perpustakaan',
            'username' => 'petugas',
            'email' => 'petugas@gmail.com',
            'password' => Hash::make('password'),
            'role' => 'petugas',
        ]);

        // 3. Create Peminjam (User)
        $user = User::create([
            'nama' => 'Siswa Perpustakaan',
            'username' => 'user',
            'email' => 'user@gmail.com',
            'password' => Hash::make('password'),
            'role' => 'peminjam',
        ]);

        // Create Data Siswa for this user
        $dataSiswa = DataSiswa::create([
            'nisn' => '1234567890',
            'nama' => 'Siswa Perpustakaan',
            'kelas' => 'XII',
            'jurusan' => 'RPL',
            'tahun_angkatan' => 2024,
            'tahun_ajaran' => '2024/2025',
            'status' => 'aktif',
        ]);

        // Create Profil Siswa for this user
        ProfilSiswa::create([
            'user_id' => $user->id,
            'nisn' => $dataSiswa->nisn,
            'no_hp' => '081234567890',
            'alamat' => 'Alamat Siswa',
        ]);
    }
}