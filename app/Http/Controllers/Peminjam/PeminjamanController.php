<?php

namespace App\Http\Controllers\Peminjam;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Peminjaman;
use App\Models\Alat;
use Illuminate\Support\Facades\Auth;

class PeminjamanController extends Controller
{
    // Wajib login
    public function __construct()
    {
        $this->middleware('auth');
    }

    // List peminjaman user login
    public function index()
    {
        $peminjamans = Peminjaman::where('id_user', Auth::id())
            ->with('alat')
            ->orderBy('created_at', 'desc')
            ->get();

        return view('peminjam.peminjaman.index', compact('peminjamans'));
    }

    // Form tambah peminjaman
    public function create()
    {
        $alats = Alat::all();
        return view('peminjam.peminjaman.create', compact('alats'));
    }

    // Simpan peminjaman
    public function store(Request $request)
    {
        $request->validate([
            'id_alat'     => 'required|exists:alats,id',
            'tgl_pinjam'  => 'required|date',
            'tgl_kembali' => 'required|date|after_or_equal:tgl_pinjam',
        ]);

        Peminjaman::create([
            'id_user'     => Auth::id(),
            'id_alat'     => $request->id_alat,
            'tgl_pinjam'  => $request->tgl_pinjam,
            'tgl_kembali' => $request->tgl_kembali,
            'status'      => 'menunggu',
        ]);

        return redirect()->route('peminjaman.index')
            ->with('success', 'Peminjaman berhasil diajukan');
    }

    // Detail peminjaman (OPSIONAL – hapus kalau tidak dipakai)
    public function show($id)
    {
        $peminjaman = Peminjaman::where('id_user', Auth::id())
            ->with('alat')
            ->findOrFail($id);

        return view('peminjam.peminjaman.show', compact('peminjaman'));
    }

    // Batalkan peminjaman
    public function destroy($id)
    {
        $peminjaman = Peminjaman::where('id_user', Auth::id())
            ->where('status', 'menunggu')
            ->findOrFail($id);

        $peminjaman->delete();

        return redirect()->route('peminjaman.index')
            ->with('success', 'Peminjaman dibatalkan');
    }
}
