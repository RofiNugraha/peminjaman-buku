@extends('layouts.app')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="mb-1">Detail Buku</h3>
        <p class="text-muted mb-0">Informasi lengkap buku</p>
    </div>

    <a href="{{ route('buku.index') }}" class="btn btn-secondary">
        Kembali
    </a>
</div>

<div class="card">
    <div class="card-body">

        <div class="row g-4">

            <div class="col-md-4 text-center">
                <img src="{{ asset('storage/'.$buku->gambar) }}" class="rounded shadow-sm" width="200">
            </div>

            <div class="col-md-8">
                <div class="row gy-3">

                    <div class="col-md-6">
                        <label class="form-label small text-muted">Kode Buku</label>
                        <div class="fw-medium">{{ $buku->kode_buku }}</div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small text-muted">Judul</label>
                        <div class="fw-medium">{{ $buku->judul }}</div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small text-muted">Penulis</label>
                        <div>{{ $buku->penulis }}</div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small text-muted">Penerbit</label>
                        <div>{{ $buku->penerbit }}</div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small text-muted">Tahun Terbit</label>
                        <div>{{ $buku->tahun_terbit }}</div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small text-muted">Kategori</label>
                        <div>{{ $buku->kategoris->nama_kategori }}</div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small text-muted">Stok</label>
                        <div>{{ $buku->stok }}</div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small text-muted">Denda</label>
                        <div>Rp {{ number_format($buku->denda_per_hari) }}</div>
                    </div>

                </div>
            </div>

        </div>

    </div>
</div>
@endsection