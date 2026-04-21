@extends('layouts.app')

@section('title', 'Daftar Buku')

@section('content')
<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
    <div>
        <h3 class="mb-1">Daftar Buku</h3>
        <p class="mb-0 text-muted">{{ $kategori->nama_kategori }}</p>
    </div>

    <a href="{{ route('peminjam.kategori.index') }}" class="btn btn-secondary">
        Kembali
    </a>
</div>

<div class="card mb-3">
    <div class="card-body d-flex flex-wrap gap-3 align-items-end">

        <div>
            <label class="form-label small">Cari Buku</label>
            <input type="text" id="search" class="form-control" placeholder="Cari buku..."
                value="{{ request('search') }}">
        </div>

        <div>
            <label class="form-label small">Data per halaman</label>
            <select id="perPage" class="form-select">
                @foreach([4,8,12,16] as $size)
                <option value="{{ $size }}" @selected($perPage==$size)>{{ $size }}</option>
                @endforeach
            </select>
        </div>

    </div>
</div>

@if($bukus->isEmpty())
<div class="text-center text-muted py-5">
    Tidak ada buku pada kategori ini
</div>
@else
<div class="card">
    <div class="card-body">
        <div id="buku-container">
            @include('peminjam.kategori._buku_list')
        </div>
    </div>
</div>
@endif

<script>
let debounce;

function fetchBuku(url = null) {
    const search = document.getElementById('search').value;
    const perPage = document.getElementById('perPage').value;

    let endpoint;

    if (url) {
        const u = new URL(url);

        u.searchParams.set('search', search);
        u.searchParams.set('per_page', perPage);

        if (u.searchParams.get('per_page') != perPage) {
            u.searchParams.set('page', 1);
        }

        endpoint = u.toString();
    } else {
        endpoint = `{{ route('peminjam.kategori.show', $kategori) }}?search=${search}&per_page=${perPage}&page=1`;
    }

    fetch(endpoint, {
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
        .then(res => res.text())
        .then(html => {
            const container = document.getElementById('buku-container');
            container.style.opacity = 0.5;

            setTimeout(() => {
                container.innerHTML = html;
                container.style.opacity = 1;
            }, 150);
        });
}

document.getElementById('search').addEventListener('input', () => {
    clearTimeout(debounce);
    debounce = setTimeout(fetchBuku, 300);
});

document.getElementById('perPage').addEventListener('change', () => {
    fetchBuku();
});

document.addEventListener('click', function(e) {
    const link = e.target.closest('.pagination a');
    if (link) {
        e.preventDefault();
        fetchBuku(link.href);
    }
});
</script>
@endsection