# 🔵 Google Drive Backup Setup Guide

## 📊 Overview

Google Drive adalah alternatif cloud storage yang bagus untuk backup database, terutama untuk:

- ✅ Ukuran backup kecil-menengah (< 100GB)
- ✅ Budget terbatas (gratis 15GB)
- ✅ Setup yang lebih mudah dibanding AWS
- ✅ Terintegrasi dengan Google account Anda

**Storage Gratis Google Drive:**

- 📁 **15GB** gratis (shared dengan Gmail, Google Photos)
- 💾 Cukup untuk backup database harian selama 1+ tahun

---

## 🎯 Perbandingan: Google Drive vs AWS S3

| Aspek                | Google Drive            | AWS S3                    |
| -------------------- | ----------------------- | ------------------------- |
| **Setup Complexity** | ⭐ Mudah                | ⭐⭐⭐ Rumit              |
| **Free Storage**     | 15GB                    | 5GB/bulan (12 bulan)      |
| **After Free**       | $2-10/bulan (100GB-1TB) | $0.023/GB                 |
| **Speed**            | Cepat                   | Sangat cepat              |
| **Best For**         | Small-medium backups    | Enterprise, large backups |
| **Learning Curve**   | Rendah                  | Tinggi                    |

**Rekomendasi:**

- 👉 **Google Drive**: Untuk database < 1TB
- 👉 **AWS S3**: Untuk database > 1TB atau enterprise

---

## 🚀 Cara Setup Google Drive Backup

### **Step 1: Setup Google Cloud Project**

1. Buka: https://console.cloud.google.com/
2. Login dengan email: `rofinugraha549@gmail.com`
3. Klik **"Create Project"** (di atas menu)
4. Isi nama project: `peminjaman-buku-backup`
5. Klik **"Create"**
6. Tunggu project dibuat (1-2 menit)

---

### **Step 2: Enable Google Drive API**

1. Di Google Cloud Console, cari **"Google Drive API"**
2. Klik pada hasilnya
3. Klik **"ENABLE"** (tombol biru)
4. Tunggu 1-2 menit sampai enabled

---

### **Step 3: Buat OAuth2 Credentials**

1. Di Cloud Console, klik menu **"APIs & Services"**
2. Pilih **"Credentials"** (di menu kiri)
3. Klik **"+ Create Credentials"** (tombol biru)
4. Pilih **"OAuth client ID"**
5. Akan minta setup **"OAuth consent screen"** dulu:
    - Klik **"Configure Consent Screen"**
    - Pilih **"External"**
    - Klik **"Create"**
6. Isi form:
    ```
    App name: Peminjaman Buku Backup
    User support email: rofinugraha549@gmail.com
    Developer contact: rofinugraha549@gmail.com
    ```
7. Klik **"Save and Continue"**
8. Skip "Scopes" → **"Save and Continue"**
9. Skip "Test users" → **"Save and Continue"**
10. Review dan klik **"Back to Dashboard"**

---

### **Step 4: Generate OAuth Credentials**

1. Di **"Credentials"** page, klik **"+ Create Credentials"**
2. Pilih **"OAuth client ID"**
3. Di "Application type", pilih **"Desktop application"**
4. Isi nama: `Peminjaman Buku Backup`
5. Klik **"Create"**

**HASIL: Anda akan dapat:**

```
Client ID: 885982088996-qr353fbgjtd2orjbp5rrhdg8j4hb8d26.apps.googleusercontent.com
Client Secret: GOCSPX-xxxxxxxxxxxxxxxxxxxxx
```

⚠️ **Simpan keduanya!**

---

### **Step 5: Download Credentials File**

1. Di Credentials page, cari OAuth client ID yang baru dibuat
2. Klik icon **download** (unduh JSON)
3. File akan didownload: `client_secret_885982088996-qr353fbgjtd2orjbp5rrhdg8j4hb8d26.apps.googleusercontent.com.json`
4. **Simpan file ini aman-aman!**

---

### **Step 6: Setup di Laravel Project**

#### 6.1 Install Dependency Google API (Jika belum)

```bash
# Sudah terinstall dari Spatie Backup
composer require google/apiclient
```

#### 6.2 Buat Folder untuk Credentials

```bash
mkdir -p storage/app/google-drive
```

#### 6.3 Copy `client_secret_xxx.json`

```bash
# Copy file yang sudah didownload ke:
cp ~/Downloads/client_secret_xxx.json storage/app/google-drive/client_secret.json
```

#### 6.4 Update `.env`

Tambahkan ke `.env`:

```env
GOOGLE_DRIVE_CLIENT_ID=123456789-abcdefghijklmnopqrstuvwxyz.apps.googleusercontent.com
GOOGLE_DRIVE_CLIENT_SECRET=GOCSPX-xxxxxxxxxxxxxxxxxxxxx
GOOGLE_DRIVE_REFRESH_TOKEN=1//0gXxx...
GOOGLE_DRIVE_FOLDER_ID=your_folder_id_here
```

---

### **Step 7: Dapatkan Refresh Token**

Kita perlu mendapatkan Refresh Token dengan cara:

#### 7.1 Buat Script Temporary untuk OAuth Flow

Buat file: `get_google_drive_token.php` di root project

```php
<?php

require 'vendor/autoload.php';

use Google\Client;

$client = new Client();
$client->setApplicationName('Peminjaman Buku Backup');
$client->setScopes(['https://www.googleapis.com/auth/drive']);
$client->setAuthConfig('storage/app/google-drive/client_secret.json');
$client->setAccessType('offline');
$client->setPrompt('consent');

// Redirect ke Google untuk login
$authUrl = $client->createAuthUrl();
printf("Open the following link in your browser:\n%s\n\n", $authUrl);
printf("Paste the authorization code here: ");

// Tunggu input
$authCode = trim(fgets(STDIN));

// Exchange code untuk token
$accessToken = $client->fetchAccessTokenWithAuthCode($authCode);
$refreshToken = $accessToken['refresh_token'] ?? null;

if ($refreshToken) {
    echo "\n✅ Refresh Token berhasil didapat!\n\n";
    echo "GOOGLE_DRIVE_REFRESH_TOKEN=" . $refreshToken . "\n";
    echo "\nCopy token di atas ke .env file Anda\n";
} else {
    echo "\n❌ Gagal mendapatkan refresh token\n";
}
```

#### 7.2 Jalankan Script

```bash
# Terminal/Command Prompt
php get_google_drive_token.php
```

**Apa yang terjadi:**

1. Script akan membuka URL Google Login
2. Anda login dengan `rofinugraha549@gmail.com`
3. Approve akses ke Google Drive
4. Anda akan dapat Authorization Code
5. Paste code ke terminal
6. Script akan memberikan `GOOGLE_DRIVE_REFRESH_TOKEN`

---

### **Step 8: Dapatkan Google Drive Folder ID**

Kita perlu membuat folder khusus untuk backup di Google Drive:

#### 8.1 Buat Folder di Google Drive

1. Buka: https://drive.google.com/
2. Login dengan email Anda
3. Klik **"New"** → **"Folder"**
4. Nama folder: `Peminjaman Buku Backups`
5. Klik **"Create"**

#### 8.2 Dapatkan Folder ID

1. Buka folder yang baru dibuat
2. Lihat URL browser:

```
https://drive.google.com/drive/folders/1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p
                                       ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
                                       Ini adalah Folder ID
```

3. Salin Folder ID: `1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p`

---

### **Step 9: Update `.env` dengan Semua Data**

```env
# Google Drive Configuration
GOOGLE_DRIVE_CLIENT_ID=123456789-abcdefghijklmnopqrstuvwxyz.apps.googleusercontent.com
GOOGLE_DRIVE_CLIENT_SECRET=GOCSPX-xxxxxxxxxxxxxxxxxxxxx
GOOGLE_DRIVE_REFRESH_TOKEN=1//0gXxx...
GOOGLE_DRIVE_FOLDER_ID=1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p

# Backup Configuration
BACKUP_DISK=google-drive
BACKUP_NOTIFICATION_EMAIL=rofinugraha549@gmail.com
BACKUP_ARCHIVE_PASSWORD=YourSecurePassword123
```

---

### **Step 10: Update `config/filesystems.php`**

Tambahkan konfigurasi Google Drive:

```php
'google-drive' => [
    'driver' => 'google',
    'clientId' => env('GOOGLE_DRIVE_CLIENT_ID'),
    'clientSecret' => env('GOOGLE_DRIVE_CLIENT_SECRET'),
    'refreshToken' => env('GOOGLE_DRIVE_REFRESH_TOKEN'),
    'folderId' => env('GOOGLE_DRIVE_FOLDER_ID'),
],
```

---

### **Step 11: Update `config/backup.php`**

```php
'destination' => [
    'disks' => [
        'local',
        'google-drive',  // Tambahkan ini
    ],
],
```

---

### **Step 12: Test Backup**

```bash
# Jalankan backup
php artisan backup:manage run

# Lihat status
php artisan backup:manage status

# Cek log
tail -f storage/logs/laravel.log
```

Jika berhasil, file backup akan muncul di folder **"Peminjaman Buku Backups"** di Google Drive Anda! ✅

---

## 🧪 Verification

Setelah setup, cek:

```bash
# 1. Test koneksi Google Drive
php artisan backup:run

# 2. Lihat file backup di folder Google Drive
# (refresh folder di browser)

# 3. Cek log untuk error
tail -f storage/logs/laravel.log | grep -i google
```

---

## 🔒 Security Tips

- ✅ Jangan commit `client_secret.json` ke git
- ✅ Jangan share Refresh Token
- ✅ Gunakan `.gitignore`:
    ```
    storage/app/google-drive/
    .env
    ```

---

## 🆚 Google Drive vs AWS S3: Kapan Gunakan?

### Gunakan **Google Drive** jika:

- ✅ Database < 100GB
- ✅ Budget terbatas
- ✅ Setup ingin cepat & mudah
- ✅ Sudah punya Google account
- ✅ Backup frequency rendah (1x/hari)

### Gunakan **AWS S3** jika:

- ✅ Database > 100GB
- ✅ High availability required
- ✅ Enterprise project
- ✅ Backup frequency tinggi (per jam)
- ✅ Multi-region disaster recovery

---

## 🚨 Troubleshooting

### Error: "Invalid credentials"

```
Solusi:
1. Cek GOOGLE_DRIVE_CLIENT_ID benar
2. Cek GOOGLE_DRIVE_CLIENT_SECRET benar
3. Generate ulang credentials dari Google Cloud Console
```

### Error: "Folder not found"

```
Solusi:
1. Cek GOOGLE_DRIVE_FOLDER_ID benar
2. Verifikasi folder masih ada di Google Drive
3. Cek folder bukan dalam Shared Drive (gunakan My Drive)
```

### Error: "Invalid refresh token"

```
Solusi:
1. Refresh token expired (> 6 bulan tanpa digunakan)
2. Jalankan ulang get_google_drive_token.php
3. Generate token baru
```

### Backup lambat

```
Solusi:
1. Google Drive upload speed terbatas (~50MB/s)
2. Gunakan compression di config/backup.php
3. Untuk backup besar, gunakan AWS S3
```

---

## 📚 Resource Links

- **Google Cloud Console**: https://console.cloud.google.com/
- **Google Drive API**: https://developers.google.com/drive/api
- **OAuth2 Documentation**: https://developers.google.com/identity/protocols/oauth2
- **Spatie Backup Docs**: https://spatie.be/docs/laravel-backup

---

**Last Updated**: April 24, 2024
**Status**: ✅ Ready to Setup
