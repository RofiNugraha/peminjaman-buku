<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Peminjaman;
use App\Models\Buku;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class PeminjamanController extends Controller
{
    public function index(Request $request)
    {
        $perPage = (int) $request->get('per_page', 10);
        if (!in_array($perPage, [5,10,25,50,100])) $perPage = 10;

        $tab       = $request->get('tab', 'aktif');
        $search    = $request->search;
        $status    = $request->status;
        $direction = $request->direction === 'asc' ? 'asc' : 'desc';
        $dateFrom  = $request->date_from;
        $dateTo    = $request->date_to;

        if ($dateFrom) $dateFrom = Carbon::parse($dateFrom)->format('Y-m-d');
        if ($dateTo)   $dateTo   = Carbon::parse($dateTo)->format('Y-m-d');

        if ($dateFrom && $dateTo && $dateFrom > $dateTo) {
            [$dateFrom, $dateTo] = [$dateTo, $dateFrom];
        }

        $statusAktif = ['menunggu','disetujui'];
        $statusNonAktif = ['dibatalkan','ditolak','kadaluarsa','dikembalikan'];
        $statusFilter = $tab === 'aktif' ? $statusAktif : $statusNonAktif;

        $query = Peminjaman::with([
            'user.profilSiswa.dataSiswa',
            'items.buku.kategoris'
        ])->whereIn('status', $statusFilter);

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('kode_peminjaman', 'like', "%{$search}%")

                ->orWhereHas('user', function ($u) use ($search) {
                    $u->where('nama', 'like', "%{$search}%");
                })

                ->orWhereHas('user.profilSiswa.dataSiswa', function ($ds) use ($search) {
                    $ds->where('nama', 'like', "%{$search}%");
                });
            });
        }

        if ($status && in_array($status, $statusFilter)) {
            $query->where('status', $status);
        }

        if ($dateFrom && $dateTo) {
            $query->whereBetween(DB::raw('DATE(tgl_pinjam)'), [$dateFrom, $dateTo]);
        } elseif ($dateFrom) {
            $query->whereDate('tgl_pinjam', '>=', $dateFrom);
        } elseif ($dateTo) {
            $query->whereDate('tgl_pinjam', '<=', $dateTo);
        }

        $peminjamans = $query->orderBy('created_at', $direction)
            ->paginate($perPage)
            ->appends($request->only(['tab','search','status','date_from','date_to','direction','per_page']));

        if ($request->ajax()) {
            return view('admin.peminjaman.partials.table', compact('peminjamans','perPage','tab'))->render();
        }

        return view('admin.peminjaman.index', compact('peminjamans','perPage','tab'));
    }

    public function show($id)
    {
        $peminjaman = Peminjaman::with([
            'user.profilSiswa.dataSiswa',
            'items.buku.kategoris',
            'pengembalian.items.buku'
        ])->findOrFail($id);

        return view('admin.peminjaman.show', compact('peminjaman'));
    }

    public function approve(Peminjaman $peminjaman)
    {
        DB::transaction(function () use ($peminjaman) {

            $peminjaman = Peminjaman::where('id', $peminjaman->id)
                ->lockForUpdate()
                ->first();

            if (!$peminjaman->canBeApproved()) {
                abort(409, 'Pengajuan sudah diproses.');
            }

            if ($peminjaman->isExpired()) {
                abort(422, 'Peminjaman sudah kadaluarsa.');
            }

            $items = $peminjaman->items()
                ->with('buku')
                ->lockForUpdate()
                ->get();

            foreach ($items as $item) {
                if ($item->buku->stok < $item->qty) {
                    throw new \Exception("Stok buku '{$item->buku->judul}' tidak cukup");
                }
            }

            foreach ($items as $item) {
                Buku::where('id', $item->id_buku)
                    ->where('stok', '>=', $item->qty)
                    ->decrement('stok', $item->qty);
            }

            $peminjaman->update([
                'status'        => 'disetujui',
                'approved_by'   => Auth::id(),
                'approved_at'   => now(),
            ]);

            logAktivitas(
                'Mengubah',
                'Peminjaman',
                "Menyetujui pengajuan peminjaman buku (Kode {$peminjaman->kode_peminjaman})"
            );
        });

        return redirect()->route('admin.peminjaman.index')
            ->with('success','Pengajuan berhasil disetujui.');
    }

    public function reject(Peminjaman $peminjaman)
    {
        if (!$peminjaman->canBeApproved()) {
            return back()->with('error', 'Pengajuan tidak dapat ditolak.');
        }

        if ($peminjaman->isExpired()) {
            return back()->with('error', 'Peminjaman sudah kadaluarsa.');
        }

        $peminjaman->update([
            'status'        => 'ditolak',
            'rejected_by'   => Auth::id(),
            'rejected_at'   => now(),
        ]);

        logAktivitas(
            'Mengubah',
            'Peminjaman',
            "Menolak pengajuan peminjaman buku (Kode {$peminjaman->kode_peminjaman})"
        );

        return redirect()->route('admin.peminjaman.index')
            ->with('success','Pengajuan berhasil ditolak.');
    }
}