@extends('layouts.app')

@section('content')
<div class="container">
    <h4>Form Peminjaman Alat</h4>

    <form action="{{ route('peminjaman.store') }}" method="POST">
        @csrf

        <div class="mb-3">
            <label>Alat</label>
            <select name="id_alat" class="form-control" required>
                <option value="">-- Pilih Alat --</option>
                @foreach ($alats as $alat)
                    <option value="{{ $alat->id }}">{{ $alat->nama }}</option>
                @endforeach
            </select>
        </div>

        <div class="mb-3">
            <label>Tanggal Pinjam</label>
            <input type="date" name="tgl_pinjam" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Tanggal Kembali</label>
            <input type="date" name="tgl_kembali" class="form-control" required>
        </div>

        <button class="btn btn-success">Simpan</button>
        <a href="{{ route('peminjaman.index') }}" class="btn btn-secondary">Kembali</a>
    </form>
</div>
@endsection
