<?php

namespace App\Http\Controllers\Peminjam;

use App\Http\Controllers\Controller;
use App\Models\Buku;
use App\Models\Peminjaman;
use App\Models\PeminjamanItem;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PeminjamanController extends Controller
{
    public function index(Request $request)
    {
        $perPage = (int) $request->get('per_page', 10);
        if (!in_array($perPage, [5,10,25,50,100])) {
            $perPage = 10;
        }

        $search    = $request->search;
        $status    = $request->status;
        $direction = $request->direction === 'asc' ? 'asc' : 'desc';

        $dateFrom = $request->date_from;
        $dateTo   = $request->date_to;

        $peminjamanItems = PeminjamanItem::with([
            'buku.kategoris',
            'peminjaman'
        ])
        ->whereHas('peminjaman', function ($q) {
            $q->where('id_user', Auth::id());
        })

        ->when($search, function ($q) use ($search) {
            $q->whereHas('buku', function ($sub) use ($search) {
                $sub->where('judul', 'like', "%{$search}%");
            });
        })

        ->when($status, function ($q) use ($status) {
            $q->whereHas('peminjaman', fn ($sub) =>
                $sub->where('status', $status)
            );
        })

        ->when($dateFrom, fn ($q) =>
            $q->whereHas('peminjaman', fn ($sub) =>
                $sub->whereDate('tgl_pinjam', '>=', $dateFrom)
            )
        )

        ->when($dateTo, fn ($q) =>
            $q->whereHas('peminjaman', fn ($sub) =>
                $sub->whereDate('tgl_pinjam', '<=', $dateTo)
            )
        )

        ->join('peminjamans', 'peminjaman_items.id_peminjaman', '=', 'peminjamans.id')
        ->orderByRaw("
            CASE 
                WHEN peminjamans.status = 'menunggu' THEN 0 
                ELSE 1 
            END
        ")
        ->orderBy('peminjamans.tgl_pinjam', $direction)

        ->select('peminjaman_items.*')
        ->paginate($perPage)
        ->withQueryString();

        if ($request->ajax()) {
        return view(
            'peminjam.peminjaman.partials.table', compact('peminjamanItems', 'perPage'))->render();
        }

        return view('peminjam.peminjaman.index', compact('peminjamanItems', 'perPage')
        );
    }

    public function create(Buku $buku)
    {
        $user = Auth::user();

        if (!$user->profilSiswa || !$user->dataSiswa) {
            return redirect()
                ->route('profile.show')
                ->with('error', 'Lengkapi profil dan data siswa terlebih dahulu.');
        }

        if ($user->dataSiswa->status !== 'aktif') {
            return back()->with('error', 'Akun Anda tidak aktif.');
        }

        if ($buku->stok <= 0) {
            return back()->with('error', 'Stok buku habis.');
        }

        return view('peminjam.peminjaman.create', compact('buku'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_buku' => ['required', 'exists:bukus,id'],
            'qty'     => ['required', 'integer', 'min:1'],
            'tgl_pinjam' => [
                'required',
                'date',
                'date_equals:today',
            ],
            'tgl_kembali' => [
                'required',
                'date',
                'after_or_equal:tgl_pinjam',
                function ($attr, $value, $fail) use ($request) {
                    $pinjam  = Carbon::parse($request->tgl_pinjam);
                    $kembali = Carbon::parse($value);

                    if ($pinjam->diffInDays($kembali) > 7) {
                        $fail('Durasi maksimal peminjaman adalah 7 hari.');
                    }

                    if ($kembali->isWeekend()) {
                        $fail('Tanggal kembali tidak boleh pada hari Sabtu atau Minggu.');
                    }
                }
            ],
        ], [
            'id_buku.required' => 'Silakan pilih buku yang ingin dipinjam.',
            'id_buku.exists' => 'Buku yang dipilih tidak ditemukan.',
            'qty.required' => 'Jumlah peminjaman wajib diisi.',
            'qty.integer' => 'Jumlah peminjaman harus berupa angka.',
            'qty.min' => 'Jumlah minimal peminjaman adalah 1.',
            'tgl_pinjam.required' => 'Tanggal pinjam wajib diisi.',
            'tgl_pinjam.date' => 'Tanggal pinjam tidak valid.',
            'tgl_pinjam.date_equals' => 'Tanggal pinjam harus hari ini.',
            'tgl_kembali.required' => 'Tanggal kembali wajib diisi.',
            'tgl_kembali.date' => 'Tanggal kembali tidak valid.',
            'tgl_kembali.after_or_equal' => 'Tanggal kembali tidak boleh sebelum tanggal pinjam.',
        ]);

        $buku = Buku::findOrFail($request->id_buku);

        if ($request->qty > $buku->stok) {
            return back()
                ->withErrors(['qty' => 'Jumlah yang diminta melebihi stok yang tersedia.'])
                ->withInput();
        }

        $stokMenunggu = PeminjamanItem::where('id_buku', $buku->id)
            ->whereHas('peminjaman', fn($q) => $q->where('status', 'menunggu'))
            ->sum('qty');

        if (($stokMenunggu + $request->qty) > $buku->stok) {
            return back()
                ->withErrors(['qty' => 'Sebagian stok sedang dalam proses peminjaman oleh pengguna lain. Silakan coba beberapa saat lagi.'])
                ->withInput();
        }

        $limit = Peminjaman::where('id_user', Auth::id())
            ->where('status', 'menunggu')
            ->count();

            if ($limit >= 3) {
                return back()->with('error', 'Terlalu banyak pengajuan. Tunggu proses sebelumnya.');
            }

        DB::transaction(function () use ($request, $buku) {

            $peminjaman = Peminjaman::create([
                'id_user'       => Auth::id(),
                'tgl_pinjam'    => $request->tgl_pinjam,
                'tgl_kembali'   => $request->tgl_kembali,
                'status'        => 'menunggu',
                'total_denda'   => 0,
                'status_denda'  => 'tidak_ada',
            ]);

            PeminjamanItem::create([
                'id_peminjaman' => $peminjaman->id,
                'id_buku'       => $request->id_buku,
                'qty'           => $request->qty,
            ]);

            logAktivitas(
                'Menambahkan',
                'Peminjaman',
                "Mengajukan peminjaman buku '{$buku->judul}' sebanyak {$request->qty} unit (Kode {$peminjaman->kode_peminjaman})"
            );
        });

        return redirect()
            ->route('peminjam.peminjaman.index')
            ->with('success', 'Pengajuan peminjaman berhasil diajukan. Silakan menunggu persetujuan dari petugas.');
    }

    public function show(Peminjaman $peminjaman)
    {
        if ($peminjaman->id_user !== Auth::id()) {
            abort(403);
        }

        $peminjaman->load([
            'user.profilSiswa.dataSiswa',
            'items.buku.kategoris',
            'approvedBy',
            'rejectedBy'
        ]);

        return view('peminjam.peminjaman.show', compact('peminjaman'));
    }

    public function batal(Peminjaman $peminjaman)
    {
        if ($peminjaman->id_user !== Auth::id()) {
            abort(403);
        }

        if ($peminjaman->status !== 'menunggu') {
            return back()->with('error', 'Peminjaman tidak dapat dibatalkan.');
        }

        $peminjaman->update([
            'status' => 'dibatalkan',
        ]);

        logAktivitas(
            'Mengubah',
            'Peminjaman',
            "Membatalkan pengajuan peminjaman (Kode {$peminjaman->kode_peminjaman})"
        );

        return back()->with('success', 'Pengajuan peminjaman berhasil dibatalkan.');
    }
}