$ErrorActionPreference = 'Stop'
$BackendRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$BaseDir = Join-Path $BackendRoot '.appstarter-temp'
$RuntimeDir = Join-Path $BackendRoot 'runtime'

if (Test-Path $RuntimeDir) {
    throw "Folder runtime sudah ada: $RuntimeDir. Hapus atau pindahkan folder tersebut sebelum menjalankan setup ulang."
}

composer create-project codeigniter4/appstarter $BaseDir
New-Item -ItemType Directory -Path $RuntimeDir | Out-Null

# Salin kerangka CI4, lalu timpa app/ dengan implementasi praktikum.
Get-ChildItem -Force -Path $BaseDir | Where-Object { $_.Name -ne 'app' } | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $RuntimeDir -Recurse -Force
}
Copy-Item -Path (Join-Path $BaseDir 'app') -Destination $RuntimeDir -Recurse -Force
Copy-Item -Path (Join-Path $BackendRoot 'app\*') -Destination (Join-Path $RuntimeDir 'app') -Recurse -Force
Copy-Item -Path (Join-Path $BackendRoot '.env.example') -Destination (Join-Path $RuntimeDir '.env') -Force

Write-Host "Backend CI4 siap di $RuntimeDir"
Write-Host "Edit file .env, lalu jalankan: cd backend\runtime; php spark migrate; php spark serve --host 0.0.0.0 --port 8080"
