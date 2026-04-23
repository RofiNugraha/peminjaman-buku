<div class="page-header mb-4">
    <h3>Dashboard Siswa</h3>
    <p>Aktivitas peminjaman buku Anda</p>
</div>

<div class="row g-4">

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex">
            <div class="card-body">
                <h6>Total Peminjaman</h6>
                <h3>{{ $totalPinjam ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex">
            <div class="card-body">
                <h6>Masih Dipinjam</h6>
                <h3>{{ $aktif ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex">
            <div class="card-body">
                <h6>Sudah Dikembalikan</h6>
                <h3>{{ $selesai ?? 0 }}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex">
            <div class="card-body">
                <h6>Jumlah Denda</h6>
                <h3>{{ $jumlahDenda ?? 0 }}</h3>
            </div>
        </div>
    </div>
</div>

<div class="row g-4 mt-1">

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex">
            <div class="card-body">
                <h6>Buku Telat</h6>
                <h3>{{ $telat ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex">
            <div class="card-body">
                <h6>Akan Jatuh Tempo</h6>
                <h3>{{ $jatuhTempo ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex">
            <div class="card-body">
                <h6>Total Buku Dipinjam</h6>
                <h3>{{ $totalBukuDipinjam ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex h-100">
            <div class="card-body">
                <div>
                    <h6>Aktivitas Terakhir</h6>

                    @if($lastActivity)
                    <p class="mb-1 line-clamp-2" style="font-size: 14px;">
                        {{ $lastActivity->aktivitas }}
                    </p>
                    @else
                    <p class="text-muted">Belum ada aktivitas</p>
                    @endif
                </div>

                <small class="text-muted">
                    @if($lastActivity)
                    {{ \Carbon\Carbon::parse($lastActivity->waktu)->diffForHumans() }}
                    @endif
                </small>
            </div>
        </div>
    </div>

</div>