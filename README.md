# Sistem Peminjaman Buku

Aplikasi manajemen peminjaman buku untuk perpustakaan sekolah yang dibangun menggunakan Laravel 11.

## Persyaratan Sistem

- PHP 8.2 atau lebih tinggi
- Composer
- Node.js & NPM
- MySQL/MariaDB
- Git

## Cara Menjalankan Project

### 1. Clone Repository

```bash
git clone <repository-url>
cd peminjaman-buku
```

### 2. Install Dependencies PHP

```bash
composer install
```

### 3. Install Dependencies JavaScript

```bash
npm install
```

### 4. Setup Environment

Salin file `.env.example` menjadi `.env`:

```bash
cp .env.example .env
```

Kemudian generate application key:

```bash
php artisan key:generate
```

### 5. Konfigurasi Database

Edit file `.env` dan sesuaikan konfigurasi database:

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=peminjaman_buku
DB_USERNAME=root
DB_PASSWORD=
```

Jika menggunakan Laragon, database sudah tersedia. Buat database baru bernama `peminjaman_buku` melalui Laragon atau command line.

#### Membuat Database (Jika belum ada)

Menggunakan MySQL CLI:

```bash
mysql -u root -e "CREATE DATABASE peminjaman_buku;"
```

### 6. Setup Database

Pilih salah satu dari dua cara berikut:

#### Opsi A: Import Database Backup (Direkomendasikan)

Jika ingin menggunakan data yang sudah tersedia di file backup:

```bash
mysql -u root peminjaman_buku < peminjaman_buku.sql
```

#### Opsi B: Migrasi Fresh dan Seed

Jika ingin membuat database dari awal dengan migration:

```bash
php artisan migrate:fresh
```

Kemudian seed database dengan data contoh:

```bash
php artisan db:seed
```

### 7. Build Assets

```bash
npm run build
```

Atau untuk development mode dengan hot reload:

```bash
npm run dev
```

### 8. Jalankan Server

Buka terminal baru dan jalankan perintah:

```bash
php artisan serve
```

Server akan berjalan di `http://localhost:8000`

## Menjalankan Aplikasi (Setelah Setup)

Setelah melakukan setup di atas, untuk menjalankan aplikasi kembali di lain waktu:

### Terminal 1 - Jalankan Server Laravel

```bash
cd c:\laragon\www\peminjaman-buku
php artisan serve
```

### Terminal 2 - Compile Assets (jika diperlukan)

Jika ingin auto-compile CSS dan JavaScript saat development:

```bash
npm run dev
```

Atau jika hanya perlu sekali build:

```bash
npm run build
```

### Akses Aplikasi

Buka browser dan kunjungi: `http://localhost:8000`

## Informasi Login

### Kredensial Default (Jika menggunakan backup peminjaman_buku.sql)

Silakan check database atau konsultasikan dengan admin untuk mendapatkan kredensial login.

Jika menggunakan data seed, sesuaikan kredensial yang tersedia di database setelah menjalankan `php artisan db:seed`.

## Fitur Utama

- Manajemen data buku dan kategori
- Pengajuan peminjaman buku oleh siswa
- Persetujuan peminjaman oleh admin/petugas
- Manajemen pengembalian buku
- Sistem denda otomatis untuk keterlambatan
- Laporan peminjaman
- Log aktivitas
- Notifikasi kepada peminjam

## Struktur Project

- `app/` - Logika aplikasi (Models, Controllers, Services)
- `resources/` - View templates dan assets
- `routes/` - Definisi routes aplikasi
- `database/` - Migrations dan seeders
- `public/` - File publik yang dapat diakses

## Support

Untuk pertanyaan atau masalah, silakan buat issue di repository ini.

---

<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework. You can also check out [Laravel Learn](https://laravel.com/learn), where you will be guided through building a modern Laravel application.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Redberry](https://redberry.international/laravel-development)**
- **[Active Logic](https://activelogic.com)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
