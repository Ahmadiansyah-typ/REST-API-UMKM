# Frontend — Flutter UMKM

Aplikasi mengikuti struktur Modul 10.3: model, service HTTP, controller GetX, view daftar UMKM, dan form tambah UMKM.

## Dependency

Versi yang digunakan sesuai PDF praktikum:

```yaml
http: ^1.5.0
get: ^4.7.2
```

## Membuat platform runner dan memasang dependency

```bash
cd frontend
flutter create --platforms=android,ios,web .
flutter pub get
```

Pastikan `lib/` dan `pubspec.yaml` dalam folder ini tetap menjadi source aplikasi. Perintah `flutter create` digunakan untuk membuat folder platform runner yang mungkin belum tersedia pada paket source.

## Base URL API

`UmkmService` membaca nilai `API_BASE_URL` melalui `--dart-define`.

| Lingkungan | Base URL contoh |
|---|---|
| Android Emulator | `http://10.0.2.2:8080/api` |
| iOS Simulator | `http://127.0.0.1:8080/api` |
| Android fisik | `http://192.168.1.10:8080/api` (ganti dengan IP LAN komputer) |
| Flutter Web | `http://localhost:8080/api` (server perlu konfigurasi CORS) |

Android Emulator:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080/api
```

Perangkat Android fisik:

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8080/api
```

Ganti IP dengan alamat IPv4 komputer yang menjalankan CI4. Pastikan ponsel dan komputer berada pada jaringan yang sama, server CI4 bind ke `0.0.0.0`, dan firewall mengizinkan port 8080.

## HTTP lokal pada Android

Untuk pengembangan lokal dengan HTTP tanpa TLS, periksa `android/app/src/main/AndroidManifest.xml` setelah platform runner dibuat. Tambahkan permission internet di luar elemen `<application>`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

Pada elemen `<application>`, aktifkan cleartext traffic hanya untuk kebutuhan pengembangan lokal:

```xml
android:usesCleartextTraffic="true"
```

Jangan gunakan HTTP cleartext untuk server produksi.

## Fitur aplikasi

- GET data UMKM dari CI4 dan JSON parsing dengan `Umkm.fromJson()`.
- POST data baru menggunakan `application/x-www-form-urlencoded`, sama seperti pola service pada PDF.
- Loading, error, empty state, refresh, dan form validasi.
- Service juga menyediakan method PUT dan DELETE untuk pemanggilan endpoint CRUD.

Jalankan dari folder `frontend` dengan `flutter run` setelah backend aktif.
