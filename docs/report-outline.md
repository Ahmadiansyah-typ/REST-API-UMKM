# Kerangka Laporan Praktikum — REST API dan JSON Parsing

> Ini kerangka, bukan PDF final. Bagian hasil pengujian, screenshot, identitas, kendala aktual, dan URL repository harus dilengkapi berdasarkan pekerjaan yang benar-benar dilakukan.

## Halaman Sampul

**Laporan Praktikum Topic 10 — REST API dan JSON Parsing**  
Mata Kuliah: [Nama mata kuliah]  
Nama: [Nama mahasiswa]  
NIM: [NIM]  
Program Studi: Ilmu Komputer  
Fakultas: [Fakultas]  
Universitas: Universitas Lambung Mangkurat  
Tahun Akademik: [Tahun akademik]

## BAB I — Pendahuluan

### 1.1 Latar Belakang

Uraikan kebutuhan komunikasi data antara aplikasi client dan server, peran REST API berbasis HTTP, serta JSON sebagai format pertukaran data.

### 1.2 Tujuan Praktikum

1. Membuat REST API CRUD untuk data UMKM menggunakan CodeIgniter 4.
2. Menguji endpoint menggunakan Postman.
3. Menghubungkan aplikasi Flutter dengan API menggunakan package HTTP.
4. Melakukan JSON Parsing dan menampilkan data secara dinamis.

### 1.3 Dasar Teori

Jelaskan REST API, HTTP methods, HTTP status code, JSON object/array, JSON Parsing, Future, async/await, try-catch, dan GetX secara ringkas.

## BAB II — Implementasi

### 2.1 Tools dan Teknologi

Cantumkan versi aktual PHP, CodeIgniter 4, MySQL/MariaDB, Flutter, Dart, `http`, `get`, VS Code, dan Postman.

### 2.2 Backend CodeIgniter 4

Jelaskan konfigurasi database, migration tabel `umkm`, `UmkmModel`, `UmkmController`, routes, validasi, serta format response JSON. Sertakan potongan kode yang relevan.

### 2.3 Frontend Flutter

Jelaskan dependency, base URL, model `Umkm`, service HTTP, controller GetX, view daftar UMKM, dan form tambah UMKM.

### 2.4 Integrasi

Tampilkan diagram alur: Flutter → HTTP Request → CI4 REST API → Database → JSON Response → JSON Parsing → UI.

## BAB III — Hasil Pengujian

Untuk setiap test case, isi:

- Endpoint dan method.
- Request URL, header, dan body.
- Status code aktual.
- Ringkasan response JSON.
- Kesimpulan lulus/tidak lulus.
- Screenshot Postman yang benar-benar diambil.

Tambahkan screenshot aplikasi Flutter setelah aplikasi berhasil dijalankan. Setiap gambar diberi nomor, judul, dan keterangan.

## BAB IV — Refleksi Hasil Pembelajaran

Tuliskan dengan sudut pandang mahasiswa berdasarkan pengalaman aktual: pemahaman REST API, CI4, JSON, JSON Parsing, integrasi, kendala, cara mengatasi, dan hal baru yang dipelajari. Jangan menyatakan kendala/keberhasilan yang tidak dialami.

## BAB V — Kesimpulan

Simpulkan pencapaian berdasarkan test case yang benar-benar dijalankan. Bedakan endpoint yang telah diuji dan bagian yang masih belum diuji.

## Daftar Source Code

Repository Public: [URL GitHub setelah dibuat]

Backend/frontend berada pada repository monorepo yang sama, di folder `backend/` dan `frontend/`.
