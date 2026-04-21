@extends('layouts.app')

@section('title', 'Ajukan Peminjaman Buku')

@section('content')
<div class="page-header mb-4">
    <h3 class="mb-1">Ajukan Peminjaman Buku</h3>
    <p class="mb-0">Isi data peminjaman buku dengan benar</p>
</div>

@if(session('error'))
<div class="alert alert-danger">
    {{ session('error') }}
</div>
@endif

<div class="row g-4">

    <div class="col-lg-4">
        <div class="card">
            <div class="card-body text-center">

                <img src="{{ asset('storage/'.$buku->gambar) }}" class="rounded mb-3 shadow-sm" width="100" height="130" style="object-fit: cover;">

                <h6 class="fw-semibold mb-3">Detail Buku</h6>
                <div class="text-muted small mb-3">{{ $buku->penulis }}</div>

                <div class="text-muted small">
                    Stok: {{ $buku->stok }} <br>
                    Denda: Rp {{ number_format($buku->denda_per_hari,0,',','.') }}/hari
                </div>

            </div>
        </div>
    </div>

    <div class="col-lg-8">
        <div class="card">
            <div class="card-body">

                <form id="formPeminjaman" method="POST" action="{{ route('peminjam.peminjaman.store') }}">
                    @csrf
                    <input type="hidden" name="id_buku" value="{{ $buku->id }}">

                    <div class="row g-3">

                        <div class="col-md-6">
                            <label class="form-label">Tanggal Pinjam</label>
                            <input type="date" name="tgl_pinjam"
                                class="form-control @error('tgl_pinjam') is-invalid @enderror"
                                value="{{ old('tgl_pinjam') }}" min="{{ now()->toDateString() }}">
                            @error('tgl_pinjam')
                            <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Tanggal Kembali</label>
                            <input type="date" name="tgl_kembali"
                                class="form-control @error('tgl_kembali') is-invalid @enderror"
                                value="{{ old('tgl_kembali') }}">
                            @error('tgl_kembali')
                            <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Jumlah</label>
                            <input type="number" name="qty" class="form-control @error('qty') is-invalid @enderror"
                                value="{{ old('qty',1) }}" min="1" max="{{ $buku->stok }}">
                            @error('qty')
                            <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                    </div>

                    <div class="d-flex justify-content-end mt-4 gap-2">
                        <a href="{{ route('peminjam.peminjaman.index') }}" class="btn btn-secondary">
                            Batal
                        </a>
                        <button id="btnPinjam" class="btn btn-primary">
                            Ajukan
                        </button>
                    </div>

                </form>

            </div>
        </div>
    </div>

</div>

<script>
document.querySelector('[name="tgl_pinjam"]').addEventListener('change', function() {
    const kembali = document.querySelector('[name="tgl_kembali"]');
    kembali.min = this.value;
    kembali.value = '';
});

document.getElementById('formPeminjaman').addEventListener('submit', function() {
    const btn = document.getElementById('btnPinjam');
    btn.disabled = true;
    btn.innerText = 'Memproses...';
});
</script>

@endsection