@extends('layouts.app')

@section('title', 'Detail Denda Buku')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="mb-1">Detail Denda Buku</h3>
        <p class="text-muted mb-0">Informasi lengkap denda peminjaman buku</p>
    </div>

    <a href="{{ route('admin.denda.index') }}" class="btn btn-secondary">
        Kembali
    </a>
</div>

@php
$user = $peminjaman->user;
$profil = $user->profilSiswa ?? null;
$dataSiswa = $profil->dataSiswa ?? null;

$statusColor = [
    'belum' => 'danger',
    'lunas' => 'success',
    'tidak_ada' => 'secondary'
];
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

    <!-- INFORMASI DENDA -->
    <div class="col-lg-8">
        <div class="card h-100">
            <div class="card-body">
                <h6 class="fw-semibold mb-3">Informasi Denda</h6>
                <div class="row gy-3">
                    <div class="col-md-6">
                        <label class="form-label small text-muted">Kode Peminjaman</label>
                        <div class="fw-medium">{{ $peminjaman->kode_peminjaman }}</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">Status Denda</label>
                        <div>
                            <span class="badge bg-{{ $statusColor[$peminjaman->status_denda] }} bg-opacity-10 text-{{ $statusColor[$peminjaman->status_denda] }}">
                                {{ ucfirst($peminjaman->status_denda) }}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">Total Denda</label>
                        <div class="fw-semibold text-danger">
                            Rp {{ number_format($peminjaman->total_denda,0,',','.') }}
                        </div>
                    </div>
                </div>

                <div class="mt-4 d-flex flex-wrap gap-2">
                    @if($peminjaman->status_denda !== 'lunas')
                        <form action="{{ route('admin.denda.ingatkan', $peminjaman->id) }}" method="POST">
                            @csrf
                            <button type="submit" class="btn btn-secondary btn-sm confirm-action" data-title="Kirim Pengingat?">
                                Kirim Pengingat
                            </button>
                        </form>

                        <form action="{{ route('admin.denda.lunas', $peminjaman->id) }}" method="POST">
                            @csrf
                            <button type="submit" class="btn btn-primary btn-sm confirm-action" data-title="Tandai Lunas?">
                                Tandai Lunas
                            </button>
                        </form>
                    @else
                        <a href="{{ route('admin.denda.download', $peminjaman->id) }}" class="btn btn-success btn-sm">
                            Download Bukti
                        </a>

                        <form action="{{ route('admin.denda.kirimUlang', $peminjaman->id) }}" method="POST">
                            @csrf
                            <button type="submit" class="btn btn-primary btn-sm confirm-action" data-title="Kirim Ulang Bukti?">
                                Kirim Ulang Bukti
                            </button>
                        </form>
                    @endif
                </div>
            </div>
        </div>
    </div>

    <!-- DATA PENGEMBALIAN -->
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h6 class="fw-semibold mb-3">Daftar Buku Terkait</h6>
                <div class="table-responsive">
                    <table class="table table-modern align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Judul Buku</th>
                                <th class="text-center">Baik</th>
                                <th class="text-center">Rusak</th>
                                <th class="text-center">Hilang</th>
                                <th width="150">Denda</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if($peminjaman->pengembalian)
                                @foreach($peminjaman->pengembalian->items as $item)
                                <tr>
                                    <td class="fw-medium">{{ $item->buku->judul ?? '-' }}</td>
                                    <td class="text-center">{{ $item->qty_baik }}</td>
                                    <td class="text-center">{{ $item->qty_rusak }}</td>
                                    <td class="text-center">{{ $item->qty_hilang }}</td>
                                    <td>Rp {{ number_format($item->denda,0,',','.') }}</td>
                                </tr>
                                @endforeach
                            @else
                                @foreach($peminjaman->items as $item)
                                <tr>
                                    <td class="fw-medium">{{ $item->buku->judul }}</td>
                                    <td colspan="3" class="text-center text-muted">Belum dikembalikan</td>
                                    <td>-</td>
                                </tr>
                                @endforeach
                            @endif
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

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

                    <div class="col-md-4">
                        <label class="form-label small text-muted">Jurusan</label>
                        <div>{{ $dataSiswa->jurusan ?? '-' }}</div>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label small text-muted">Angkatan</label>
                        <div>{{ $dataSiswa->tahun_angkatan ?? '-' }}</div>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label small text-muted">Tahun Ajaran</label>
                        <div>{{ $dataSiswa->tahun_ajaran ?? '-' }}</div>
                    </div>

                </div>

                <hr class="my-4">

                <h6 class="fw-semibold mb-3">Kontak</h6>

                <div class="row gy-3">

                    <div class="col-md-4">
                        <label class="form-label small text-muted">No. HP</label>
                        <div>{{ $profil->no_hp ?? '-' }}</div>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label small text-muted">No. HP Orang Tua</label>
                        <div>{{ $profil->no_hp_ortu ?? '-' }}</div>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label small text-muted">Alamat</label>
                        <div>{{ $profil->alamat ?? '-' }}</div>
                    </div>

                </div>

            </div>
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
        text: "Tindakan ini akan memproses data denda",
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