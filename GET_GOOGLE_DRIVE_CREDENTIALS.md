# 🔑 Cara Mendapatkan Google Drive Credentials

## Pilih Metode Yang Sesuai

### Metode 1️⃣: Rclone (PALING MUDAH - Recommended!)

Setup time: **5 menit**

### Metode 2️⃣: OAuth2 Manual

Setup time: **30 menit**

---

## 🟢 METODE 1: Rclone (SUPER MUDAH!)

Ini adalah cara **paling mudah** untuk mendapatkan Google Drive access.

### ✅ Keuntungan:

- Hanya perlu login 1x
- Otomatis handle token
- Tidak perlu generate token manual
- Browser UI interaktif

### Langkah-langkah:

#### **Step 1: Download Rclone**

**Windows:**

1. Buka https://rclone.org/downloads/
2. Download "Windows Intel/AMD (x64)"
3. Extract file zip
4. Pindahkan `rclone.exe` ke folder yang mudah diakses (misal: `C:\Program Files\rclone\`)
5. Add ke PATH (optional, tapi recommended)

**Verify instalasi:**

```bash
# Buka CMD/Terminal
rclone --version

# Harusnya output versi rclone
```

#### **Step 2: Setup Google Drive di Rclone**

Buka Terminal/CMD dan jalankan:

```bash
rclone config
```

**Akan muncul menu:**

```
e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q>
```

**Ketik: `n` (New remote)**

```
name> backup-google-drive
(Nama untuk remote, bisa apa saja)
```

**Akan muncul list storage types:**

```
Type of storage>
(Scroll sampai menemukan nomor "Google Drive")
```

**Cari dan pilih nomor Google Drive (biasanya 16 atau 17)**

```
Type of storage> 16
(Pilih Google Drive)
```

**Setelah itu akan muncul form:**

```
Google Application Client Id>
(Tekan Enter, biarkan kosong)

Google Application Client Secret>
(Tekan Enter, biarkan kosong)

scope> 1
(Pilih "drive" untuk full access)
```

**Lanjutkan:**

```
root_folder_id>
(Tekan Enter, biarkan kosong)

service_account_file>
(Tekan Enter, biarkan kosong)

Edit advanced config> n
(Ketik: n)

Use web browser to authenticate rclone with remote? y
(Ketik: y)
```

#### **Step 3: Login dengan Google**

**Browser akan terbuka otomatis!**

1. **Anda akan lihat halaman Google login**
2. **Login dengan email:** `rofinugraha549@gmail.com`
3. **Password:** (masukkan password Google account Anda)
4. **Halaman berikutnya:** Klik **"Allow"** untuk memberikan akses
5. **Page terakhir:** Klik **"Confirm"**
6. **Browser akan close otomatis**

#### **Step 4: Verifikasi Setup**

**Kembali ke terminal:**

```
Keep this token? y
(Ketik: y)

Configure this as a team drive? n
(Ketik: n)

Confirm setup? y
(Ketik: y)

e/n/d/r/c/s/q> q
(Ketik: q untuk selesai)
```

**✅ SELESAI!** Rclone sudah configured!

#### **Step 5: Test Koneksi**

```bash
# List folder di Google Drive
rclone lsd backup-google-drive:

# Harusnya show folders di Google Drive Anda
```

---

## 🟠 METODE 2: OAuth2 Manual (Advanced)

Jika ingin setup di Laravel secara manual, ikuti guide ini:

### ✅ Keuntungan:

- Full control atas credentials
- Bisa custom scopes
- Integrasi langsung ke Laravel

### ❌ Kekurangan:

- Setup lebih rumit
- Harus handle token refresh
- Perlu Google Cloud project

### Langkah-langkah:

#### **Step 1: Buka Google Cloud Console**

1. Buka: https://console.cloud.google.com/
2. **Login dengan:** `rofinugraha549@gmail.com`
3. Jika diminta, klik **"Agree and Continue"**

#### **Step 2: Buat Project Baru**

1. Di bagian atas, klik menu **"Select a Project"**
2. Klik **"NEW PROJECT"**
3. Isi nama: `peminjaman-buku-backup`
4. Klik **"CREATE"**
5. **Tunggu 1-2 menit** sampai project siap

#### **Step 3: Enable Google Drive API**

1. Di search bar (atas), ketik: `Google Drive API`
2. Klik pada hasil yang sesuai
3. Klik **"ENABLE"** (tombol biru)
4. **Tunggu 1-2 menit** sampai enabled

#### **Step 4: Setup OAuth Consent Screen**

1. Di menu kiri, klik **"APIs & Services"**
2. Klik **"Credentials"**
3. Akan ada pesan: "To create credentials, you must first set up your OAuth 2.0 consent screen"
4. Klik **"CONFIGURE CONSENT SCREEN"**
5. Pilih **"External"** (untuk personal project)
6. Klik **"CREATE"**

**Isi form:**

```
App name: Peminjaman Buku Backup

User support email: rofinugraha549@gmail.com

Developer contact information:
Email: rofinugraha549@gmail.com
```

7. Klik **"SAVE AND CONTINUE"**
8. **Scopes page** → Klik **"SAVE AND CONTINUE"** (default scopes OK)
9. **Test users page** → Klik **"SAVE AND CONTINUE"**
10. Klik **"BACK TO DASHBOARD"**

#### **Step 5: Buat OAuth Credentials**

1. Di **"Credentials"** page, klik **"+ CREATE CREDENTIALS"**
2. Pilih **"OAuth client ID"**
3. Di **"Application type"**, pilih **"Desktop application"**
4. Isi **"Name"**: `Peminjaman Buku Backup`
5. Klik **"CREATE"**

**Anda akan dapat:**

```
Client ID: 123456789-abcdefghijklmnopqrstuvwxyz.apps.googleusercontent.com
Client Secret: GOCSPX-xxxxxxxxxxxxxxxxxxxxx
```

**📌 SIMPAN KEDUANYA!**

#### **Step 6: Download JSON Credentials**

1. Di **Credentials page**, cari OAuth client yang baru dibuat
2. Klik icon **"Download"** (panah ke bawah)
3. File akan didownload: `client_secret_*.json`
4. **Simpan file ini!**

#### **Step 7: Copy ke Laravel Project**

```bash
# Buat folder
mkdir -p storage/app/google-drive

# Copy file yang didownload ke folder
# (Copy file dari ~/Downloads/client_secret_*.json ke storage/app/google-drive/)
```

#### **Step 8: Generate Refresh Token**

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

// Generate authorization URL
$authUrl = $client->createAuthUrl();

echo "📖 Buka link berikut di browser:\n\n";
echo $authUrl . "\n\n";
echo "Setelah login dan approve, copy authorization code di sini:\n";

$authCode = trim(fgets(STDIN));

// Exchange code untuk tokens
$accessToken = $client->fetchAccessTokenWithAuthCode($authCode);
$refreshToken = $accessToken['refresh_token'] ?? null;

if ($refreshToken) {
    echo "\n✅ BERHASIL! Refresh token:\n\n";
    echo "GOOGLE_DRIVE_REFRESH_TOKEN=" . $refreshToken . "\n";
    echo "\nCopy line di atas ke .env file Anda!\n";
} else {
    echo "\n❌ Gagal mendapatkan refresh token\n";
    echo "Error: " . json_encode($accessToken) . "\n";
}
```

**Jalankan:**

```bash
php get_google_drive_token.php
```

**Yang terjadi:**

1. Script akan print URL
2. Copy URL ke browser
3. Login dengan Google
4. Approve akses
5. Copy authorization code
6. Paste ke terminal
7. Script akan print `GOOGLE_DRIVE_REFRESH_TOKEN`

#### **Step 9: Dapatkan Folder ID**

1. Buka https://drive.google.com
2. Login dengan email Anda
3. Buat folder baru: "Peminjaman Buku Backups"
4. Buka folder tersebut
5. Lihat URL browser:

```
https://drive.google.com/drive/folders/1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p
                                      ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
                                      Ini adalah Folder ID
```

6. Copy Folder ID

#### **Step 10: Update `.env`**

```env
GOOGLE_DRIVE_CLIENT_ID=123456789-abcdefghijklmnopqrstuvwxyz.apps.googleusercontent.com
GOOGLE_DRIVE_CLIENT_SECRET=GOCSPX-xxxxxxxxxxxxxxxxxxxxx
GOOGLE_DRIVE_REFRESH_TOKEN=1//0gXxx...
GOOGLE_DRIVE_FOLDER_ID=1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p
```

---

## 📝 Credentials Anda

Setelah setup, Anda akan punya:

### Metode Rclone:

```bash
Remote name: backup-google-drive

Cara akses:
rclone ls backup-google-drive:
rclone copy file.zip backup-google-drive:/folder/
```

### Metode OAuth2:

```env
GOOGLE_DRIVE_CLIENT_ID=your_client_id
GOOGLE_DRIVE_CLIENT_SECRET=your_client_secret
GOOGLE_DRIVE_REFRESH_TOKEN=your_refresh_token
GOOGLE_DRIVE_FOLDER_ID=your_folder_id
```

---

## ✅ Verification Checklist

Setelah setup:

- [ ] Rclone sudah installed (atau OAuth2 configured)
- [ ] Google Drive credentials sudah didapat
- [ ] Remote/token sudah di-setup
- [ ] Test koneksi berhasil
- [ ] Bisa list files dari Google Drive

---

## 🆘 Troubleshooting

### Error: "Access Denied"

```
Solusi:
1. Pastikan sudah login dengan email yang benar
2. Pastikan Google Drive API sudah enabled
3. Cek folder ID benar
```

### Error: "Invalid Credentials"

```
Solusi (Rclone):
1. Jalankan ulang: rclone config
2. Edit existing remote
3. Re-authenticate dengan login Google baru

Solusi (OAuth2):
1. Generate token baru dengan get_google_drive_token.php
2. Update refresh token di .env
```

### Browser tidak terbuka di Rclone

```
Solusi:
1. Copy URL dari terminal
2. Paste di browser manually
3. Login dan approve
4. Copy code dari halaman hasil
5. Paste di terminal
```

---

## 📞 Need Help?

- **Rclone Issues**: https://github.com/rclone/rclone/discussions
- **Google API Issues**: https://stackoverflow.com/questions/tagged/google-drive-api
- **Laravel Integration**: Check Laravel documentation

---

**Last Updated**: April 24, 2024
**Recommended Method**: Rclone ✅ (Paling mudah!)
