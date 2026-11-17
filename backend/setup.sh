#!/usr/bin/env bash
set -euo pipefail
BACKEND_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$BACKEND_ROOT/.appstarter-temp"
RUNTIME_DIR="$BACKEND_ROOT/runtime"

if [[ -e "$RUNTIME_DIR" ]]; then
  echo "Folder runtime sudah ada: $RUNTIME_DIR. Hapus atau pindahkan sebelum setup ulang." >&2
  exit 1
fi

composer create-project codeigniter4/appstarter "$BASE_DIR"
mkdir -p "$RUNTIME_DIR"
find "$BASE_DIR" -mindepth 1 -maxdepth 1 ! -name app -exec cp -R {} "$RUNTIME_DIR/" \;
cp -R "$BASE_DIR/app" "$RUNTIME_DIR/app"
cp -R "$BACKEND_ROOT/app/." "$RUNTIME_DIR/app/"
cp "$BACKEND_ROOT/.env.example" "$RUNTIME_DIR/.env"

echo "Backend CI4 siap di: $RUNTIME_DIR"
echo "Edit .env lalu jalankan: cd '$RUNTIME_DIR' && php spark migrate && php spark serve --host 0.0.0.0 --port 8080"
