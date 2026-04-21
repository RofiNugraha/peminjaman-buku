@extends('layouts.app')

@section('title', 'Tambah Buku')

@section('content')
<div class="page-header mb-4">
    <h3 class="mb-1">Tambah Buku</h3>
    <p class="mb-0 text-muted">Tambahkan data buku baru</p>
</div>

<div class="card">
    <div class="card-body">

        <form id="formBuku" action="{{ route('buku.store') }}" method="POST" enctype="multipart/form-data">
            @csrf

            <div class="row g-3">

                <div class="col-md-6">
                    <label class="form-label">Kategori</label>
                    <select name="id_kategori" class="form-select @error('id_kategori') is-invalid @enderror">
                        <option value="">Pilih kategori</option>
                        @foreach ($kategoris as $kategori)
                        <option value="{{ $kategori->id }}" @selected(old('id_kategori')==$kategori->id)>
                            {{ $kategori->nama_kategori }}
                        </option>
                        @endforeach
                    </select>
                    @error('id_kategori') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Judul Buku</label>
                    <input type="text" name="judul" value="{{ old('judul') }}"
                        placeholder="Contoh: Belajar Laravel"
                        class="form-control @error('judul') is-invalid @enderror">
                    @error('judul') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Penulis</label>
                    <input type="text" name="penulis" value="{{ old('penulis') }}"
                        placeholder="Nama penulis"
                        class="form-control @error('penulis') is-invalid @enderror">
                    @error('penulis') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Penerbit</label>
                    <input type="text" name="penerbit" value="{{ old('penerbit') }}"
                        placeholder="Nama penerbit"
                        class="form-control @error('penerbit') is-invalid @enderror">
                    @error('penerbit') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Tahun Terbit</label>
                    <input type="number" name="tahun_terbit" value="{{ old('tahun_terbit') }}"
                        placeholder="Contoh: 2024"
                        class="form-control @error('tahun_terbit') is-invalid @enderror">
                    @error('tahun_terbit') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Stok</label>
                    <input type="number" name="stok" min="0" value="{{ old('stok') }}"
                        class="form-control @error('stok') is-invalid @enderror">
                    @error('stok') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-md-6">
                    <label class="form-label">Denda per Hari (Rp)</label>
                    <input type="number" name="denda_per_hari" min="0" value="{{ old('denda_per_hari') }}"
                        class="form-control @error('denda_per_hari') is-invalid @enderror">
                    @error('denda_per_hari') <div class="invalid-feedback">{{ $message }}</div> @enderror
                </div>

                <div class="col-12">
                    <label class="form-label">Gambar Sampul</label>
                    <input type="file" id="gambar" name="gambar"
                        class="form-control @error('gambar') is-invalid @enderror">
                    @error('gambar') <div class="invalid-feedback">{{ $message }}</div> @enderror

                    <img id="preview" class="mt-3 rounded d-none" width="120">
                </div>

            </div>

            <div class="d-flex justify-content-end gap-2 mt-4">
                <a href="{{ route('buku.index') }}" class="btn btn-secondary">Batal</a>
                <button id="btnSubmit" class="btn btn-primary">Simpan</button>
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