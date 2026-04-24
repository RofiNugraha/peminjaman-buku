<div class="page-header mb-4">
    <h3>Dashboard Admin</h3>
    <p>Ringkasan data sistem</p>
</div>

<div class="row g-4">
    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body">
                <h6>Total User</h6>
                <h3>{{ $totalUser ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body">
                <h6>Total Buku</h6>
                <h3>{{ $totalBuku ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body">
                <h6>Peminjaman Aktif</h6>
                <h3>{{ $peminjamanAktif ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body">
                <h6>Menunggu Approval</h6>
                <h3>{{ $menungguApproval ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body">
                <h6>Pengembalian Hari Ini</h6>
                <h3>{{ $pengembalianHariIni ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body">
                <h6>Log Aktivitas</h6>
                <h3>{{ $totalLog ?? 0 }}</h3>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card">
            <div class="card-body">
                <h6>Peminjaman Terlambat</h6>
                <h4>{{ $terlambat ?? 0 }}</h4>
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-6">
        <div class="card dashboard-card">
            <div class="card-body">
                <h6>Denda Belum Dibayar</h6>
                <h4>Rp {{ number_format($totalDendaBelum ?? 0) }}</h4>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">

    <div class="col-md-8">
        <div class="card  dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body" style="position: relative; height: 360px;">
                <h6>Statistik Peminjaman Per Bulan</h6>
                <div class="chart-container">
                    <canvas id="chartPeminjaman"></canvas>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card  dashboard-card d-flex flex-row align-items-stretch" style="overflow: hidden;">
            <div class="card-body" style="position: relative; height: 360px;">
                <h6>Status Peminjaman</h6>
                <div class="chart-container">
                    <canvas id="chartStatus"></canvas>
                </div>
            </div>
        </div>
    </div>

</div>

<div class="row mt-4">

    <div class="col-md-6">
        <div class="card  dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body">
                <h6>Buku Paling Populer</h6>
                <ul class="list-group">
                    @foreach($bukuPopuler as $buku)
                    <li class="list-group-item d-flex justify-content-between">
                        <span>{{ $buku->judul }}</span>
                        <span class="badge bg-primary bg-opacity-10 text-primary">
                            {{ $buku->total }}
                        </span>
                    </li>
                    @endforeach
                </ul>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card  dashboard-card d-flex flex-row align-items-stretch">
            <div class="card-body">
                <h6>User Paling Aktif</h6>
                <ul class="list-group">
                    @foreach($userAktif as $user)
                    <li class="list-group-item d-flex justify-content-between">
                        {{ $user->user->nama ?? '-' }}
                        <span class="badge bg-success bg-opacity-10 text-success">
                            {{ $user->total }}</span>
                    </li>
                    @endforeach
                </ul>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
const bulanLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];

const peminjamanData = @json($peminjamanPerBulan ?? []);
const statusData = @json($statusPeminjaman ?? []);

new Chart(document.getElementById('chartPeminjaman'), {
    type: 'line',
    data: {
        labels: bulanLabels,
        datasets: [{
            label: 'Peminjaman',
            data: peminjamanData,
            fill: true,
            tension: 0.3
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});

new Chart(document.getElementById('chartStatus'), {
    type: 'pie',
    data: {
        labels: Object.keys(statusData),
        datasets: [{
            data: Object.values(statusData)
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'bottom',
                labels: {
                    boxWidth: 12
                }
            }
        }
    }
});
</script>