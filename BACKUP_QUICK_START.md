# 🚀 Backup Storage - Quick Start Guide

Pilih opsi yang sesuai untuk Anda!

---

## 🎯 1️⃣ Google Drive + Rclone (RECOMMENDED - Paling Mudah!)

### ⏱️ Setup Time: 5 menit

### 💰 Cost: FREE (15GB) + $9.99/bulan (100GB+)

### 📊 Best For: Beginners, Small databases

### Quick Steps:

```bash
# 1. Download Rclone
https://rclone.org/downloads/

# 2. Setup Google Drive
rclone config

# Follow interactive menu, login with:
# rofinugraha549@gmail.com

# 3. Test
rclone lsd backup-google-drive:

# 4. Create folder
rclone mkdir backup-google-drive:/Peminjaman-Buku-Backups

# 5. Setup scheduler (Windows Task Scheduler atau Cron)
```

### ✅ Pros:

- Super mudah
- Gratis 15GB
- Tidak perlu account baru
- Auto token refresh

### ❌ Cons:

- Slower upload (~50MB/s)
- Limited storage

### 📖 Full Guide:

- See: `GOOGLE_DRIVE_RCLONE.md`

---

## 🟠 2️⃣ Google Drive + OAuth2 (Advanced)

### ⏱️ Setup Time: 30 menit

### 💰 Cost: FREE (15GB) + $9.99/bulan (100GB+)

### 📊 Best For: Laravel developers, Custom integration

### Quick Steps:

```bash
# 1. Create Google Cloud Project
https://console.cloud.google.com/

# 2. Enable Google Drive API
# Search "Google Drive API" → Enable

# 3. Create OAuth Credentials
# APIs & Services → Credentials → Create OAuth2 Desktop app

# 4. Download client_secret.json
# Copy to: storage/app/google-drive/client_secret.json

# 5. Run token generation script
php get_google_drive_token.php

# 6. Copy token to .env
GOOGLE_DRIVE_REFRESH_TOKEN=1//0gXxx...

# 7. Update config/filesystems.php
# Add google-drive disk configuration

# 8. Update config/backup.php
# Set destination disk to google-drive
```

### ✅ Pros:

- Full control
- Direct Laravel integration
- API monitoring
- Custom scopes

### ❌ Cons:

- More complex setup
- Token management
- Requires Google Cloud project
- Higher learning curve

### 📖 Full Guide:

- See: `GOOGLE_DRIVE_SETUP.md`

---

## 🔴 3️⃣ AWS S3 (Professional)

### ⏱️ Setup Time: 30 menit

### 💰 Cost: FREE (5GB/12mo) + $0.023/GB/bulan

### 📊 Best For: Enterprise, Large databases, High performance

### Quick Steps:

```bash
# 1. Create AWS Account
https://aws.amazon.com/
Sign up with: rofinugraha549@gmail.com

# 2. Create S3 Bucket
# S3 Console → Create bucket
# Name: peminjaman-buku-backups-20240424
# Region: ap-southeast-1

# 3. Create IAM User
# IAM → Users → Create user
# Attach: AmazonS3FullAccess policy

# 4. Generate Access Keys
# User → Security credentials → Create access key
# Copy: Access Key ID + Secret Access Key

# 5. Update .env
AWS_ACCESS_KEY_ID=your_key
AWS_SECRET_ACCESS_KEY=your_secret
AWS_DEFAULT_REGION=ap-southeast-1
AWS_BUCKET=peminjaman-buku-backups-20240424

# 6. Test backup
php artisan backup:run
```

### ✅ Pros:

- Very fast (~1000MB/s)
- Unlimited storage
- Enterprise-grade
- Multi-region available
- Version control
- Encryption built-in

### ❌ Cons:

- More complex setup
- AWS account required
- Recurring cost
- Learning curve higher

### 📖 Full Guide:

- See: `AWS_SETUP_GUIDE.md`

---

## 🟡 4️⃣ DigitalOcean Spaces (Middle Ground)

### ⏱️ Setup Time: 20 menit

### 💰 Cost: $5-15/bulan (flat rate, not per-GB)

### 📊 Best For: Startups, Medium databases

### Quick Steps:

```bash
# 1. Create DigitalOcean Account
https://www.digitalocean.com/
Sign up

# 2. Create Spaces
# Spaces → Create Space
# Name: peminjaman-buku-backup
# Region: Singapore

# 3. Generate API Keys
# API → Tokens → Generate New Token

# 4. Configure AWS compatibility
# Get Space Key + Secret

# 5. Update .env
AWS_ACCESS_KEY_ID=your_space_key
AWS_SECRET_ACCESS_KEY=your_space_secret
AWS_DEFAULT_REGION=sgp1
AWS_BUCKET=peminjaman-buku-backup
AWS_ENDPOINT=https://sgp1.digitaloceanspaces.com

# 6. Test
php artisan backup:run
```

### ✅ Pros:

- Simpler than AWS
- Cheaper than AWS
- Good performance
- Simple pricing (flat)
- CDN included

### ❌ Cons:

- Smaller community
- Less feature-rich
- Still requires new account

### 📖 Full Guide:

- Similar to AWS, use S3-compatible endpoint

---

## 🔓 5️⃣ MinIO Self-Hosted (DIY)

### ⏱️ Setup Time: 1+ jam

### 💰 Cost: ~$500 (hardware) + maintenance

### 📊 Best For: Privacy-critical, On-premise only

### Quick Steps:

```bash
# 1. Install MinIO on your server
https://min.io/download

# 2. Start MinIO server
minio server /data

# 3. Access web console
http://localhost:9000

# 4. Create bucket
# Web console → Create bucket

# 5. Generate credentials
# Access Key + Secret Key

# 6. Configure Laravel
AWS_ENDPOINT=http://your-minio-server:9000
AWS_ACCESS_KEY_ID=minioadmin
AWS_SECRET_ACCESS_KEY=minioadmin
AWS_BUCKET=backups
AWS_USE_PATH_STYLE_ENDPOINT=true

# 7. Test
php artisan backup:run
```

### ✅ Pros:

- Full control
- No recurring cost
- On-premise (privacy)
- Unlimited storage

### ❌ Cons:

- Requires server setup
- Hardware cost
- Complex maintenance
- Disaster recovery DIY

### 📖 Full Guide:

- See: MinIO documentation

---

## 🎯 Quick Decision Guide

### Q1: What's your budget?

- **Limited**: → Google Drive Rclone ✅
- **Some budget**: → DigitalOcean Spaces ✅
- **Unlimited**: → AWS S3 ✅

### Q2: What's your database size?

- **< 100GB**: → Google Drive ✅
- **100GB - 1TB**: → AWS S3 or DigitalOcean ✅
- **> 1TB**: → AWS S3 or MinIO ✅

### Q3: How technical are you?

- **Beginner**: → Google Drive Rclone ✅
- **Intermediate**: → Google Drive OAuth2 or DigitalOcean ✅
- **Advanced**: → AWS S3 or MinIO ✅

### Q4: What's your priority?

- **Ease**: → Google Drive Rclone ✅
- **Cost**: → Google Drive Rclone ✅
- **Performance**: → AWS S3 ✅
- **Privacy**: → MinIO ✅
- **Balance**: → DigitalOcean Spaces ✅

---

## 📊 Comparison at a Glance

| Option                 | Setup       | Cost      | Speed     | Best For         |
| ---------------------- | ----------- | --------- | --------- | ---------------- |
| 🟢 Google Drive Rclone | ⭐ Easy     | FREE      | 50MB/s    | **Beginners** ✅ |
| 🟠 Google Drive OAuth2 | ⭐⭐⭐ Hard | FREE      | 50MB/s    | Developers       |
| 🔴 AWS S3              | ⭐⭐⭐ Hard | $0.023/GB | 1000MB/s  | Enterprise       |
| 🟡 DO Spaces           | ⭐⭐ Medium | $5-15/mo  | 500MB/s   | Startups         |
| 🔓 MinIO               | ⭐⭐⭐ Hard | $500+     | Unlimited | Privacy          |

---

## ✅ RECOMMENDATION FOR PEMINJAMAN BUKU

### Choose: **Google Drive + Rclone** ✅✅✅

### Why:

1. ✅ Paling mudah (5 menit setup)
2. ✅ Gratis 15GB (cukup bertahun-tahun)
3. ✅ Tidak perlu account baru
4. ✅ Bisa upgrade kapan saja
5. ✅ Perfect untuk project ini

### Setup Path:

```
Now: Google Drive Rclone (Free, Easy) ✅
Future: Upgrade to Google One ($9.99/mo) jika perlu
Later: Migrate to AWS S3 jika database besar
```

---

## 🚀 Next Steps

### Choose one option above, then:

1. **Read the full guide** (see files listed)
2. **Setup step-by-step** (follow the guide)
3. **Test your backup** (run manual backup)
4. **Schedule it** (setup scheduler)
5. **Monitor it** (check logs weekly)

---

## 📚 Available Guides

- `BACKUP_SETUP.md` - Original setup guide
- `BACKUP_QUICK_REFERENCE.md` - Quick checklist
- `AWS_SETUP_GUIDE.md` - AWS S3 detailed guide
- `AWS_SETUP_CHECKLIST.md` - AWS S3 checklist
- `GOOGLE_DRIVE_SETUP.md` - Google Drive OAuth2 detailed guide
- `GOOGLE_DRIVE_RCLONE.md` - Google Drive Rclone (easiest!) ✅
- `BACKUP_OPTIONS_COMPARISON.md` - Full comparison

---

## 💬 Questions?

Each guide has:

- Step-by-step instructions
- Troubleshooting section
- Useful commands
- Resource links

**Pick your option and follow the guide!** 🚀

---

**Last Updated**: April 24, 2024
**Recommendation**: Google Drive + Rclone ✅
