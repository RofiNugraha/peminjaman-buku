# 🚀 Backup Setup Checklist

## ✅ Instalasi Sudah Selesai

Berikut file dan konfigurasi yang sudah dibuat/diupdate:

### 1. **Konfigurasi Files**

- [x] `config/backup.php` - Updated untuk S3 + Database-only backup
- [x] `routes/console.php` - Scheduler untuk backup otomatis setiap jam 2 pagi
- [x] `.env` - Placeholder untuk AWS credentials

### 2. **Service & Command**

- [x] `app/Services/BackupService.php` - Service untuk manage backup
- [x] `app/Console/Commands/BackupManage.php` - Command untuk kontrol backup

### 3. **Dokumentasi**

- [x] `BACKUP_SETUP.md` - Dokumentasi lengkap
- [x] `BACKUP_QUICK_REFERENCE.md` - Quick reference ini

---

## 📋 Langkah Selanjutnya (Setup Production)

### A. Konfigurasi AWS S3 atau Cloud Storage

Pilih salah satu dari 3 opsi:

#### 1️⃣ **AWS S3** (Recommended untuk Production)

```bash
# Edit .env
AWS_ACCESS_KEY_ID=your_access_key_here
AWS_SECRET_ACCESS_KEY=your_secret_key_here
AWS_DEFAULT_REGION=ap-southeast-1
AWS_BUCKET=peminjaman-buku-backups
AWS_USE_PATH_STYLE_ENDPOINT=false
```

**Cara setup AWS S3:**

1. Buka https://aws.amazon.com
2. Login / Create account
3. Buat S3 Bucket untuk backups
4. Create IAM User dengan policy S3 access
5. Copy Access Key ID dan Secret Access Key ke `.env`

#### 2️⃣ **DigitalOcean Spaces** (Budget-friendly)

```bash
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_DEFAULT_REGION=sgp1
AWS_BUCKET=backup-space
AWS_ENDPOINT=https://sgp1.digitaloceanspaces.com
AWS_USE_PATH_STYLE_ENDPOINT=false
```

#### 3️⃣ **MinIO** (Self-hosted)

```bash
AWS_ACCESS_KEY_ID=minioadmin
AWS_SECRET_ACCESS_KEY=minioadmin
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=backups
AWS_ENDPOINT=https://your-minio-server.com
AWS_USE_PATH_STYLE_ENDPOINT=true
```

### B. Konfigurasi Email Notification

```bash
# Edit .env
BACKUP_NOTIFICATION_EMAIL=admin@example.com
BACKUP_ARCHIVE_PASSWORD=YourSecurePasswordHere

# Gmail SMTP
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your_email@gmail.com
MAIL_PASSWORD=your_app_password  # Gunakan App Password, bukan password biasa!
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=backup@example.com
MAIL_FROM_NAME="Peminjaman Buku Backups"
```

### C. Setup Scheduler di Server

#### Opsi 1: Cron Job (Recommended)

```bash
# SSH ke server
crontab -e

# Tambahkan baris ini:
* * * * * cd /path/to/peminjaman-buku && php artisan schedule:run >> /dev/null 2>&1
```

#### Opsi 2: Supervisor (Untuk daemon)

```bash
# Buat file: /etc/supervisor/conf.d/peminjaman-buku-scheduler.conf
[program:peminjaman-buku-scheduler]
process_name=%(program_name)s
command=php /var/www/peminjaman-buku/artisan schedule:run
autostart=true
autorestart=true
numprocs=1
startsecs=0
startretries=10
process_state_events=PROCESS_STATE
stdout_logfile=/var/log/peminjaman-buku-schedule.log

# Reload supervisor
supervisorctl reread
supervisorctl update
supervisorctl start peminjaman-buku-scheduler
```

### D. Test Backup Secara Manual

```bash
# SSH ke server dan jalankan:

# 1. Test backup
php artisan backup:run

# 2. Lihat status
php artisan backup:manage status

# 3. Lihat statistik
php artisan backup:manage stats

# 4. Monitor kesehatan
php artisan backup:manage monitor
```

---

## 📅 Schedule Backup Otomatis

Backup akan dijalankan secara otomatis pada:

| Waktu     | Command          | Deskripsi                |
| --------- | ---------------- | ------------------------ |
| **02:00** | `backup:run`     | Backup database ke S3    |
| **03:00** | `backup:monitor` | Monitor kesehatan backup |
| **03:30** | `backup:clean`   | Cleanup backup lama      |

**Timezone:** Sesuai dengan `APP_TIMEZONE` di `.env`

---

## 🛠️ Useful Commands

```bash
# Status backup
php artisan backup:manage status

# Jalankan backup langsung
php artisan backup:manage run

# Lihat statistik
php artisan backup:manage stats

# Monitor kesehatan
php artisan backup:manage monitor

# Bersihkan backup lama
php artisan backup:manage clean

# Cek scheduler berjalan (development only)
php artisan schedule:work

# List semua backup
php artisan backup:list
```

---

## 🔒 Security Best Practices

### ✅ DO:

- [ ] Set strong `BACKUP_ARCHIVE_PASSWORD` di .env
- [ ] Jangan push `.env` ke git repository
- [ ] Use IAM Users untuk AWS (jangan root access)
- [ ] Enable S3 bucket versioning
- [ ] Enable S3 bucket encryption
- [ ] Regularly test restore process
- [ ] Monitor email notifications

### ❌ DON'T:

- [ ] Commit `.env` ke git
- [ ] Share AWS credentials
- [ ] Use weak passwords
- [ ] Ignore backup failure notifications
- [ ] Forget to test restore

---

## 🎯 Retention Policy

Backup akan otomatis dihapus sesuai retention policy:

```
Keep All:      7 days
Keep Daily:    16 days
Keep Weekly:   8 weeks
Keep Monthly:  4 months
Keep Yearly:   2 years
Max Size:      5000 MB
```

Adjust di `config/backup.php` jika perlu mengubah policy.

---

## ⚠️ Troubleshooting

### Backup tidak jalan otomatis

```bash
# 1. Cek apakah cron sudah setup
crontab -l

# 2. Cek log
tail -f storage/logs/laravel.log | grep backup

# 3. Test scheduler
php artisan schedule:run
```

### AWS Credentials Error

```bash
# Pastikan AWS credentials benar di .env
# dan S3 bucket sudah ada
aws s3 ls --profile default
```

### Email Notification tidak terkirim

```bash
# Test email configuration
php artisan tinker
Mail::raw('Test', fn($m) => $m->to('admin@example.com')->send())
```

---

## 📞 Support & Documentation

- **Spatie Backup Docs:** https://spatie.be/docs/laravel-backup
- **AWS S3 Docs:** https://docs.aws.amazon.com/s3/
- **Laravel Scheduler:** https://laravel.com/docs/11.x/scheduling
- **Local Backup:** `storage/app/backups/`
- **Log File:** `storage/logs/laravel.log`

---

## 🎉 Setup Complete!

Jika semua checklist sudah dikerjakan, backup otomatis Anda siap digunakan!

**Status:** ✅ Ready for Production

**Last Updated:** April 24, 2024
