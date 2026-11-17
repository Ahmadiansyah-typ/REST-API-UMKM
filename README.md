# REST API UMKM — CodeIgniter 4 & Flutter

Aplikasi direktori UMKM (Usaha Mikro, Kecil, dan Menengah) berbasis Flutter yang terintegrasi dengan REST API menggunakan CodeIgniter 4 dan database MySQL/MariaDB.

Proyek ini dibuat untuk memenuhi tugas praktikum **Topic 10: REST API dan JSON Parsing**. Aplikasi memungkinkan pengguna melihat daftar UMKM, menambahkan data usaha, memperbarui informasi, dan menghapus data melalui komunikasi REST API dalam format JSON.

---

## 📌 Fitur Aplikasi

### Backend — CodeIgniter 4
- REST API untuk pengelolaan data UMKM.
- Operasi CRUD (Create, Read, Update, Delete).
- Validasi data sebelum disimpan.
- Response API menggunakan format JSON.
- Integrasi database MySQL/MariaDB.

### Frontend — Flutter
- Menampilkan daftar UMKM dari REST API.
- Menambahkan data UMKM melalui formulir.
- Mengirim dan menerima data dalam format JSON.
- Parsing JSON ke dalam model Dart.
- Menggunakan package `http` untuk komunikasi API.
- Menggunakan GetX untuk state management.
- Menampilkan informasi nama usaha, pemilik, alamat, kategori, dan kontak.

---

## 🛠️ Teknologi yang Digunakan

| Teknologi | Keterangan |
|---|---|
| PHP 8.2.12 | Bahasa pemrograman backend |
| CodeIgniter 4 | Framework REST API |
| Flutter 3.47.1 | Framework frontend |
| Dart 3.13.1 | Bahasa pemrograman Flutter |
| MySQL/MariaDB 10.4.32 | Database |
| Apache | Web server |
| Postman | Pengujian REST API |
| GetX | State management |
| HTTP | Komunikasi antara Flutter dan API |

---

## 📂 Struktur Repository

```text
project-rest-api-flutter/
│
├── backend/
│   ├── app/
│   │   ├── Config/
│   │   │   └── Routes.php
│   │   ├── Controllers/
│   │   │   └── Api/
│   │   │       └── UmkmController.php
│   │   ├── Database/
│   │   │   └── Migrations/
│   │   └── Models/
│   │       └── UmkmModel.php
│   │
│   ├── .env.example
│   ├── setup.ps1
│   ├── setup.sh
│   └── README.md
│
├── frontend/
│   ├── lib/
│   │   ├── app/
│   │   │   ├── controllers/
│   │   │   ├── models/
│   │   │   ├── routes/
│   │   │   ├── services/
│   │   │   └── views/
│   │   └── main.dart
│   │
│   ├── pubspec.yaml
│   └── README.md
│
├── docs/
│   ├── implementation-notes.md
│   ├── api-test-plan.md
│   ├── openapi.yaml
│   └── report-outline.md
│
├── postman/
│   └── UMKM-CRUD.postman_collection.json
│
├── .gitignore
└── README.md
```

**Catatan:** Folder `backend/runtime/` dibuat ketika proses setup backend dijalankan. Folder tersebut berisi kerangka aplikasi CodeIgniter 4 lengkap dan dependency Composer sehingga tidak disertakan dalam repository GitHub.

---

## ⚙️ Instalasi dan Konfigurasi

### 1. Clone Repository

```bash
git clone https://github.com/Ahmadiansyah-typ/REST-API-UMKM.git
```

Masuk ke direktori proyek:

```bash
cd REST-API-UMKM
```

### 2. Konfigurasi Backend

Pastikan sudah menginstal:
- PHP 8.2 atau versi yang kompatibel.
- Composer.
- MySQL atau MariaDB.
- Ekstensi PHP yang dibutuhkan CodeIgniter 4.

Jalankan setup backend menggunakan PowerShell (Windows):

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\backend\setup.ps1
```

Untuk Linux/macOS:

```bash
bash backend/setup.sh
```

Skrip setup akan menyiapkan kerangka CodeIgniter 4 dan menyalin source backend ke dalam direktori runtime.

### 3. Konfigurasi Database

Buat database melalui phpMyAdmin atau MySQL:

```sql
CREATE DATABASE db_umkm
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

Salin konfigurasi `.env.example` menjadi `.env` apabila belum dibuat oleh skrip setup.

Atur konfigurasi database pada:

```text
backend/runtime/.env
```

Sesuaikan nama database, username, dan password dengan konfigurasi MySQL lokal.

### 4. Menjalankan Backend

Masuk ke direktori runtime:

```bash
cd backend/runtime
```

Jalankan migration:

```bash
php spark migrate
```

Periksa daftar route:

```bash
php spark routes
```

Jalankan server:

```bash
php spark serve --host 0.0.0.0 --port 8080
```

Backend dapat diakses melalui:

```text
http://localhost:8080
```

Endpoint utama:

```text
http://localhost:8080/api/umkm
```

---

## 📱 Menjalankan Aplikasi Flutter

Pastikan Flutter SDK sudah terinstal dan dapat dijalankan melalui terminal.

Masuk ke direktori frontend:

```bash
cd frontend
```

Instal dependency:

```bash
flutter pub get
```

Jika platform runner belum tersedia, buat konfigurasi platform sesuai perangkat yang digunakan:

```bash
flutter create --platforms=android,ios,web .
```

Jalankan aplikasi:

```bash
flutter run
```

### Konfigurasi Base URL

Sesuaikan alamat API dengan perangkat yang digunakan:

| Perangkat | Base URL |
|---|---|
| Android Emulator | `http://10.0.2.2:8080/api` |
| Browser/Web | `http://localhost:8080/api` |
| Android Fisik | `http://IP_KOMPUTER:8080/api` |

Pastikan backend berjalan dan perangkat dapat mengakses server API.

Untuk Android fisik, gunakan alamat IP komputer dalam jaringan Wi-Fi yang sama.

---

## 🔗 Dokumentasi Endpoint REST API

API menyediakan empat operasi utama CRUD:

| No. | Method | Endpoint | Fungsi |
|---|---|---|---|
| 1 | GET | `/api/umkm` | Mengambil seluruh data UMKM |
| 2 | POST | `/api/umkm` | Menambahkan data UMKM |
| 3 | PUT | `/api/umkm/{id}` | Memperbarui data UMKM berdasarkan ID |
| 4 | DELETE | `/api/umkm/{id}` | Menghapus data UMKM berdasarkan ID |

### Struktur Data UMKM

| Field | Tipe Data | Keterangan |
|---|---|---|
| id | Integer | ID unik UMKM |
| nama_umkm | String | Nama usaha |
| pemilik | String | Nama pemilik usaha |
| alamat | String | Alamat usaha |
| kategori | String | Kategori usaha |
| kontak | String | Nomor kontak |

### Contoh JSON Request

```json
{
  "nama_umkm": "Kopi Praktikum",
  "pemilik": "Ahmadiansyah",
  "alamat": "Banjarbaru",
  "kategori": "Kuliner",
  "kontak": "081234567890"
}
```

### Contoh JSON Response

```json
{
  "success": true,
  "message": "Data UMKM berhasil ditambahkan",
  "data": {
    "id": 1,
    "nama_umkm": "Kopi Praktikum",
    "pemilik": "Ahmadiansyah",
    "alamat": "Banjarbaru",
    "kategori": "Kuliner",
    "kontak": "081234567890"
  }
}
```

---

## 🧪 Pengujian REST API

Pengujian REST API dilakukan menggunakan Postman dengan beberapa skenario:

| No. | Skenario Pengujian | Method | Hasil |
|---|---|---|---|
| 1 | Mengambil daftar UMKM | GET | Berhasil |
| 2 | Menambahkan UMKM | POST | Berhasil |
| 3 | Validasi nama UMKM kosong | POST | Menghasilkan error validasi |
| 4 | Memperbarui data UMKM | PUT | Berhasil |
| 5 | Memperbarui ID yang tidak ditemukan | PUT | Menghasilkan error 404 |
| 6 | Menghapus data UMKM | DELETE | Berhasil |
| 7 | Menghapus ID yang tidak ditemukan | DELETE | Menghasilkan error 404 |

Pengujian dapat dilakukan menggunakan Postman Collection yang tersedia di:

```text
postman/UMKM-CRUD.postman_collection.json
```

Dokumentasi pengujian lebih lengkap tersedia di:

```text
docs/api-test-plan.md
```

---

## 🖥️ Tampilan Aplikasi

Aplikasi UMKM Connect memiliki beberapa tampilan utama:

1. **Halaman Daftar UMKM** — Menampilkan seluruh data usaha yang diperoleh dari REST API.
2. **Halaman Tambah UMKM** — Formulir untuk memasukkan informasi usaha baru.
3. **Integrasi REST API** — Mengirim dan menerima data melalui HTTP Request dan JSON Response.

---

## 📚 Dokumentasi Tambahan

Beberapa dokumentasi pendukung tersedia di dalam repository:

- `docs/implementation-notes.md` — Catatan implementasi proyek.
- `docs/api-test-plan.md` — Rencana dan skenario pengujian API.
- `docs/openapi.yaml` — Dokumentasi spesifikasi endpoint API.
- `docs/report-outline.md` — Kerangka laporan praktikum.
- `postman/UMKM-CRUD.postman_collection.json` — Koleksi pengujian Postman.

---

## 🎯 Tujuan Praktikum

Proyek ini bertujuan untuk memahami penerapan REST API dan JSON Parsing dalam pengembangan aplikasi mobile, khususnya:

- Memahami konsep REST API.
- Mengimplementasikan operasi CRUD.
- Memahami komunikasi HTTP antara frontend dan backend.
- Mengirim dan menerima data menggunakan format JSON.
- Melakukan parsing JSON ke model Dart.
- Mengintegrasikan aplikasi Flutter dengan backend CodeIgniter 4.
- Menguji endpoint API menggunakan Postman.

---

## 👨‍💻 Pengembang

**Ahmadiansyah**

Proyek Praktikum — Topic 10: REST API dan JSON Parsing.

**Repository GitHub:**

https://github.com/Ahmadiansyah-typ/REST-API-UMKM

---

*Dibuat untuk memenuhi tugas praktikum REST API dan JSON Parsing.*
