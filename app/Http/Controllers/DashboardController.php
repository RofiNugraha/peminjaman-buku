<?php

namespace App\Http\Controllers;

use App\Models\Buku;
use App\Models\LogAktivitas;
use App\Models\Peminjaman;
use App\Models\Pengembalian;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index()
    {
        $role = Auth::user()->role;
        
        $peminjamanPerBulan = Peminjaman::select(
            DB::raw('MONTH(tgl_pinjam) as bulan'),
            DB::raw('COUNT(*) as total')
        )->whereYear('tgl_pinjam', now()->year)->groupBy('bulan')->orderBy('bulan')->pluck('total', 'bulan');

        $peminjamanPerBulanFix = collect(range(1, 12))->map(function ($bulan) use ($peminjamanPerBulan) {
            return $peminjamanPerBulan[$bulan] ?? 0;
        });
        
        $bukuPopuler = DB::table('peminjaman_items')->join(
            'bukus', 'peminjaman_items.id_buku', '=', 'bukus.id'
        )->select(
            'bukus.judul', DB::raw('SUM(qty) as total')
            )
            ->groupBy('bukus.judul')
            ->orderByDesc('total')
            ->limit(5)
            ->get();
            
        $terlambat = Peminjaman::where('status', 'disetujui')
            ->whereDate('tgl_kembali', '<', now())
            ->count();
            
        $totalDendaBelum = Peminjaman::where('status_denda', 'belum')
            ->sum('total_denda');
            
        $userAktif = Peminjaman::select('id_user', DB::raw('COUNT(*) as total'))
            ->groupBy('id_user')
            ->orderByDesc('total')
            ->with('user')
            ->limit(5)
            ->get();
            
        $stokMenipis = Buku::where('stok', '<', 5)->count();

        $statusPeminjaman = Peminjaman::select('status', DB::raw('COUNT(*) as total'))
            ->groupBy('status')
            ->pluck('total', 'status');

        if ($role === 'admin' || $role === 'petugas') {
            return view('dashboard.index', [
                'totalUser' => User::count(),
                'totalBuku' => Buku::count(),
                'peminjamanAktif' => Peminjaman::where('status', 'disetujui')->count(),
                'menungguApproval' => Peminjaman::where('status', 'menunggu')->count(),
                'pengembalianHariIni' => Pengembalian::whereDate('tgl_dikembalikan', now())->count(),
                'totalLog' => LogAktivitas::count(),
                'peminjamanPerBulan' => $peminjamanPerBulanFix,
                'bukuPopuler' => $bukuPopuler,
                'totalDendaBelum' => $totalDendaBelum,
                'userAktif' => $userAktif,
                'stokMenipis' => $stokMenipis,
                'terlambat' => $terlambat,
                'statusPeminjaman' => $statusPeminjaman,
            ]);
        }

        return view('dashboard.index', [
            'totalPinjam' => Peminjaman::where('id_user', Auth::id())->count(),
            'aktif' => Peminjaman::where('id_user', Auth::id())->where('status', 'disetujui')->count(),
            'selesai' => Peminjaman::where('id_user', Auth::id())->where('status', 'dikembalikan')->count(),
            'jumlahDenda' => Peminjaman::where('id_user', Auth::id())->where('status_denda', 'belum')->count(),
            'telat' => Peminjaman::where('id_user', Auth::id()) ->where('status', 'disetujui')->whereDate('tgl_kembali', '<', now())->count(),
            'jatuhTempo' => Peminjaman::where('id_user', Auth::id())->where('status', 'disetujui')->whereBetween('tgl_kembali', [now(), now()->addDays(3)])->count(),
            'totalBukuDipinjam' => DB::table('peminjaman_items')->join('peminjamans', 'peminjaman_items.id_peminjaman', '=', 'peminjamans.id')->where('peminjamans.id_user', Auth::id())->sum('qty'),
            'lastPinjam' => Peminjaman::where('id_user', Auth::id())->latest()->take(3)->get(),
            'lastActivity' => LogAktivitas::where('id_user', Auth::id())->latest('waktu')   ->first(),
        ]);
    }
}