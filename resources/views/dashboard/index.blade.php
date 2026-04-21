@extends('layouts.app')

@section('content')
@if(auth()->user()->role === 'admin' || auth()->user()->role === 'petugas')
@include('dashboard.admin')
@else
@include('dashboard.peminjam')
@endif
@endsection