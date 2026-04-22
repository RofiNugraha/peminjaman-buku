<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Peminjaman;
use App\Models\PeminjamanItem;
use App\Models\User;
use App\Models\Buku;
use Illuminate\Support\Facades\DB;

class PeminjamanSeeder extends Seeder
{
    public function run(): void
    {
        $adminList = User::where('role', 'admin')->get();

        for ($i = 1; $i <= 120; $i++) {

            DB::transaction(function () use ($adminList) {

                $user = User::where('role', 'peminjam')
                    ->whereHas('profilSiswa.dataSiswa')
                    ->inRandomOrder()
                    ->first();

                $buku = Buku::where('stok', '>', 0)->inRandomOrder()->first();

                if (!$user || !$buku) return;

                $rand = rand(1, 100);

                $status = match (true) {
                    $rand <= 50 => 'menunggu',
                    $rand <= 75 => 'disetujui',
                    $rand <= 90 => 'dikembalikan',
                    default => 'ditolak',
                };

                $tglPinjam  = now()->subDays(rand(0, 5));
                $tglKembali = $tglPinjam->copy()->addDays(rand(3, 7));

                $qty = rand(1, min(2, $buku->stok));
                $admin = $adminList->isNotEmpty() ? $adminList->random() : null;

                $peminjaman = Peminjaman::create([
                    'kode_peminjaman' => 'PMJ-' . uniqid(),
                    'id_user'       => $user->id,
                    'tgl_pinjam'    => $tglPinjam,
                    'tgl_kembali'   => $tglKembali,
                    'status'        => $status,
                    'total_denda'   => 0,
                    'status_denda'  => 'tidak_ada',

                    // APPROVAL OLEH ADMIN
                    'approved_by' => in_array($status, ['disetujui', 'dikembalikan']) ? $admin?->id : null,
                    'approved_at' => in_array($status, ['disetujui', 'dikembalikan']) ? $tglPinjam->copy()->addHours(rand(1, 24)) : null,

                    'rejected_by' => $status === 'ditolak' ? $admin?->id : null,
                    'rejected_at' => $status === 'ditolak' ? $tglPinjam->copy()->addHours(rand(1, 24)) : null,
                ]);

                PeminjamanItem::create([
                    'id_peminjaman' => $peminjaman->id,
                    'id_buku'       => $buku->id,
                    'qty'           => $qty,
                ]);

                // stok berkurang saat disetujui
                if (in_array($status, ['disetujui', 'dikembalikan'])) {
                    $buku->decrement('stok', $qty);
                }

                // jika sudah dikembalikan
                if ($status === 'dikembalikan') {

                    // kemungkinan telat
                    $hariTelat = rand(0, 1) ? rand(1, 5) : 0;

                    $denda = $hariTelat * $buku->denda_per_hari;

                    $peminjaman->update([
                        'total_denda'  => $denda,
                        'status_denda' => $denda > 0 ? 'belum' : 'tidak_ada',
                    ]);

                    // stok kembali
                    $buku->increment('stok', $qty);
                }
            });
        }

        // DATA KHUSUS TERLAMBAT (BELUM DIKEMBALIKAN)
        for ($i = 1; $i <= 5; $i++) {

            DB::transaction(function () use ($adminList) {

                $user = User::where('role', 'peminjam')
                    ->whereHas('profilSiswa.dataSiswa')
                    ->inRandomOrder()
                    ->first();

                $buku = Buku::where('stok', '>', 0)->inRandomOrder()->first();

                if (!$user || !$buku) return;

                $admin = $adminList->isNotEmpty() ? $adminList->random() : null;

                $tglPinjam  = now()->subDays(rand(7, 10));
                $tglKembali = now()->subDays(rand(1, 3)); // sudah lewat

                $qty = 1;

                $peminjaman = Peminjaman::create([
                    'kode_peminjaman' => 'PMJ-' . uniqid(),
                    'id_user'       => $user->id,
                    'tgl_pinjam'    => $tglPinjam,
                    'tgl_kembali'   => $tglKembali,
                    'status'        => 'disetujui',
                    'total_denda'   => 0,
                    'status_denda'  => 'belum',

                    'approved_by'   => $admin?->id,
                    'approved_at'   => $tglPinjam->copy()->addHours(2),
                ]);

                PeminjamanItem::create([
                    'id_peminjaman' => $peminjaman->id,
                    'id_buku'       => $buku->id,
                    'qty'           => $qty,
                ]);

                $buku->decrement('stok', $qty);
            });
        }

        $this->command->info('Seeder peminjaman (admin-based) berhasil');
    }
}