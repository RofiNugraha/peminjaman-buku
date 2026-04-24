# ✅ AWS Setup Checklist

Gunakan checklist ini untuk memastikan semua langkah AWS setup sudah selesai.

## 📋 Fase 1: Membuat AWS Account

- [ ] **Step 1.1** - Buka https://aws.amazon.com
- [ ] **Step 1.2** - Klik "Create an AWS Account"
- [ ] **Step 1.3** - Isi email: `rofinugraha549@gmail.com`
- [ ] **Step 1.4** - Buat password yang kuat
- [ ] **Step 1.5** - Pilih "Personal" untuk account type
- [ ] **Step 1.6** - Verifikasi email (cek inbox)
- [ ] **Step 1.7** - Tambahkan metode pembayaran (kartu kredit)
- [ ] **Step 1.8** - Verifikasi via SMS/Phone call
- [ ] **Step 1.9** - Login ke AWS Console: https://console.aws.amazon.com

**Status Phase 1**: ⏳ Pending → ✅ Complete

---

## 🪣 Fase 2: Setup S3 Bucket

- [ ] **Step 2.1** - Login ke AWS Console
- [ ] **Step 2.2** - Cari "S3" di search bar
- [ ] **Step 2.3** - Klik "Create bucket"
- [ ] **Step 2.4** - Bucket name: `peminjaman-buku-backups-[TANGGAL]`
    - Contoh: `peminjaman-buku-backups-20240424`
- [ ] **Step 2.5** - Region: `ap-southeast-1` (Singapore)
- [ ] **Step 2.6** - Uncheck "Block all public access"
- [ ] **Step 2.7** - (Optional) Enable "Bucket Versioning"
- [ ] **Step 2.8** - (Optional) Enable "Encryption"
- [ ] **Step 2.9** - Klik "Create bucket"

**Status Phase 2**: ⏳ Pending → ✅ Complete

**Bucket Name yang Dibuat**: `_________________`

---

## 👤 Fase 3: Setup IAM User

- [ ] **Step 3.1** - Buka https://console.aws.amazon.com/iam/
- [ ] **Step 3.2** - Klik "Users" di menu kiri
- [ ] **Step 3.3** - Klik "Create user"
- [ ] **Step 3.4** - User name: `peminjaman-buku-backup-user`
- [ ] **Step 3.5** - Uncheck "Provide user access to AWS Management Console"
- [ ] **Step 3.6** - Klik "Next"
- [ ] **Step 3.7** - Klik "Attach policies directly"
- [ ] **Step 3.8** - Cari dan pilih "AmazonS3FullAccess"
- [ ] **Step 3.9** - Klik "Next" → "Create user"

**Status Phase 3**: ⏳ Pending → ✅ Complete

---

## 🔑 Fase 4: Generate Access Keys

- [ ] **Step 4.1** - Buka user: `peminjaman-buku-backup-user`
- [ ] **Step 4.2** - Klik tab "Security credentials"
- [ ] **Step 4.3** - Scroll ke "Access keys"
- [ ] **Step 4.4** - Klik "Create access key"
- [ ] **Step 4.5** - Pilih "Command Line Interface (CLI)"
- [ ] **Step 4.6** - Check "I understand..."
- [ ] **Step 4.7** - Klik "Create access key"
- [ ] **Step 4.8** - **COPY dan SIMPAN:**
    - Access Key ID: `_________________`
    - Secret Access Key: `_________________`

**⚠️ PENTING**: Simpan keduanya di tempat aman!

**Status Phase 4**: ⏳ Pending → ✅ Complete

---

## 📝 Fase 5: Update .env File

File: `c:\laragon\www\peminjaman-buku\.env`

- [ ] **Step 5.1** - Buka file `.env`
- [ ] **Step 5.2** - Update `AWS_ACCESS_KEY_ID` dengan Access Key ID
- [ ] **Step 5.3** - Update `AWS_SECRET_ACCESS_KEY` dengan Secret Access Key
- [ ] **Step 5.4** - Update `AWS_DEFAULT_REGION=ap-southeast-1`
- [ ] **Step 5.5** - Update `AWS_BUCKET=peminjaman-buku-backups-[TANGGAL]`
- [ ] **Step 5.6** - Pastikan `AWS_USE_PATH_STYLE_ENDPOINT=false`
- [ ] **Step 5.7** - Pastikan `BACKUP_DISK=s3`
- [ ] **Step 5.8** - Pastikan `BACKUP_NOTIFICATION_EMAIL=rofinugraha549@gmail.com`
- [ ] **Step 5.9** - Simpan file `.env`

**Status Phase 5**: ⏳ Pending → ✅ Complete

---

## 🧪 Fase 6: Test Connection

Terminal/Command Prompt:

```bash
# Step 6.1 - Navigate ke project directory
cd c:\laragon\www\peminjaman-buku

# Step 6.2 - Test backup status
php artisan backup:manage status

# Step 6.3 - Jalankan backup
php artisan backup:manage run

# Step 6.4 - Cek log
tail -f storage/logs/laravel.log
```

- [ ] **Step 6.1** - Jalankan `php artisan backup:manage status`
- [ ] **Step 6.2** - Pastikan tidak ada error
- [ ] **Step 6.3** - Jalankan `php artisan backup:manage run`
- [ ] **Step 6.4** - Tunggu backup selesai (2-5 menit)
- [ ] **Step 6.5** - Cek log: `tail -f storage/logs/laravel.log`
- [ ] **Step 6.6** - Verify di AWS S3 Console (refresh page)
- [ ] **Step 6.7** - Pastikan file `.zip` ada di bucket

**Status Phase 6**: ⏳ Pending → ✅ Complete

---

## 📧 Fase 7: Setup Email Notification (Optional tapi Recommended)

- [ ] **Step 7.1** - Update `MAIL_USERNAME=rofinugraha549@gmail.com` di `.env`
- [ ] **Step 7.2** - Update `MAIL_PASSWORD` dengan App Password (bukan password regular)
    - Lihat: https://support.google.com/accounts/answer/185833
- [ ] **Step 7.3** - Update `MAIL_FROM_ADDRESS=backup@yourdomain.com`
- [ ] **Step 7.4** - Test email: `php artisan mail:send`

**Status Phase 7**: ⏳ Pending → ✅ Complete (Optional)

---

## 🎯 Fase 8: Setup Scheduler (Production)

- [ ] **Step 8.1** - SSH ke server production
- [ ] **Step 8.2** - Edit crontab: `crontab -e`
- [ ] **Step 8.3** - Tambahkan line:
    ```
    * * * * * cd /path/to/peminjaman-buku && php artisan schedule:run >> /dev/null 2>&1
    ```
- [ ] **Step 8.4** - Save crontab
- [ ] **Step 8.5** - Verify: `crontab -l`

**Status Phase 8**: ⏳ Pending → ✅ Complete (untuk production)

---

## 📊 Final Verification

Pastikan semua yang di bawah berjalan dengan benar:

- [ ] **✅ AWS Account** - Sudah aktif dan bisa login
- [ ] **✅ S3 Bucket** - Sudah dibuat dan bisa diakses
- [ ] **✅ IAM User** - Sudah dibuat dengan S3 Full Access
- [ ] **✅ Access Keys** - Sudah di-generate dan tersimpan aman
- [ ] **✅ .env File** - Sudah di-update dengan credentials
- [ ] **✅ Backup Test** - Sudah berhasil dijalankan manually
- [ ] **✅ Email Notification** - Sudah dikonfigurasi (optional)
- [ ] **✅ Scheduler** - Sudah di-setup di server (production)

---

## 📞 Troubleshooting

Jika ada error:

### Error: "Access Denied"

- [ ] Cek Access Key ID di `.env` benar
- [ ] Cek Secret Access Key tidak ada space
- [ ] Cek IAM User punya S3FullAccess permission
- [ ] Generate ulang Access Keys

### Error: "NoSuchBucket"

- [ ] Pastikan bucket sudah dibuat di S3 Console
- [ ] Pastikan nama bucket di `.env` sama dengan di AWS
- [ ] Pastikan region benar

### Error: "SignatureDoesNotMatch"

- [ ] Secret Access Key salah atau ada karakter terlewat
- [ ] Copy-paste ulang dari AWS Console
- [ ] Generate ulang Access Keys

---

## 🎉 Selesai!

Jika semua checklist sudah dicentang, backup otomatis Anda sudah siap!

```bash
# Monitor backup berjalan
php artisan schedule:work

# Atau cek log
tail -f storage/logs/laravel.log | grep backup
```

**Selamat! 🎊 Backup otomatis sudah siap digunakan.**

---

**Last Updated**: April 24, 2024
**Your Email**: rofinugraha549@gmail.com
**Region**: ap-southeast-1 (Singapore)
