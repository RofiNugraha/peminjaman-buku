@extends('layouts.app')

@section('title', 'Detail Peminjaman Buku')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="mb-1">Detail Peminjaman Buku</h3>
        <p class="text-muted mb-0">Informasi lengkap peminjaman buku</p>
    </div>

    <a href="{{ route('admin.peminjaman.index') }}" class="btn btn-secondary">
        Kembali
    </a>
</div>

@php
$user = $peminjaman->user;
$profil = $user->profilSiswa ?? null;
$dataSiswa = $profil->dataSiswa ?? null;

$colors = [
    'menunggu' => 'warning',
    'disetujui' => 'success',
    'ditolak' => 'danger',
    'dibatalkan' => 'secondary',
    'dikembalikan' => 'info',
    'kadaluarsa' => 'dark'
];

$isMenunggu = $peminjaman->status === 'menunggu';
$isExpired = method_exists($peminjaman, 'isExpired') ? $peminjaman->isExpired() : false;
$stokCukup = $peminjaman->items->every(fn($i) => $i->buku->stok >= $i->qty);
@endphp

<div class="row g-4 mb-5">

    <!-- PROFIL -->
    <div class="col-lg-4">
        <div class="card text-center">
            <div class="card-body">
                <img src="{{ $profil && $profil->foto ? asset('storage/'.$profil->foto) : asset('storage/profil/default.png') }}"
                    class="rounded-circle mb-3" width="110" height="110" style="object-fit:cover;">

                <h5 class="fw-semibold mb-1">{{ $user->nama }}</h5>
                <span class="badge bg-warning bg-opacity-10 text-warning mb-2">
                    Siswa / Anggota
                </span>
                <p class="text-muted small mb-0">{{ $user->email }}</p>
            </div>
        </div>
    </div>

    <!-- INFORMASI PEMINJAMAN -->
    <div class="col-lg-8">
        <div class="card h-100">
            <div class="card-body">
                <h6 class="fw-semibold mb-3">Informasi Peminjaman</h6>
                <div class="row gy-3">
                    <div class="col-md-6">
                        <label class="form-label small text-muted">Kode Peminjaman</label>
                        <div class="fw-medium">{{ $peminjaman->kode_peminjaman }}</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">Status</label>
                        <div>
                            <span class="badge bg-{{ $colors[$peminjaman->status] }} bg-opacity-10 text-{{ $colors[$peminjaman->status] }}">
                                {{ ucfirst($peminjaman->status) }}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">Tanggal Pinjam</label>
                        <div>{{ $peminjaman->tgl_pinjam->format('d M Y') }}</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">Tanggal Kembali</label>
                        <div>{{ $peminjaman->tgl_kembali->format('d M Y') }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- DAFTAR BUKU -->
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h6 class="fw-semibold mb-3">Daftar Buku Dipinjam</h6>
                <div class="table-responsive">
                    <table class="table table-modern align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Judul Buku</th>
                                <th>Kategori</th>
                                <th width="120">Jumlah</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($peminjaman->items as $item)
                            <tr>
                                <td class="fw-medium">{{ $item->buku->judul }}</td>
                                <td class="text-muted">{{ $item->buku->kategoris->nama_kategori ?? '-' }}</td>
                                <td>{{ $item->qty }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    @if($peminjaman->pengembalian)
    <!-- PENGEMBALIAN -->
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h6 class="fw-semibold mb-3">Data Pengembalian</h6>
                <div class="row gy-3 mb-3">
                    <div class="col-md-4">
                        <label class="form-label small text-muted">Tanggal Dikembalikan</label>
                        <div>{{ \Carbon\Carbon::parse($peminjaman->pengembalian->tgl_dikembalikan)->format('d M Y') }}</div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted">Hari Telat</label>
                        <div>{{ $peminjaman->pengembalian->hari_telat }} hari</div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted">Denda Telat</label>
                        <div>Rp {{ number_format($peminjaman->pengembalian->denda_telat,0,',','.') }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    @endif

    <!-- DATA SISWA -->
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h6 class="fw-semibold mb-3">Data Siswa</h6>
                <div class="row gy-3">
                    <div class="col-md-4">
                        <label class="form-label small text-muted">NISN</label>
                        <div>{{ $dataSiswa->nisn ?? '-' }}</div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted">Nama</label>
                        <div>{{ $dataSiswa->nama ?? '-' }}</div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small text-muted">Kelas</label>
                        <div>{{ $dataSiswa->kelas ?? '-' }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- ACTION BAR -->
<div class="position-fixed bottom-0 start-0 end-0 bg-white border-top p-3 shadow" style="z-index: 1000;">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="text-muted small">
            @if(!$isMenunggu)
                Status: <span class="fw-semibold text-primary">{{ ucfirst($peminjaman->status) }}</span>
            @elseif($isExpired)
                <span class="text-danger fw-semibold">Pengajuan sudah kadaluarsa</span>
            @endif
        </div>

        <div class="d-flex gap-2">
            @if($isMenunggu && !$isExpired)
                @if(!$stokCukup)
                    <button class="btn btn-secondary btn-sm" disabled>Stok Tidak Cukup</button>
                @else
                    <form method="POST" action="{{ route('admin.peminjaman.approve', $peminjaman->id) }}" class="d-inline">
                        @csrf
                        <button type="submit" class="btn btn-success btn-sm confirm-action" data-title="Setujui Peminjaman?">
                            Setujui
                        </button>
                    </form>
                @endif

                <form method="POST" action="{{ route('admin.peminjaman.reject', $peminjaman->id) }}" class="d-inline">
                    @csrf
                    <button type="submit" class="btn btn-danger btn-sm confirm-action" data-title="Tolak Peminjaman?">
                        Tolak
                    </button>
                </form>
            @endif
        </div>
    </div>
</div>

@push('scripts')
<script>
$('.confirm-action').click(function(e) {
    e.preventDefault();
    const form = $(this).closest('form');
    const title = $(this).data('title');

    Swal.fire({
        title: title,
        text: "Tindakan ini tidak dapat dibatalkan",
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Ya, Lanjutkan'
    }).then((result) => {
        if (result.isConfirmed) {
            form.submit();
        }
    });
});
</script>
@endpush
@endsection