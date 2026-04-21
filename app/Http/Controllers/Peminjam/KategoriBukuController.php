<?php

namespace App\Http\Controllers\Peminjam;

use App\Http\Controllers\Controller;
use App\Models\Kategori;
use Illuminate\Http\Request;

class KategoriBukuController extends Controller
{
    public function index(Request $request)
    {
        $perPage = (int) $request->get('per_page', 8);
        if (!in_array($perPage, [4,8,12,16])) $perPage = 8;

        $search = trim($request->search);

        $kategoris = Kategori::withCount([
            'bukus as total_stok' => function ($q) {
                $q->where('stok', '>', 0);
            }
        ])
        ->when($search, function ($q) use ($search) {
            $q->where('nama_kategori', 'like', "%{$search}%");
        })
        ->orderBy('nama_kategori')
        ->paginate($perPage)
        ->appends([
            'search' => $search,
            'per_page' => $perPage
        ])
        ->withQueryString();

        if ($request->ajax()) {
            return view('peminjam.kategori._list', compact('kategoris'))->render();
        }

        return view('peminjam.kategori.index', compact('kategoris', 'perPage'));
    }

    public function show(Request $request, Kategori $kategori)
    {
        $perPage = (int) $request->get('per_page', 8);
        if (!in_array($perPage, [4,8,12,16])) $perPage = 8;

        $search = trim($request->search);

        $bukus = $kategori->bukus()
            ->when($search, function ($q) use ($search) {
                $q->where('judul', 'like', "%{$search}%");
            })
            ->orderBy('judul', 'asc')
            ->paginate($perPage)
            ->appends([
                'search' => $search,
                'per_page' => $perPage
            ])
            ->withQueryString();

        if ($request->ajax()) {
            return view('peminjam.kategori._buku_list', compact('bukus'))->render();
        }

        return view('peminjam.kategori.show', compact('kategori', 'bukus', 'perPage'));
    }
}