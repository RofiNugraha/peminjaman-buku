<?php

namespace App\Services;

use App\Models\Peminjaman;

class LaporanPeminjamanService
{
    public function getData($request)
    {
        $dateType     = $request->get('date_type', 'tgl_pinjam');
        $startDate    = $request->start_date;
        $endDate      = $request->end_date;
        $status       = $request->status;
        $statusDenda  = $request->status_denda;
        $bukuId       = $request->buku_id;

        $query = Peminjaman::with([
            'user',
            'items.buku',
            'pengembalian.items.buku'
        ]);

        $query->when($startDate, function ($q) use ($dateType, $startDate) {
            if ($dateType === 'tgl_dikembalikan') {
                $q->whereHas('pengembalian', fn($sub) =>
                    $sub->whereDate('tgl_dikembalikan', '>=', $startDate)
                );
            } else {
                $q->whereDate($dateType, '>=', $startDate);
            }
        });

        $query->when($endDate, function ($q) use ($dateType, $endDate) {
            if ($dateType === 'tgl_dikembalikan') {
                $q->whereHas('pengembalian', fn($sub) =>
                    $sub->whereDate('tgl_dikembalikan', '<=', $endDate)
                );
            } else {
                $q->whereDate($dateType, '<=', $endDate);
            }
        });

        $query->when($status, fn($q) => $q->where('status', $status));
        $query->when($statusDenda, fn($q) => $q->where('status_denda', $statusDenda));

        $query->when($bukuId, function ($q) use ($bukuId) {
            $q->whereHas('items', function ($sub) use ($bukuId) {
                $sub->where('id_buku', $bukuId);
            });
        });

        return $query->latest()->get()->values();
    }

    public function query($request)
    {
        $dateType     = $request->get('date_type', 'tgl_pinjam');
        $startDate    = $request->start_date;
        $endDate      = $request->end_date;
        $status       = $request->status;
        $statusDenda  = $request->status_denda;
        $bukuId       = $request->buku_id;

        $query = Peminjaman::with([
            'user',
            'items.buku',
            'pengembalian'
        ]);

        $query->when($startDate && $endDate, function ($q) use ($dateType, $startDate, $endDate) {
            if ($dateType === 'tgl_dikembalikan') {
                $q->whereHas('pengembalian', function ($sub) use ($startDate, $endDate) {
                    $sub->whereBetween('tgl_dikembalikan', [$startDate, $endDate]);
                });
            } else {
                $q->whereBetween($dateType, [$startDate, $endDate]);
            }
        });

        $query->when($status, fn($q) => $q->where('status', $status));
        $query->when($statusDenda, fn($q) => $q->where('status_denda', $statusDenda));

        $query->when($bukuId, function ($q) use ($bukuId) {
            $q->whereHas('items', function ($sub) use ($bukuId) {
                $sub->where('id_buku', $bukuId);
            });
        });

        return $query;
    }
}