# 🔑 AWS Setup Guide Lengkap untuk Peminjaman Buku Backup

## 📊 Overview AWS untuk Backup

AWS S3 adalah cloud storage yang aman, scalable, dan terjangkau untuk menyimpan backup database.

**Biaya:**

- Free Tier: 5GB per bulan (gratis untuk 12 bulan)
- Setelah itu: $0.023 per GB (sangat murah)

---

## 🚀 Langkah-Langkah Setup (Lengkap)

### A. Buat AWS Account

#### Metode 1: Langsung dari AWS (Recommended)

1. Buka https://aws.amazon.com/
2. Klik **"Create an AWS Account"** (di kanan atas)
3. Isi form:
    - **Email address**: `rofinugraha549@gmail.com`
    - **AWS account name**: `peminjaman-buku` (bisa apa saja)
    - **Password**: Minimal 8 karakter, kombinasi huruf+angka+simbol
4. Klik **"Verify email address"** (check email untuk kode verifikasi)
5. Klik **"Create AWS Account"**
6. Pilih **"Personal"** untuk tipe account
7. Isi detail pribadi Anda
8. **Tambahkan metode pembayaran** (kartu debit/kredit)
    - Charge $1 untuk verifikasi (akan di-refund)
9. Verifikasi via SMS/Phone call
10. Tunggu approval (biasanya instant)
11. ✅ Account siap digunakan!

#### Metode 2: Pakai Account Existing

Jika sudah punya AWS account, langsung ke Step B.

---

### B. Buat S3 Bucket untuk Backup

1. Login ke AWS Console: https://console.aws.amazon.com
2. Di search bar, ketik **"S3"**
3. Klik **"S3"** (Simple Storage Service)
4. Klik **"Create bucket"** (tombol orange)
5. Isi form:

```
Bucket name: peminjaman-buku-backups-20240424
(Catatan: Harus unique globally, gunakan tanggal/random number)

AWS Region: ap-southeast-1 (Singapore - terdekat dengan Indonesia)

Object Ownership: ACLs disabled (default)

Block Public Access:
  ☐ Block all public access (UNCHECK ini)
  ☐ Block public access to buckets...
  ☐ Block public access to objects...
  ☐ Ignore public access block...

Bucket Versioning: Enable (optional, untuk recovery lebih mudah)

Tags: (optional)
  - Environment: production
  - Purpose: database-backup

Encryption: Enable (recommended)
```

6. Klik **"Create bucket"**
7. ✅ Bucket berhasil dibuat!

---

### C. Buat IAM User dengan Akses S3

**Kenapa pakai IAM User?**

- Tidak pakai root account (lebih aman)
- Bisa limit akses hanya ke S3
- Bisa revoke kapan saja

**Langkah-langkah:**

1. Buka https://console.aws.amazon.com/iam/
2. Di menu kiri, klik **"Users"**
3. Klik **"Create user"**
4. Isi form:

```
User name: peminjaman-buku-backup-user

Console password: (biarkan kosong)
☐ Provide user access to AWS Management Console

Permissions:
  (di next page) Pilih "Attach policies directly"
```

5. Klik **"Next"**
6. Di halaman permissions:
    - Cari **"S3"** di search box
    - Pilih **"AmazonS3FullAccess"** ✅
    - (Atau lebih restricted: `s3:ListBucket`, `s3:GetObject`, `s3:PutObject`)
7. Klik **"Next"** → **"Create user"**
8. ✅ User berhasil dibuat!

---

### D. Generate Access Keys (Credential untuk .env)

1. Buka user yang baru dibuat: **peminjaman-buku-backup-user**
2. Tab **"Security credentials"**
3. Scroll ke section **"Access keys"**
4. Klik **"Create access key"**
5. Pilih use case: **"Command Line Interface (CLI)"** ✅
6. Check ☑️ "I understand the above recommendation..."
7. Klik **"Create access key"**

**HASIL: Anda akan mendapat**

```
✅ Access Key ID: AKIA3X2B5EXAMPLE
✅ Secret Access Key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

⚠️ **PENTING:**

- Simpan keduanya di tempat aman
- Secret Access Key hanya ditampilkan SEKALI
- Jangan share ke siapa pun!

---

## 📝 Update .env File

Setelah punya Access Key, update file `.env` Anda:

```env
# AWS S3 Credentials
AWS_ACCESS_KEY_ID=AKIA3X2B5EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
AWS_DEFAULT_REGION=ap-southeast-1
AWS_BUCKET=peminjaman-buku-backups-20240424
AWS_USE_PATH_STYLE_ENDPOINT=false

# Backup Configuration
BACKUP_DISK=s3
BACKUP_NOTIFICATION_EMAIL=rofinugraha549@gmail.com
BACKUP_ARCHIVE_PASSWORD=YourSecurePasswordHere
```

---

## 🧪 Test Connection

Setelah update .env, test koneksi ke S3:

```bash
# 1. Test dengan artisan command
php artisan backup:manage status

# 2. Atau jalankan backup langsung
php artisan backup:manage run

# 3. Cek log
tail -f storage/logs/laravel.log
```

Jika berhasil, Anda akan lihat file backup di AWS S3 Console.

---

## 🔒 Security Checklist

- [ ] Access Key ID dan Secret disimpan aman
- [ ] Jangan commit `.env` ke git
- [ ] Enable S3 bucket versioning
- [ ] Enable S3 bucket encryption
- [ ] Setup S3 bucket lifecycle (auto-delete old files)
- [ ] Enable CloudTrail untuk audit

---

## 💰 Cost Optimization

### S3 Pricing (ap-southeast-1 region)

| Feature      | Cost                     |
| ------------ | ------------------------ |
| Storage      | $0.023/GB/bulan          |
| Transfer In  | Gratis                   |
| Transfer Out | $0.12/GB                 |
| Requests     | $0.0004 per 10k requests |

### Budget Estimation (contoh)

- Database size: 500MB
- Backup sehari 1x: 500MB/bulan = 15GB
- Cost: 15GB × $0.023 = **$0.345/bulan (~Rp 5rb)**
- **Free Tier: Gratis untuk 12 bulan pertama (5GB/bulan)**

### Cara Kurangi Biaya

1. ✅ Gunakan Free Tier (5GB/bulan)
2. ✅ Enable compression di config/backup.php
3. ✅ Setup lifecycle policy (auto-delete > 6 bulan)
4. ✅ Gunakan Regional Discount jika tersedia

---

## 🚨 Troubleshooting

### Error: "Access Denied"

```
Solusi:
1. Cek Access Key ID benar di .env
2. Cek Secret Access Key benar (jangan ada space)
3. Cek IAM User punya S3FullAccess permission
4. Cek bucket name benar
```

### Error: "NoSuchBucket"

```
Solusi:
1. Pastikan bucket sudah dibuat di S3
2. Pastikan bucket name di .env sama dengan di AWS
3. Pastikan region benar (ap-southeast-1)
```

### Error: "SignatureDoesNotMatch"

```
Solusi:
1. Secret Access Key tidak valid atau ada karakter terlewat
2. Generate ulang Access Key
3. Copy-paste langsung dari AWS Console
```

### Biaya Tiba-tiba Naik?

```
Solusi:
1. Cek storage usage di S3 Console
2. Cek lifecycle policy sudah jalan
3. Cek backup:clean sudah jalan setiap hari
4. Setup CloudWatch alarm untuk monitoring
```

---

## 🔗 Resource Links

- **AWS S3 Documentation**: https://docs.aws.amazon.com/s3/
- **AWS Free Tier**: https://aws.amazon.com/free/
- **IAM Best Practices**: https://docs.aws.amazon.com/iam/latest/userguide/best-practices.html
- **S3 Pricing Calculator**: https://aws.amazon.com/s3/pricing/

---

## 📞 Support

Jika ada masalah:

1. Check AWS Console for error messages
2. Check CloudTrail untuk audit logs
3. Contact AWS Support (ada di Console)

---

**Last Updated**: April 24, 2024
**Status**: ✅ Ready to Setup
