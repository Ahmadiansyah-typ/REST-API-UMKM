# REST API UMKM — CodeIgniter 4 & Flutter

Proyek praktikum Topic 10: REST API dan JSON Parsing. Backend menyediakan REST API CRUD untuk data UMKM menggunakan CodeIgniter 4. Aplikasi Flutter mengonsumsi API menggunakan package `http`, memetakan JSON ke model Dart, dan memakai GetX untuk state management.

> **Status saat paket ini dibuat:** source backend dan frontend sudah disiapkan. Build, koneksi database, request Postman, dan run Flutter belum diverifikasi pada mesin ini karena Composer dan Flutter SDK tidak tersedia. Jangan menganggap screenshot atau test case pada dokumen sebagai hasil pengujian yang sudah dilakukan.

## Isi repository

```text
project-rest-api-flutter/
├── backend/
│   ├── app/
│   │   ├── Config/Routes.php
│   │   ├── Controllers/Api/UmkmController.php
│   │   ├── Database/Migrations/2026-11-17-000001_CreateUmkmTable.php
│   │   └── Models/UmkmModel.php
│   ├── .env.example
│   ├── setup.ps1
│   ├── setup.sh
│   └── README.md
├── frontend/
│   ├── lib/
│   │   ├── app/controllers/
│   │   ├── app/models/
│   │   ├── app/routes/
│   │   ├── app/services/
│   │   ├── app/views/
│   │   └── main.dart
│   ├── pubspec.yaml
│   └── README.md
├── docs/
│   ├── implementation-notes.md
│   ├── api-test-plan.md
│   ├── openapi.yaml
│   └── report-outline.md
└── postman/UMKM-CRUD.postman_collection.json
```

Folder `backend/app` berisi kode aplikasi yang menimpa/menambahkan bagian pada kerangka CodeIgniter 4. Folder `backend/runtime` akan dibuat oleh skrip setup dan diabaikan Git; folder tersebut berisi kerangka CI4 lengkap beserta `vendor`.

## 1. Menyiapkan backend

Persyaratan: PHP yang memenuhi kebutuhan CodeIgniter 4, Composer, MySQL/MariaDB, dan ekstensi PHP yang dibutuhkan driver database.

### Windows PowerShell

Dari root repository:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\backend\setup.ps1
```

### macOS / Linux

```bash
bash backend/setup.sh
```

Skrip mengunduh kerangka resmi `codeigniter4/appstarter` dengan Composer, menyalin source praktikum ke kerangka tersebut, lalu membuat `backend/runtime/.env` dari contoh konfigurasi.

Buat database MySQL terlebih dahulu:

```sql
CREATE DATABASE db_umkm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Edit kredensial dan nama database pada `backend/runtime/.env`. Kemudian:

```bash
cd backend/runtime
php spark migrate
php spark routes
php spark serve --host 0.0.0.0 --port 8080
```

API lokal: `http://localhost:8080/api/umkm`.

## 2. Menyiapkan Flutter

Masuk ke folder frontend, buat platform runner pada mesin pengembang, kemudian pasang dependency:

```bash
cd frontend
flutter create --platforms=android,ios,web .
flutter pub get
```

Periksa kembali bahwa file `lib/` dan `pubspec.yaml` dari repository tetap digunakan setelah perintah `flutter create`. Jalankan aplikasi pada Android Emulator:

```bash
flutter run
```

Base URL default sudah diset untuk Android Emulator (`10.0.2.2`). Untuk alamat lain, jalankan dengan `--dart-define` sesuai panduan di `frontend/README.md`.

## 3. Endpoint API

| Method | Endpoint | Fungsi | Status sukses |
|---|---|---|---|
| GET | `/api/umkm` | Mengambil seluruh UMKM | 200 |
| POST | `/api/umkm` | Menambahkan UMKM | 201 |
| PUT | `/api/umkm/{id}` | Memperbarui UMKM | 200 |
| DELETE | `/api/umkm/{id}` | Menghapus UMKM | 200 |

Field data: `nama_umkm`, `pemilik`, `alamat`, `kategori`, dan `kontak`. Response mengikuti envelope `success`, `message`, dan `data`; response error menambahkan `errors`.

Dokumentasi test case dan contoh request terdapat pada:

- `docs/api-test-plan.md`
- `postman/UMKM-CRUD.postman_collection.json`
- `docs/openapi.yaml`

## 4. Pengujian dan screenshot

Import collection Postman, pastikan server dan database berjalan, lalu uji GET, POST, PUT, dan DELETE. Screenshot harus diambil langsung dari Postman setelah request benar-benar dijalankan. Daftar bukti yang disarankan tersedia dalam `docs/api-test-plan.md`.

## 5. GitHub Public

Setelah membuat repository GitHub Public, dari root repository jalankan:

```bash
git init
git add .
git commit -m "Initial project: REST API UMKM with CI4 and Flutter"
git branch -M main
git remote add origin <URL_REPOSITORY_GITHUB_ANDA>
git push -u origin main
```

Jangan mengunggah `.env`, `backend/runtime`, `vendor`, `.dart_tool`, atau folder `build`. Jangan mengganti placeholder remote sebelum repository benar-benar dibuat.

## 6. Laporan praktikum

Kerangka isi laporan ada di `docs/report-outline.md`. PDF final belum dibuat karena harus memuat screenshot Postman dan tampilan aplikasi yang benar-benar berasal dari pengujian Anda, serta URL GitHub Public yang sudah dibuat. Jangan mengisi bagian hasil dengan hasil yang belum diverifikasi.
