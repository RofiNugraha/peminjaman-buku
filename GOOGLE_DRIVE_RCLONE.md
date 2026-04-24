# 🟢 Google Drive Backup dengan Rclone (Paling Mudah!)

## ✨ Kenapa Rclone?

Rclone adalah tool yang **SANGAT MUDAH** untuk backup ke Google Drive. Dibanding OAuth2 manual, Rclone:

- ✅ UI interaktif untuk setup
- ✅ Hanya perlu login 1x
- ✅ Automatic token refresh
- ✅ Tidak perlu generate token manual
- ✅ Support 40+ cloud storage

---

## 🚀 Setup Rclone (5 Menit!)

### **Step 1: Install Rclone**

#### Windows (Recommended)

```bash
# Download dari: https://rclone.org/downloads/

# Atau gunakan Chocolatey:
choco install rclone

# Atau gunakan Package Manager:
scoop install rclone
```

#### Linux/Mac

```bash
curl https://rclone.org/install.sh | sudo bash
```

#### Verifikasi instalasi

```bash
rclone --version
```

---

### **Step 2: Setup Google Drive di Rclone**

```bash
# Jalankan interactive setup
rclone config

# Akan muncul menu:
# n) New remote
# s) Set configuration password
# q) Quit config

# Ketik: n (untuk new remote)
```

**Follow the interactive menu:**

```
name> backup-google-drive
(Nama untuk remote)

Type of storage> 16
(Pilih "Google Drive")

Google Application Client Id> [Enter untuk skip]
(Biarkan kosong, gunakan default)

Google Application Client Secret> [Enter untuk skip]
(Biarkan kosong, gunakan default)

scope> 1
(Pilih "drive" - full access)

root_folder_id> [Enter untuk skip]
(Biarkan kosong untuk root folder)

service_account_file> [Enter untuk skip]
(Biarkan kosong)

Edit advanced config> n
(Tidak perlu)

Use web browser to authenticate rclone? y
(Ketik: y)
```

**Browser akan terbuka otomatis:**

1. Login dengan email: `rofinugraha549@gmail.com`
2. Klik "Allow" untuk memberikan akses
3. Klik "Confirm"
4. Browser akan close otomatis

**Back to terminal:**

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

✅ **Setup selesai!**

---

### **Step 3: Test Rclone**

```bash
# List files di Google Drive
rclone lsd backup-google-drive:

# Buat folder test
rclone mkdir backup-google-drive:/Peminjaman-Buku-Backups

# List folder
rclone ls backup-google-drive:/Peminjaman-Buku-Backups
```

---

### **Step 4: Setup Backup Script**

Buat file: `backup-to-google-drive.sh` (Linux/Mac) atau `.bat` (Windows)

#### Linux/Mac: `backup-to-google-drive.sh`

```bash
#!/bin/bash

# Configuration
PROJECT_PATH="/path/to/peminjaman-buku"
BACKUP_FOLDER="/Peminjaman-Buku-Backups"
RCLONE_REMOTE="backup-google-drive"
LOG_FILE="$PROJECT_PATH/storage/logs/backup-google-drive.log"

# Timestamp
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
BACKUP_NAME="backup-$TIMESTAMP.sql"

# Create backup
echo "🔄 Starting backup at $(date)" >> $LOG_FILE
cd $PROJECT_PATH

# Dump database
mysqldump -u root peminjaman_buku > /tmp/$BACKUP_NAME

# Compress
gzip /tmp/$BACKUP_NAME
BACKUP_FILE="/tmp/${BACKUP_NAME}.gz"

# Upload to Google Drive
rclone copy "$BACKUP_FILE" "$RCLONE_REMOTE:$BACKUP_FOLDER" -v >> $LOG_FILE 2>&1

# Check result
if [ $? -eq 0 ]; then
    echo "✅ Backup completed at $(date)" >> $LOG_FILE
    rm -f $BACKUP_FILE
else
    echo "❌ Backup failed at $(date)" >> $LOG_FILE
fi
```

#### Windows: `backup-to-google-drive.bat`

```batch
@echo off

REM Configuration
SET PROJECT_PATH=C:\laragon\www\peminjaman-buku
SET BACKUP_FOLDER=/Peminjaman-Buku-Backups
SET RCLONE_REMOTE=backup-google-drive
SET LOG_FILE=%PROJECT_PATH%\storage\logs\backup-google-drive.log

REM Timestamp
FOR /F "tokens=2-4 delims=/ " %%a IN ('date /t') DO (SET mydate=%%c-%%a-%%b)
FOR /F "tokens=1-2 delims=/:" %%a IN ('time /t') DO (SET mytime=%%a-%%b)
SET TIMESTAMP=%mydate%-%mytime%
SET BACKUP_NAME=backup-%TIMESTAMP%.sql

REM Create backup
echo. >> %LOG_FILE%
echo 2024-04-24 Starting backup >> %LOG_FILE%
cd /d %PROJECT_PATH%

REM Dump database (gunakan mysqldump)
mysqldump -u root peminjaman_buku > C:\temp\%BACKUP_NAME%

REM Compress (gunakan 7z atau zip)
7z a C:\temp\%BACKUP_NAME%.7z C:\temp\%BACKUP_NAME%

REM Upload to Google Drive
rclone copy "C:\temp\%BACKUP_NAME%.7z" "%RCLONE_REMOTE:%BACKUP_FOLDER%" >> %LOG_FILE% 2>&1

IF %ERRORLEVEL% EQU 0 (
    echo Backup completed successfully >> %LOG_FILE%
    del C:\temp\%BACKUP_NAME%*
) ELSE (
    echo Backup failed >> %LOG_FILE%
)
```

---

### **Step 5: Setup Scheduler**

#### Linux/Mac: Cron Job

```bash
# Edit crontab
crontab -e

# Tambahkan (backup setiap hari jam 2 pagi):
0 2 * * * /path/to/backup-to-google-drive.sh >> /dev/null 2>&1
```

#### Windows: Task Scheduler

1. Buka **Task Scheduler**
2. Klik **"Create Basic Task"**
3. Nama: `Google Drive Database Backup`
4. Trigger: **Daily** at **2:00 AM**
5. Action: **Start a program**
    - Program: `C:\Windows\System32\cmd.exe`
    - Arguments: `/c C:\path\to\backup-to-google-drive.bat`
6. Klik **"OK"**

---

### **Step 6: Test Backup**

```bash
# Test script (Linux/Mac)
bash /path/to/backup-to-google-drive.sh

# Test script (Windows)
C:\path\to\backup-to-google-drive.bat

# Check log
tail -f storage/logs/backup-google-drive.log

# Verify di Google Drive
# Buka: https://drive.google.com
# Cek folder: Peminjaman-Buku-Backups
# Harus ada file .sql.gz baru
```

---

## 🎯 Integrasi dengan Laravel Scheduler

Jika ingin menggunakan Laravel schedule (rekomendasi), setup seperti ini:

### Update `routes/console.php`

```php
Schedule::call(function () {
    $backupPath = storage_path('app/backups');
    $files = glob($backupPath . '/*.zip');

    if (!empty($files)) {
        $latestBackup = max($files);

        // Upload ke Google Drive
        \Illuminate\Support\Facades\Storage::disk('google-drive')
            ->put('backups/' . basename($latestBackup), file_get_contents($latestBackup));

        \Illuminate\Support\Facades\Log::info('Backup uploaded to Google Drive: ' . basename($latestBackup));
    }
})->daily()->at('02:30');
```

---

## 📊 Comparison: Berbagai Metode Backup ke Google Drive

| Method                | Difficulty     | Setup Time | Speed   | Best For      |
| --------------------- | -------------- | ---------- | ------- | ------------- |
| **Rclone**            | ⭐ Super Mudah | 5 min      | Fast    | Recommended!  |
| **OAuth2 Manual**     | ⭐⭐⭐ Rumit   | 30 min     | Medium  | Developers    |
| **Google Drive Sync** | ⭐ Mudah       | 10 min     | Slow    | Small backups |
| **AWS S3**            | ⭐⭐⭐ Rumit   | 20 min     | Fastest | Enterprise    |

**Rekomendasi**: Gunakan **Rclone** - paling mudah! ✅

---

## 🔒 Security Best Practices

```bash
# 1. Secure rclone config
chmod 600 ~/.config/rclone/rclone.conf  # Linux/Mac
# Atau gunakan credential locking di Windows

# 2. Monitor backups
# Set reminder untuk check backup setiap minggu

# 3. Test restore
# Monthly test restore dari backup terbaru

# 4. Version control
# Jangan commit .env atau config rclone ke git
```

---

## 🚨 Troubleshooting

### Error: "403 Forbidden"

```
Solusi:
1. Google Drive storage penuh
2. Quota limit tercapai
3. Re-authenticate: rclone config
```

### Backup incomplete

```
Solusi:
1. Check internet connection
2. Check Google Drive space
3. Increase timeout di rclone config
```

### Slow upload

```
Solusi:
1. Google Drive limit upload speed
2. Gunakan compression (-z flag)
3. Upload di jam non-peak
```

---

## 📚 Useful Commands

```bash
# List remotes
rclone listremotes

# Show config
rclone config show

# Tree view
rclone tree backup-google-drive:/

# Size of folder
rclone size backup-google-drive:/Peminjaman-Buku-Backups

# Delete old files
rclone delete backup-google-drive:/Peminjaman-Buku-Backups --min-age 90d

# Sync (two-way)
rclone sync /local/path backup-google-drive:/remote-path
```

---

## 🎉 Setup Complete!

Setelah selesai:

1. ✅ Rclone configured
2. ✅ Script setup
3. ✅ Scheduler configured
4. ✅ Test backup successful
5. ✅ Files di Google Drive

**Status**: ✅ Ready!

---

**Last Updated**: April 24, 2024
**Recommended**: YES ✅ - Paling mudah!
