# Backend source — CodeIgniter 4

Folder `app/` pada direktori ini adalah source aplikasi untuk ditempatkan pada kerangka CodeIgniter 4.

## Setup otomatis

- Windows: jalankan `..\backend\setup.ps1` dari root repository.
- macOS/Linux: jalankan `bash backend/setup.sh` dari root repository.

Skrip membuat `backend/runtime` menggunakan `composer create-project codeigniter4/appstarter`, lalu menyalin source `backend/app` ke folder `backend/runtime/app`. Folder runtime tidak dimasukkan ke Git.

## Konfigurasi

1. Buat database MySQL bernama `db_umkm`.
2. Edit `backend/runtime/.env` untuk hostname, nama database, username, dan password.
3. Jalankan:

```bash
cd backend/runtime
php spark migrate
php spark routes
php spark serve --host 0.0.0.0 --port 8080
```

## Struktur tabel

Tabel `umkm` menggunakan kolom `id`, `nama_umkm`, `pemilik`, `alamat`, `kategori`, `kontak`, `created_at`, dan `updated_at`. Atribut dan batas panjang mengikuti contoh migration pada Modul 10.1.

## Catatan sumber materi

PDF praktikum menuliskan perintah `php spark make:mode UmkmModel`; itu tampak sebagai salah ketik. Perintah generator model CI4 adalah `php spark make:model UmkmModel`. File model sudah disediakan sehingga generator tidak perlu dijalankan lagi.
