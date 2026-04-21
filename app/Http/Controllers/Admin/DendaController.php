<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Peminjaman;
use App\Models\Notification;
use App\Services\DendaService;
use Illuminate\Support\Facades\Mail;
use App\Mail\BuktiPelunasanMail;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;

class DendaController extends Controller
{
    public function index(Request $request)
    {
        $perPage = (int) $request->get('per_page', 10);
        if (!in_array($perPage, [5,10,25,50,100])) {
            $perPage = 10;
        }

        $search = $request->search;
        $status = $request->status_denda;
        $order  = $request->direction === 'asc' ? 'asc' : 'desc';

        $peminjamans = Peminjaman::with([
                'user',
                'items.buku'
            ])
            ->where('total_denda', '>', 0)
            ->where('status', 'dikembalikan')
            ->when($status, fn ($q) =>
                $q->where('status_denda', $status)
            )
            ->when($search, function ($q) use ($search) {
                $q->whereHas('user', fn ($u) =>
                    $u->where('nama', 'like', "%{$search}%")
                )->orWhereHas('items.buku', fn ($a) =>
                    $a->where('judul', 'like', "%{$search}%")
                )->orWhere('kode_peminjaman', 'like', "%{$search}%");
            })
            ->orderByRaw("CASE WHEN status_denda = 'belum' THEN 0 ELSE 1 END")
            ->orderBy('updated_at', $order)
            ->paginate($perPage)
            ->withQueryString();

        if ($request->ajax()) {
            return view('admin.denda.partials.table', compact('peminjamans', 'perPage'))->render();
        }

        return view('admin.denda.index', compact('peminjamans', 'perPage'));
    }

    public function show($id)
    {
        $peminjaman = Peminjaman::with([
            'user.profilSiswa.dataSiswa',
            'items.buku.kategoris',
            'pengembalian.items.buku'
        ])->findOrFail($id);

        if ($peminjaman->total_denda <= 0) {
            abort(404);
        }

        return view('admin.denda.show', compact('peminjaman'));
    }

    public function lunas(Peminjaman $peminjaman, DendaService $service)
    {
        try {
            $service->tandaiLunas($peminjaman);

            return back()->with('success', 
                'Denda berhasil dilunasi dan bukti pelunasan telah dikirim ke email.');
                
        } catch (\Throwable $e) {
            return back()->with('error', $e->getMessage());
        }
    }

    public function ingatkan(Peminjaman $peminjaman)
    {
        if ($peminjaman->status_denda === 'lunas') {
            return back()->with('error', 'Denda sudah lunas.');
        }

        if ($peminjaman->total_denda <= 0) {
            return back()->with('error', 'Tidak ada denda.');
        }

        Notification::create([
            'id_user' => $peminjaman->id_user,
            'judul'   => 'Pengingat Denda Buku',
            'pesan'   => 'Anda memiliki denda peminjaman buku sebesar Rp '
                        . number_format($peminjaman->total_denda, 0, ',', '.')
                        . '. Segera lakukan pembayaran.',
            'notifiable_id'   => $peminjaman->id,
            'notifiable_type' => Peminjaman::class,
        ]);

        return back()->with('success', 'Pengingat berhasil dikirim.');
    }

    public function kirimUlang(Peminjaman $peminjaman)
    {
        try {
            if ($peminjaman->status_denda !== 'lunas') {
                throw new \Exception('Denda belum lunas.');
            }

            $peminjaman->load(['user','pengembalian.items.buku']);

            Mail::to($peminjaman->user->email)
                ->send(new BuktiPelunasanMail($peminjaman));

            logAktivitas(
                'Mengirim',
                'Bukti Pelunasan',
                "Mengirim ulang bukti pelunasan denda buku (Kode {$peminjaman->kode_peminjaman}) ke {$peminjaman->user->email}"
            );

            return back()->with('success', 'Bukti pelunasan berhasil dikirim ulang.');

        } catch (\Throwable $e) {
            return back()->with('error', $e->getMessage());
        }
    }

    public function download(Peminjaman $peminjaman)
    {
        if ($peminjaman->status_denda !== 'lunas') {
            abort(403, 'Denda belum lunas.');
        }

        $peminjaman->load(['user','pengembalian.items.buku']);

        $pdf = Pdf::loadView('emails.bukti_pelunasan', [
            'peminjaman' => $peminjaman
        ]);

        return $pdf->download('bukti-pelunasan-'.$peminjaman->kode_peminjaman.'.pdf');
    }
}