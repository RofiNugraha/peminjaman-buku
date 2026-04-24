# Database Backup Otomatis - Panduan Setup

## Ringkasan Fitur

Sistem backup otomatis database harian dengan fitur:

- ✅ Scheduler Laravel (dijalankan setiap hari jam 2 pagi)
- ✅ Spatie Backup (backup database MySQL)
- ✅ Cloud Storage S3 (AWS, DigitalOcean Spaces, atau MinIO)
- ✅ Notifikasi Email
- ✅ Retention Policy (otomatis hapus backup lama)
- ✅ Backup Encryption (enkripsi archive backup)

---

## Instalasi & Konfigurasi

### 1. Install Dependencies (Sudah Terinstall)

```bash
# Spatie Backup sudah ada di composer.json
composer install
```

### 2. Konfigurasi AWS S3 / Cloud Storage

#### Option A: AWS S3

```env
# .env file
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_DEFAULT_REGION=ap-southeast-1
AWS_BUCKET=your-backup-bucket-name
AWS_USE_PATH_STYLE_ENDPOINT=false
```

#### Option B: DigitalOcean Spaces

```env
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_DEFAULT_REGION=sgp1
AWS_BUCKET=your-space-name
AWS_ENDPOINT=https://sgp1.digitaloceanspaces.com
AWS_USE_PATH_STYLE_ENDPOINT=false
```

#### Option C: MinIO (Self-Hosted)

```env
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=backups
AWS_ENDPOINT=https://your-minio-url
AWS_USE_PATH_STYLE_ENDPOINT=true
```

### 3. Konfigurasi Environment Variables

```env
# Backup Configuration
BACKUP_DISK=s3                              # Disk untuk menyimpan backup
BACKUP_NOTIFICATION_EMAIL=admin@example.com # Email notifikasi
BACKUP_ARCHIVE_PASSWORD=your_secure_password_here # Password enkripsi

# Mail Configuration (untuk notifikasi)
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your_email@gmail.com
MAIL_PASSWORD=your_app_password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=backup@example.com
MAIL_FROM_NAME="Peminjaman Buku Backup"
```

### 4. Konfigurasi Backup Komprehensif

File konfigurasi: `config/backup.php`

**Fitur yang dikonfigurasi:**

- ✅ Database backup hanya (tidak menginclude files untuk efisiensi)
- ✅ Backup ke S3 dan Local storage
- ✅ Encryption dengan AES-256
- ✅ Monitoring kesehatan backup
- ✅ Cleanup otomatis dengan retention policy:
    - Simpan semua backup 7 hari terakhir
    - Setelah 7 hari, simpan 1 backup per hari hingga 16 hari
    - Setelah 16 hari, simpan 1 backup per minggu hingga 8 minggu
    - Setelah 8 minggu, simpan 1 backup per bulan hingga 4 bulan
    - Setelah 4 bulan, simpan 1 backup per tahun hingga 2 tahun

---

## Scheduler Configuration

File: `routes/console.php`

Backup dijalankan dengan schedule berikut:

```
02:00 - Backup Database (backup:run)
03:00 - Monitor Kesehatan Backup (backup:monitor)
03:30 - Cleanup Backup Lama (backup:clean)
```

---

## Penggunaan Manual

### Jalankan Backup Langsung

```bash
php artisan backup:run
```

### Monitor Kesehatan Backup

```bash
php artisan backup:monitor
```

### Bersihkan Backup Lama

```bash
php artisan backup:clean
```

### List Backup yang Ada

```bash
php artisan backup:list
```

### Restore Backup

```bash
# Lihat list backup
php artisan backup:list

# Restore dari backup tertentu
mysql -u root -p peminjaman_buku < storage/app/backups/backup-2024-04-24.sql
```

---

## Setup Scheduler Otomatis

### Untuk Development (Local)

Gunakan `php artisan schedule:work` untuk melihat scheduler berjalan secara real-time:

```bash
php artisan schedule:work
```

### Untuk Production (Server)

Tambahkan Cron Job ke server:

```bash
# Edit crontab
crontab -e

# Tambahkan baris ini
* * * * * cd /path/to/peminjaman-buku && php artisan schedule:run >> /dev/null 2>&1
```

**Atau gunakan Supervisor untuk daemon:**

```ini
# /etc/supervisor/conf.d/peminjaman-buku-schedule.conf
[program:peminjaman-buku-schedule]
process_name=%(program_name)s
command=php /path/to/peminjaman-buku/artisan schedule:run
autostart=true
autorestart=true
numprocs=1
redirect_stderr=true
stdout_logfile=/var/log/peminjaman-buku-schedule.log
```

---

## Monitoring & Logging

### Cek Log Backup

```bash
# Real-time log
tail -f storage/logs/laravel.log

# Filter log backup
tail -f storage/logs/laravel.log | grep -i backup
```

### Database untuk Tracking

Semua aktivitas backup dicatat di:

- File: `storage/logs/laravel.log`
- Database: Table `activity_logs` (jika menggunakan LogHelper)

---

## Troubleshooting

### Error: "AWS Credentials not found"

```
Solusi: Pastikan AWS_ACCESS_KEY_ID dan AWS_SECRET_ACCESS_KEY sudah diisi di .env
```

### Error: "Bucket does not exist"

```
Solusi:
1. Pastikan bucket sudah dibuat di AWS S3 / Cloud Storage
2. Pastikan credentials memiliki permission untuk akses bucket
```

### Error: "SMTP connection failed"

```
Solusi:
1. Cek konfigurasi MAIL_* di .env
2. Untuk Gmail, gunakan App Password bukan password biasa
3. Aktifkan "Less secure app access" jika perlu
```

### Backup tidak berjalan secara otomatis

```
Solusi:
1. Pastikan cron job sudah disetup: crontab -l
2. Test dengan: php artisan schedule:run
3. Cek log: tail -f storage/logs/laravel.log
4. Pastikan server memiliki command line access
```

### Backup terlalu besar

```
Solusi:
1. Kurangi BACKUP_ARCHIVE_PASSWORD (bisa jadi menyebabkan overhead)
2. Exclude tables yang tidak penting di config/backup.php
3. Increase cloud storage quota
```

---

## Best Practices

1. **Secure Credentials**
    - Jangan commit `.env` ke repository
    - Gunakan `.env.example` untuk contoh
    - Rotate AWS credentials secara berkala

2. **Testing**
    - Test backup secara manual sebelum production
    - Test restore process secara berkala
    - Catat waktu backup dan restore untuk monitoring

3. **Monitoring**
    - Monitor email notifikasi backup
    - Set alert jika backup gagal
    - Regular check storage quota

4. **Retention**
    - Adjust retention policy sesuai kebutuhan
    - Monitor storage cost di cloud provider
    - Dokumentasikan alasan untuk setiap perubahan

5. **Security**
    - Selalu gunakan encryption untuk backup
    - Protect password encryption di .env
    - Limit access ke cloud storage bucket

---

## Informasi Lebih Lanjut

- Dokumentasi Spatie Backup: https://spatie.be/docs/laravel-backup/v10/introduction
- AWS S3 Documentation: https://docs.aws.amazon.com/s3/
- Laravel Scheduler: https://laravel.com/docs/11.x/scheduling

---

**Last Updated:** April 24, 2024
