# Rencana Pengujian REST API UMKM

**Status saat dokumen dibuat: BELUM DIUJI.** Tabel di bawah adalah test plan dan expected result, bukan laporan hasil aktual.

## Konfigurasi Postman

- Collection: `postman/UMKM-CRUD.postman_collection.json`
- Variable `baseUrl`: `http://localhost:8080/api`
- Variable `umkmId`: diisi otomatis dari response POST.
- Header umum: `Accept: application/json`.
- POST/PUT pada collection menggunakan `application/x-www-form-urlencoded`.

## Test case

| No. | Endpoint | Method | Skenario | Hasil yang diharapkan |
|---:|---|---|---|---|
| 1 | `/api/umkm` | GET | Mengambil seluruh data | HTTP 200; `success: true`; `data` berupa array |
| 2 | `/api/umkm` | POST | Menambahkan data valid | HTTP 201; `success: true`; `data` berisi record baru dan ID |
| 3 | `/api/umkm` | POST | Mengirim `nama_umkm` kosong | HTTP 400; `success: false`; `errors.nama_umkm` tersedia |
| 4 | `/api/umkm/{id}` | PUT | Memperbarui data dengan ID yang ada | HTTP 200; `success: true`; `data` berisi record terbaru |
| 5 | `/api/umkm/{id}` | PUT | Memperbarui ID yang tidak ada | HTTP 404; `success: false` |
| 6 | `/api/umkm/{id}` | DELETE | Menghapus record yang ada | HTTP 200; `success: true`; `data` berisi ID dan nama UMKM |
| 7 | `/api/umkm/{id}` | DELETE | Menghapus ID yang tidak ada | HTTP 404; `success: false` |

## Langkah pengujian

1. Jalankan MySQL/MariaDB dan buat database `db_umkm`.
2. Pastikan `.env` di runtime CI4 mengarah ke database tersebut.
3. Jalankan `php spark migrate` dan `php spark serve --host 0.0.0.0 --port 8080` dari `backend/runtime`.
4. Import koleksi Postman.
5. Jalankan request GET terlebih dahulu. Jika data kosong, response tetap diharapkan HTTP 200 dengan `data: []`.
6. Jalankan POST dengan nama UMKM minimal 3 karakter. Collection menyimpan ID yang diterima ke variable `umkmId`.
7. Jalankan PUT untuk ID hasil POST, lalu jalankan GET untuk memastikan perubahan.
8. Jalankan DELETE untuk ID tersebut, lalu jalankan GET untuk memastikan record sudah tidak ada.
9. Jalankan test POST invalid dan PUT/DELETE dengan ID tidak tersedia untuk memeriksa error handling.

## Bukti screenshot yang harus diambil sendiri

Ambil screenshot langsung setelah menjalankan request di Postman. Setiap bukti harus menampakkan method, URL, body jika ada, status code, dan response JSON.

1. GET sukses — tampakkan method GET, URL `/api/umkm`, status 200, dan response.
2. POST sukses — tampakkan body form-urlencoded, status 201, dan response yang mengandung ID baru.
3. POST validasi gagal — tampakkan body tanpa `nama_umkm` yang valid, status 400, dan response `errors`.
4. PUT sukses — tampakkan URL dengan ID, body perubahan, status 200, dan data terbaru.
5. DELETE sukses — tampakkan URL dengan ID, status 200, dan data record yang dihapus.
6. DELETE/PUT ID tidak ditemukan — tampakkan status 404 dan response JSON error.

Simpan bukti di `docs/screenshots/` atau lokasi yang disepakati dosen. Jangan memasukkan gambar contoh dari modul sebagai bukti pengujian proyek Anda. Setelah bukti diambil, catat waktu, hasil aktual, dan nama file screenshot.

## Kriteria integrasi Flutter

- Jalankan backend sebelum aplikasi Flutter.
- Jalankan aplikasi dengan base URL sesuai lingkungan perangkat.
- Pastikan daftar UMKM berasal dari response GET CI4.
- Tambahkan satu data dari form Flutter; verifikasi response POST dan pastikan daftar diperbarui dari GET.
- Uji kondisi server mati untuk memastikan tampilan error state muncul.
- Uji database tanpa record untuk memastikan empty state muncul.

## Hasil aktual

Belum ada hasil aktual yang dicatat. Isi kolom status dan lampirkan screenshot hanya setelah tiap skenario benar-benar dijalankan.
