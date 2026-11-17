# CORS (opsional untuk Flutter Web)

Modul 10.2 membahas CORS dan memberi contoh filter. Untuk Flutter Android/iOS native, CORS browser tidak menjadi penghalang request aplikasi native. Konfigurasi CORS diperlukan saat API diakses dari browser, misalnya Flutter Web.

Pada CodeIgniter 4 modern, gunakan built-in `cors` filter, bukan menyalin potongan filter manual dari PDF tanpa penyesuaian versi. Atur origin spesifik yang menjalankan Flutter Web pada `app/Config/Cors.php`:

```php
public array $default = [
    'allowedOrigins'         => ['http://localhost:5000'],
    'allowedOriginsPatterns' => [],
    'supportsCredentials'    => false,
    'allowedHeaders'         => ['Content-Type', 'Accept'],
    'exposedHeaders'         => [],
    'allowedMethods'         => ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    'maxAge'                 => 7200,
];
```

Ganti `http://localhost:5000` sesuai origin Flutter Web yang benar. Hindari `*` pada aplikasi yang dipublikasikan.

Kemudian pasang filter pada group API dan daftarkan route OPTIONS agar request preflight memiliki route:

```php
$routes->group('api', ['filter' => 'cors'], static function ($routes): void {
    $routes->get('umkm', '\\App\\Controllers\\Api\\UmkmController::index');
    $routes->post('umkm', '\\App\\Controllers\\Api\\UmkmController::create');
    $routes->put('umkm/(:num)', '\\App\\Controllers\\Api\\UmkmController::update/$1');
    $routes->delete('umkm/(:num)', '\\App\\Controllers\\Api\\UmkmController::delete/$1');
    $routes->options('umkm', static function () {});
    $routes->options('umkm/(:num)', static function () {});
});
```

Pastikan versi kerangka CI4 yang dibuat oleh Composer menyediakan filter `cors`. Dokumentasi resmi CodeIgniter menjelaskan lokasi konfigurasi, pemasangan filter, dan route OPTIONS.
