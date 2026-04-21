<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Buku;
use App\Models\Kategori;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class BukuController extends Controller
{
    public function index(Request $request)
    {
        $perPage  = in_array($request->per_page, [5, 10, 25, 50, 100]) ? $request->per_page : 10;
        $search   = $request->search;
        $kategori = $request->kategori;
        $order    = in_array($request->order, ['asc', 'desc']) ? $request->order : 'desc';

        $query = Buku::with('kategoris');

        if ($search) {
            $query->where('judul', 'like', "%{$search}%");
        }

        if ($kategori) {
            $query->where('id_kategori', $kategori);
        }

        $bukus = $query
            ->orderBy('created_at', $order)
            ->paginate($perPage)
            ->withQueryString();

        $kategoris = Kategori::orderBy('nama_kategori')->get();

        if ($request->ajax()) {
            return view('admin.buku.partials.table', compact('bukus', 'perPage'))->render();
        }

        return view('admin.buku.index', compact('bukus', 'kategoris', 'perPage'));
    }

    public function create()
    {
        $kategoris = Kategori::orderBy('nama_kategori')->get();
        return view('admin.buku.create', compact('kategoris'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_kategori'   => 'required|exists:kategoris,id',
            'judul'     => 'required|string|max:100',
            'penulis'       => 'required|string|max:100',
            'penerbit'      => 'required|string|max:100',
            'tahun_terbit'  => 'required|integer|min:1900|max:'.date('Y'),
            'stok'          => 'required|integer|min:0',
            'denda_per_hari' => 'required|integer|min:0',
            'gambar'        => 'required|image|mimes:jpg,jpeg,png|max:2048',
        ], [
            'id_kategori.required' => 'Kategori wajib dipilih.',
            'id_kategori.exists'   => 'Kategori tidak valid.',

            'judul.required' => 'Judul buku wajib diisi.',
            'judul.string'   => 'Judul buku harus berupa teks.',
            'judul.max'      => 'Judul buku maksimal 100 karakter.',

            'penulis.required' => 'Penulis wajib diisi.',
            'penerbit.required' => 'Penerbit wajib diisi.',
            'tahun_terbit.required' => 'Tahun terbit wajib diisi.',
            'tahun_terbit.integer' => 'Tahun terbit harus berupa angka.',

            'stok.required' => 'Stok wajib diisi.',
            'stok.integer'  => 'Stok tidak valid dan harus berupa angka.',
            'stok.min'      => 'Stok tidak boleh kurang dari 0.',

            'denda_per_hari.required' => 'Harga Denda wajib diisi.',
            'denda_per_hari.integer'  => 'Harga Denda tidak valid dan harus berupa angka.',
            'denda_per_hari.min'      => 'Harga Denda tidak boleh kurang dari 0.',

            'gambar.required' => 'Gambar buku wajib diunggah.',
            'gambar.image'    => 'File harus berupa gambar.',
            'gambar.mimes'    => 'Format gambar harus JPG, JPEG, atau PNG.',
            'gambar.max'      => 'Ukuran gambar maksimal 2 MB.',
        ]);

        $path = $request->file('gambar')->store('buku', 'public');

        $buku = Buku::create([
            'id_kategori'       => $request->id_kategori,
            'judul'         => $request->judul,
            'penulis'           => $request->penulis,
            'penerbit'          => $request->penerbit,
            'tahun_terbit'      => $request->tahun_terbit,
            'stok'              => $request->stok,
            'denda_per_hari'    => $request->denda_per_hari,
            'gambar'            => $path,
        ]);

        logAktivitas(
            'Menambahkan',
            'Buku',
            "Menambahkan buku '{$buku->judul}' (Kode Buku {$buku->kode_buku}) dengan stok {$buku->stok} dan denda Rp{$buku->denda_per_hari}/hari"
        );

        return redirect()->route('buku.index')->with('success', 'Buku berhasil ditambahkan.');
    }

    public function edit(Buku $buku)
    {
        $kategoris = Kategori::orderBy('nama_kategori')->get();
        return view('admin.buku.edit', compact('buku', 'kategoris'));
    }

    public function show(Buku $buku)
    {
        return view('admin.buku.show', compact('buku'));
    }

    public function update(Request $request, Buku $buku)
    {
        $request->validate([
            'id_kategori'       => 'required|exists:kategoris,id',
            'judul'         => 'required|string|max:100',
            'penulis'           => 'required|string|max:100',
            'penerbit'          => 'required|string|max:100',
            'tahun_terbit'      => 'required|integer|min:1900|max:'.date('Y'),
            'stok'              => 'required|integer|min:0',
            'denda_per_hari'    => 'required|integer|min:0',
            'gambar'            => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ], [
            'id_kategori.required' => 'Kategori wajib dipilih.',
            'id_kategori.exists'   => 'Kategori tidak valid.',

            'judul.required' => 'Judul buku wajib diisi.',
            'judul.max'      => 'Judul buku maksimal 100 karakter.',

            'penulis.required' => 'Penulis wajib diisi.',
            'penerbit.required' => 'Penerbit wajib diisi.',
            'tahun_terbit.required' => 'Tahun terbit wajib diisi.',

            'stok.required' => 'Stok wajib diisi.',
            'stok.integer'  => 'Stok tidak valid dan harus berupa angka.',
            'stok.min'      => 'Stok tidak boleh kurang dari 0.',

            'denda_per_hari.required' => 'Harga Denda wajib diisi.',
            'denda_per_hari.integer'  => 'Harga Denda tidak valid dan harus berupa angka.',
            'denda_per_hari.min'      => 'Harga Denda tidak boleh kurang dari 0.',

            'gambar.image' => 'File harus berupa gambar.',
            'gambar.mimes' => 'Format gambar harus JPG, JPEG, atau PNG.',
            'gambar.max'   => 'Ukuran gambar maksimal 2 MB.',
        ]);

        $namaLama  = $buku->judul;
        $stokLama  = $buku->stok;
        $dendaLama = $buku->denda_per_hari;

        $data = $request->only([
            'id_kategori',
            'judul',
            'penulis',
            'penerbit',
            'tahun_terbit',
            'stok',
            'denda_per_hari',
        ]);

        if ($request->hasFile('gambar')) {
            if ($buku->gambar && Storage::disk('public')->exists($buku->gambar)) {
                Storage::disk('public')->delete($buku->gambar);
            }

            $data['gambar'] = $request->file('gambar')->store('buku', 'public');
        }

        $buku->update($data);

        logAktivitas(
            'Mengubah',
            'Buku',
            "Mengubah buku '{$namaLama}' (Kode Buku {$buku->kode_buku}) menjadi '{$buku->judul}', stok {$stokLama}→{$buku->stok}, denda Rp{$dendaLama}→Rp{$buku->denda_per_hari}/hari"
        );

        return redirect()->route('buku.index')->with('success', 'Buku berhasil diperbarui.');
    }

    public function destroy(Buku $buku)
    {
        if ($buku->peminjamanItems()->exists()) {
            return back()->with('error', 'Buku tidak dapat dihapus karena memiliki riwayat peminjaman.');
        }

        $nama  = $buku->judul;
        $kode_buku    = $buku->kode_buku;
        $stok  = $buku->stok;

        if ($buku->gambar && Storage::disk('public')->exists($buku->gambar)) {
            Storage::disk('public')->delete($buku->gambar);
        }

        $buku->delete();

        logAktivitas(
            'Menghapus',
            'Buku',
            "Menghapus buku '{$nama}' (Kode Buku {$kode_buku}) dengan stok terakhir {$stok}"
        );

        return redirect()->route('buku.index')->with('success', 'Buku berhasil dihapus.');
    }
}