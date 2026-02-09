<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\Auth\PasswordController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\KategoriController;
use App\Http\Controllers\Admin\AlatController;
use App\Http\Controllers\Petugas\PeminjamanController as PetugasPeminjamanController;
use App\Http\Controllers\Petugas\PengembalianController;
use App\Http\Controllers\Peminjam\PeminjamanController;

Route::get('/', function () {
    return view('welcome');
});

/*
|--------------------------------------------------------------------------
| AUTH
|--------------------------------------------------------------------------
*/
Route::get('/login', [LoginController::class, 'showLogin'])->name('login');
Route::post('/login', [LoginController::class, 'login'])->middleware('throttle:5,1');
Route::post('/logout', [LoginController::class, 'logout'])->name('logout');

Route::get('/register', [RegisterController::class, 'showRegister'])->name('register');
Route::post('/register', [RegisterController::class, 'register']);

Route::get('/forgot-password', [PasswordController::class, 'forgot'])->name('password.request');
Route::post('/send-otp', [PasswordController::class, 'sendOtp'])->name('send.otp');
Route::get('/verify-otp', [PasswordController::class, 'verifyOtpForm'])->name('password.verify');
Route::post('/verify-otp', [PasswordController::class, 'verifyOtp'])->name('otp.verify');
Route::get('/reset-password', [PasswordController::class, 'resetPasswordForm'])->name('password.reset.form');
Route::post('/reset-password', [PasswordController::class, 'resetPassword'])->name('password.update');

Route::middleware('auth')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'index'])
        ->name('dashboard');

    Route::middleware('role:admin')->prefix('admin')->group(function () {
        Route::resource('users', UserController::class);
        Route::resource('kategori', KategoriController::class);
        Route::resource('alat', AlatController::class);
    });

    Route::middleware('role:petugas')->prefix('petugas')->group(function () {
        Route::resource('peminjaman', PetugasPeminjamanController::class);
        Route::resource('pengembalian', PengembalianController::class);
    });

    Route::middleware('role:peminjam')->prefix('peminjam')->group(function () {
        Route::resource('peminjaman', PeminjamanController::class);

    });

    Route::middleware(['auth'])->prefix('peminjam')->group(function () {
    Route::get('/peminjaman', [PeminjamanController::class, 'index'])->name('peminjaman.index');
    Route::get('/peminjaman/create', [PeminjamanController::class, 'create'])->name('peminjaman.create');
    Route::post('/peminjaman', [PeminjamanController::class, 'store'])->name('peminjaman.store');
    Route::delete('/peminjaman/{id}', [PeminjamanController::class, 'destroy'])->name('peminjaman.destroy');
    });
});