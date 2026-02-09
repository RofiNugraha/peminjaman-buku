@extends('layouts.app')

@section('content')
<div class="container">
    <h4>Data Peminjaman</h4>

    <a href="{{ route('peminjaman.create') }}" class="btn btn-primary mb-3">
        Ajukan Peminjaman
    </a>

    <table class="table table-bordered">
        <tr>
            <th>Alat</th>
            <th>Tgl Pinjam</th>
            <th>Tgl Kembali</th>
            <th>Status</th>
            <th>Aksi</th>
        </tr>
        @foreach ($peminjamans as $p)
        <tr>
            <td>{{ $p->alat->nama }}</td>
            <td>{{ $p->tgl_pinjam }}</td>
            <td>{{ $p->tgl_kembali }}</td>
            <td>{{ $p->status }}</td>
            <td>
                @if ($p->status == 'menunggu')
                <form action="{{ route('peminjaman.destroy', $p->id) }}" method="POST">
                    @csrf
                    @method('DELETE')
                    <button class="btn btn-danger btn-sm">Batalkan</button>
                </form>
                @endif
            </td>
        </tr>
        @endforeach
    </table>
</div>
@endsection
