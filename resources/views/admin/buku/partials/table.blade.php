@if(session('error'))
<div class="alert alert-danger mb-3">
    {{ session('error') }}
</div>
@endif

@if(session('success'))
<div class="alert alert-success mb-3">
    {{ session('success') }}
</div>
@endif

<div class="table-responsive">
    <table class="table table-modern align-middle mb-0">
        <thead>
            <tr>
                <th width="60">No</th>
                <th width="80">Gambar</th>
                <th>Judul Buku</th>
                <th>Penulis</th>
                <th>Kategori</th>
                <th width="80">Stok</th>
                <th width="140">Denda / Hari</th>
                <th width="140" class="text-center">Aksi</th>
            </tr>
        </thead>

        <tbody>
            @forelse ($bukus as $index => $buku)
            <tr>
                <td class="text-muted">
                    {{ ($bukus->currentPage() - 1) * $bukus->perPage() + $index + 1 }}
                </td>

                <td>
                    <img src="{{ asset('storage/'.$buku->gambar) }}" class="rounded" width="50" height="50"
                        style="object-fit: cover;">
                </td>

                <td class="fw-semibold">
                    <div>{{ $buku->judul }}</div>
                    <small class="text-muted">{{ $buku->kode_buku }}</small>
                </td>

                <td class="text-muted">
                    {{ $buku->penulis }}
                    <div class="small text-muted">{{ $buku->penerbit }} ({{ $buku->tahun_terbit }})</div>
                </td>

                <td class="text-muted">
                    {{ $buku->kategoris->nama_kategori ?? '-' }}
                </td>

                <td>
                    <span class="badge bg-light text-dark border">
                        {{ $buku->stok }}
                    </span>
                </td>

                <td class="fw-medium">
                    Rp {{ number_format($buku->denda_per_hari, 0, ',', '.') }}
                </td>

                <td class="text-center">
                    <div class="d-flex justify-content-center gap-1">

                        <a href="{{ route('buku.show',$buku->id) }}" class="btn btn-sm btn-light border">
                            <i class="bi bi-eye"></i>
                        </a>

                        <a href="{{ route('buku.edit',$buku->id) }}" class="btn btn-sm btn-light border">
                            <i class="bi bi-pencil"></i>
                        </a>

                        <form action="{{ route('buku.destroy',$buku->id) }}" method="POST" class="delete-form">
                            @csrf
                            @method('DELETE')

                            <button type="submit" class="btn btn-sm btn-light border">
                                <i class="bi bi-trash text-danger"></i>
                            </button>
                        </form>

                    </div>
                </td>
            </tr>
            @empty
            <tr>
                <td colspan="8" class="text-center text-muted py-4">
                    Data buku belum tersedia
                </td>
            </tr>
            @endforelse
        </tbody>
    </table>
</div>

<div class="d-flex flex-wrap justify-content-between align-items-center p-3 border-top">

    <div class="d-flex align-items-center gap-2">
        <span class="small text-muted">Data per halaman</span>
        <select id="per_page" class="form-select form-select-sm w-auto">
            @foreach([5,10,25,50,100] as $size)
            <option value="{{ $size }}" @selected($perPage==$size)>
                {{ $size }}
            </option>
            @endforeach
        </select>
    </div>

    <div>
        {{ $bukus->links('vendor.pagination.custom') }}
    </div>

</div>