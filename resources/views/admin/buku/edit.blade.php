@extends('layouts.app')

@section('title', 'Edit Buku')

@section('content')
<div class="page-header mb-4">
    <h3 class="mb-1">Edit Buku</h3>
    <p class="mb-0 text-muted">Perbarui data buku</p>
</div>

<div class="card">
    <div class="card-body">

        <form id="formBuku" action="{{ route('buku.update',$buku->id) }}" method="POST" enctype="multipart/form-data">
            @csrf
            @method('PUT')

            <div class="row g-3">

                <div class="col-md-6">
                    <label class="form-label">Kategori</label>
                    <select name="id_kategori" class="form-select">
                        @foreach ($kategoris as $kategori)
                        <option value="{{ $kategori->id }}" @selected($buku->id_kategori==$kategori->id)>
                            {{ $kategori->nama_kategori }}
                        </option>
                        @endforeach
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Judul Buku</label>
                    <input type="text" name="judul" value="{{ old('judul', $buku->judul) }}"
                        class="form-control @error('judul') is-invalid @enderror">
                    @error('judul') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Penulis</label>
                    <input type="text" name="penulis" value="{{ old('penulis', $buku->penulis) }}"
                        class="form-control @error('penulis') is-invalid @enderror">
                    @error('penulis') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Penerbit</label>
                    <input type="text" name="penerbit" value="{{ old('penerbit', $buku->penerbit) }}"
                        class="form-control @error('penerbit') is-invalid @enderror">
                    @error('penerbit') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Tahun Terbit</label>
                    <input type="number" name="tahun_terbit" value="{{ old('tahun_terbit', $buku->tahun_terbit) }}"
                        class="form-control @error('tahun_terbit') is-invalid @enderror">
                    @error('tahun_terbit') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Stok</label>
                    <input type="number" name="stok" min="0" value="{{ old('stok',$buku->stok) }}" class="form-control">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Denda per Hari</label>
                    <input type="number" name="denda_per_hari" min="0"
                        value="{{ old('denda_per_hari',$buku->denda_per_hari) }}" class="form-control">
                </div>

                <div class="col-12">
                    <label class="form-label">Gambar Sampul (Kosongkan jika tidak diubah)</label>
                    <input type="file" name="gambar" class="form-control">

                    <div class="mt-3">
                        <img src="{{ asset('storage/'.$buku->gambar) }}" width="120" class="rounded">
                    </div>
                </div>

            </div>

            <div class="d-flex justify-content-end gap-2 mt-4">
                <a href="{{ route('buku.index') }}" class="btn btn-secondary">Batal</a>
                <button id="btnSubmit" class="btn btn-primary">Simpan Perubahan</button>
            </div>

        </form>

    </div>
</div>

@push('scripts')
<script>
$('#gambar').change(function() {

    const file = this.files[0];

    if (file) {

        $('#preview')
            .attr('src', URL.createObjectURL(file))
            .removeClass('d-none');

    }

});

$('#formBuku').submit(function() {
    $('#btnSubmit')
        .prop('disabled', true)
        .html('Menyimpan...');
});
</script>
@endpush
@endsection