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

        if ($role === 'admin' || $role === 'petugas') {
            return view('dashboard.index', [
                'totalUser' => User::count(),
                'totalBuku' => Buku::count(),
                'peminjamanAktif' => Peminjaman::where('status', 'disetujui')->count(),
                'menungguApproval' => Peminjaman::where('status', 'menunggu')->count(),
                'pengembalianHariIni' => Pengembalian::whereDate('tgl_dikembalikan', now())->count(),
                'totalLog' => LogAktivitas::count(),
            ]);
        }

        return view('dashboard.index', [
            'totalPinjam' => Peminjaman::where('id_user', Auth::id())->count(),
            'aktif' => Peminjaman::where('id_user', Auth::id())->where('status', 'disetujui')->count(),
            'selesai' => Peminjaman::where('id_user', Auth::id())->where('status', 'dikembalikan')->count(),
            'totalDenda' => Peminjaman::where('id_user', Auth::id())->sum('total_denda'),
        ]);
    }
}