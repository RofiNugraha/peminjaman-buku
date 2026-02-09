@extends('layouts.app')

@section('content')
<div id="mainContent" class="main-content">
    <div class="container-fluid px-4 py-4">
        <h4>Tambah User</h4>

        <form method="POST" action="{{ route('users.store') }}">
            @csrf

            <div class="mb-3">
                <label>Nama Lengkap</label>
                <input name="nama" class="form-control @error('nama') is-invalid @enderror" value="{{ old('nama') }}"
                    required>
                @error('nama')
                <div class="invalid-feedback">{{ $message }}</div>
                @enderror
            </div>

            <div class="mb-3">
                <label>Username</label>
                <input name="username" class="form-control @error('username') is-invalid @enderror"
                    value="{{ old('username') }}" required>
                @error('username')
                <div class="invalid-feedback">{{ $message }}</div>
                @enderror
            </div>

            <div class="mb-3">
                <label>Email</label>
                <input name="email" type="email" class="form-control @error('email') is-invalid @enderror"
                    value="{{ old('email') }}" required>
                @error('email')
                <div class="invalid-feedback">{{ $message }}</div>
                @enderror
            </div>

            <div class="mb-3">
                <label>Password</label>
                <input name="password" type="password" class="form-control @error('password') is-invalid @enderror"
                    required>
                @error('password')
                <div class="invalid-feedback">{{ $message }}</div>
                @enderror
            </div>

            <div class="mb-3">
                <label>Konfirmasi Password</label>
                <input name="password_confirmation" type="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Role</label>
                <select name="role" class="form-control @error('role') is-invalid @enderror" required>
                    <option value="admin" @selected(old('role')==='admin' )>Admin</option>
                    <option value="petugas" @selected(old('role')==='petugas' )>Petugas</option>
                    <option value="peminjam" @selected(old('role')==='peminjam' )>Peminjam</option>
                </select>
                @error('role')
                <div class="invalid-feedback">{{ $message }}</div>
                @enderror
            </div>

            <button class="btn btn-primary">Simpan</button>
            <a href="{{ route('users.index') }}" class="btn btn-secondary">Kembali</a>
        </form>
    </div>
</div>
@endsection