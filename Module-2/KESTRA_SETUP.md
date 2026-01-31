# Kestra Setup Guide

## Prasyarat
- Docker dan Docker Compose terinstal
- Port 8080 dan 5432 tidak digunakan oleh aplikasi lain

## Instalasi & Startup

### 1. Jalankan Services
> **Note:** Gunakan `docker-compose.yml` universal di root project.

```bash
cd ../..
docker compose up -d
```

### 2. Verifikasi Status
```bash
docker compose ps
```

Anda seharusnya melihat kedua service (`kestra` dan `postgres`) berstatus `Up`.

### 3. Akses UI Kestra
Buka browser dan navigasikan ke: **http://localhost:8081**

## Menghentikan Services
```bash
docker compose down
```

Untuk menghapus volumes (database):
```bash
docker compose down -v
```

## Konfigurasi AI Copilot (Opsional)

Jika ingin menggunakan fitur AI untuk membuat workflow otomatis:

1. **Dapatkan Gemini API Key:**
   - Kunjungi https://makersuite.google.com/app/apikeys
   - Buat API key baru

2. **Atur Environment Variable:**
   ```bash
   # Linux/Mac
   export GEMINI_API_KEY="your-api-key-here"
   docker compose up -d

   # PowerShell (Windows)
   $env:GEMINI_API_KEY="your-api-key-here"
   docker compose up -d
   ```

3. **Update `.env` file:**
   - Uncomment baris `GEMINI_API_KEY` 
   - Masukkan API key Anda

## Database Credentials

| Item | Value |
|------|-------|
| Host | postgres |
| Port | 5432 |
| Database | kestra |
| Username | kestra |
| Password | kestra_password |

## Troubleshooting

### Port 8080 sudah digunakan
Edit `docker-compose.yml` dan ubah port mapping:
```yaml
ports:
  - "18080:8080"  # Akses via http://localhost:18080
```

### Container tidak bisa terhubung ke database
Pastikan:
1. PostgreSQL container sehat: `docker compose logs postgres`
2. Jalankan ulang: `docker compose down && docker compose up -d`

### Melihat logs
```bash
docker compose logs kestra       # Logs Kestra
docker compose logs postgres     # Logs PostgreSQL
docker compose logs -f           # Follow logs (real-time)
```

## Image Versions
- Kestra: `v1.1` (stable)
- PostgreSQL: `18` (latest stable)

Hindari tag `:develop` karena mungkin mengandung bugs.

