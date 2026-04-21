<div class="row g-3">

    @foreach ($bukus as $buku)
    <div class="col-xl-3 col-lg-4 col-md-6">
        <div class="card h-100">

            <div class="text-center pt-3">
                <img src="{{ asset('storage/'.$buku->gambar) }}" class="rounded shadow-sm" width="100" height="130"
                    style="object-fit:cover;">
            </div>

            <div class="card-body d-flex flex-column text-center">

                <h6 class="fw-semibold mb-1 text-truncate" title="{{ $buku->judul }}">{{ $buku->judul }}</h6>
                <div class="small text-muted mb-2">{{ $buku->penulis }}</div>

                <div class="small text-muted mb-3">
                    Stok: {{ $buku->stok }} <br>
                    Denda: Rp {{ number_format($buku->denda_per_hari) }}/hari
                </div>

                <div class="mt-auto">
                    @if ($buku->stok > 0)
                    <a href="{{ route('peminjam.peminjaman.create', $buku->id) }}" class="btn btn-primary w-100 btn-sm">
                        Pinjam
                    </a>
                    @else
                    <button class="btn btn-secondary w-100 btn-sm" disabled>
                        Stok Habis
                    </button>
                    @endif
                </div>

            </div>

        </div>
    </div>
    @endforeach

</div>

<div class="d-flex flex-wrap justify-content-between align-items-center mt-4 pt-3 border-top">

    <div class="small text-muted">
        @if($bukus->count())
        Menampilkan {{ $bukus->firstItem() }} - {{ $bukus->lastItem() }} dari {{ $bukus->total() }} data
        @else
        Menampilkan 0 data
        @endif
    </div>

    <div>
        {{ $bukus->links('vendor.pagination.custom') }}
    </div>

</div>