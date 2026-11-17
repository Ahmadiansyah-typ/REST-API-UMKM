# Catatan Analisis Materi dan Keputusan Implementasi

## Materi yang menjadi acuan

1. PPT Topic 10 — REST API dan JSON Parsing.
2. PDF Praktikum Modul 10.1 (REST API CI4), Modul 10.2 (CORS), dan Modul 10.3 (Flutter).

## Tujuan dan ruang lingkup

- Membangun REST API CRUD untuk objek UMKM menggunakan CodeIgniter 4.
- Menggunakan database melalui migration dan model CI4.
- Mengembalikan data dalam response JSON yang konsisten.
- Mengonsumsi API menggunakan Flutter, package `http`, model Dart, dan GetX.
- Menguji endpoint melalui Postman atau tools serupa.

## Detail yang dipertahankan dari materi

- Empat endpoint: `GET /api/umkm`, `POST /api/umkm`, `PUT /api/umkm/{id}`, `DELETE /api/umkm/{id}`.
- Field tabel: `id`, `nama_umkm`, `pemilik`, `alamat`, `kategori`, `kontak`, `created_at`, `updated_at`.
- Struktur CI4: `Controllers/Api/UmkmController.php`, `Models/UmkmModel.php`, `Config/Routes.php`, dan migration.
- Response menggunakan `success`, `message`, `data`; error menggunakan `success: false`, `message`, dan `errors`.
- Flutter memakai `http: ^1.5.0` dan `get: ^4.7.2`.
- Struktur Flutter memisahkan `models`, `services`, `controllers`, `views`, dan `routes`.
- Parsing menggunakan `dart:convert` / `jsonDecode` dan `factory Umkm.fromJson()`.
- GET mengambil daftar data; POST menambahkan data; daftar menyediakan loading, empty state, dan pull-to-refresh.

## Perbedaan dan koreksi yang perlu diketahui

1. **Perintah generator Model.** PDF halaman 2 tampak menuliskan `php spark make:mode UmkmModel`. Ini merupakan salah ketik; sintaks generator CI4 adalah `php spark make:model UmkmModel`. File model sudah disertakan sehingga generator tidak wajib dijalankan lagi.
2. **Body POST.** PDF halaman 15 menggunakan `application/x-www-form-urlencoded` untuk Flutter. Screenshot Postman pada halaman 5 memperlihatkan pilihan `form-data`. Keduanya dapat digunakan sesuai parsing request PHP/CI4; proyek ini memakai `x-www-form-urlencoded` agar Flutter mengikuti contoh service PDF.
3. **Response CREATE.** Controller PDF menggunakan `respondCreated`, sehingga status sukses adalah HTTP 201. Endpoint GET contoh menggunakan 200. Proyek ini memakai 201 untuk POST, 200 untuk GET/PUT/DELETE.
4. **Update.** Contoh controller PDF memperlihatkan update tetapi tidak menunjukkan pemeriksaan record tidak ditemukan dan validasi lengkap. Implementasi proyek menambahkan pemeriksaan 404 dan validasi dasar agar perilaku API lebih aman dan hasil response konsisten dengan contoh error pada PPT.
5. **CORS.** PDF menyertakan contoh filter khusus dan konfigurasi CORS. Potongan konfigurasi pada modul perlu disesuaikan dengan versi CI4 yang dipakai. Untuk CI4 modern sudah tersedia built-in CORS filter; dokumentasi resmi mengatur konfigurasi di `app/Config/Cors.php` dan pemasangan filter pada routes / `Filters.php`. CORS terutama relevan untuk browser seperti Flutter Web; aplikasi Flutter Android/iOS native bukan browser dan tidak dibatasi kebijakan CORS browser. Lihat `backend/docs/cors-web.md`.
6. **JSON Parsing.** PPT menyebut `fromJson` dan `toJson` untuk model class parsing. PDF memperagakan `fromJson` untuk response API dan memakai Map untuk body POST. Proyek menyediakan `fromJson` dan pemetaan form data pada model agar kebutuhan praktikum tetap sederhana.
7. **Contoh JSONPlaceholder.** PDF halaman 9-10 memperlihatkan fetch sederhana dari endpoint publik `jsonplaceholder.typicode.com/users`. Itu merupakan pengantar HTTP fetching. Integrasi tugas utama tetap menggunakan API UMKM CI4 pada halaman 11-18, bukan JSONPlaceholder.

## Asumsi implementasi yang dijelaskan

- Database menggunakan MySQL/MariaDB lokal dengan nama `db_umkm` sebagai contoh konfigurasi. Sesuaikan kredensial dalam `.env`.
- CodeIgniter 4 appstarter dibuat melalui Composer. Source khusus praktikum berada pada `backend/app`; skrip setup membuat runtime CI4 pada `backend/runtime`.
- Flutter native menjadi target default. Android Emulator menggunakan `10.0.2.2`; perangkat fisik menggunakan IPv4 LAN komputer; iOS Simulator biasanya menggunakan `127.0.0.1`.
- Data awal tidak di-seed otomatis. Tambahkan data melalui form Flutter atau Postman sehingga aplikasi menampilkan record yang benar-benar tersimpan di database.
- PUT dan DELETE disediakan pada backend dan koleksi Postman. Tampilan Flutter tahap awal mengikuti cakupan PDF: daftar dan form tambah.

## Belum dapat disimpulkan dari dokumen

- Versi PHP, CodeIgniter 4, MySQL, Flutter, dan Dart yang diwajibkan dosen.
- Nama database/kredensial lokal mahasiswa.
- Apakah dosen mewajibkan Flutter Web atau hanya Android/iOS.
- Format serta isi identitas mahasiswa untuk sampul laporan.
- Bukti request Postman aktual, hasil run Flutter aktual, dan URL GitHub Public.
