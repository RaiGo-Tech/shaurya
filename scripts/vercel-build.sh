#!/usr/bin/env bash
set -euo pipefail

echo "==> Shaurya Vercel build starting..."

# Vercel needs git for flutter tool
git config --global --add safe.directory '*' || true

echo "==> Installing Flutter SDK (stable)..."
FLUTTER_HOME="${HOME}/flutter"
if [ ! -x "$FLUTTER_HOME/bin/flutter" ]; then
  rm -rf "$FLUTTER_HOME"
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_HOME"
fi

export PATH="$FLUTTER_HOME/bin:$PATH"
flutter --version
flutter config --enable-web --no-analytics
flutter precache --web

echo "==> Fetching dependencies..."
flutter pub get

echo "==> Building web release..."
flutter build web --release

if [ ! -f "build/web/index.html" ]; then
  echo "ERROR: build/web/index.html was not created"
  exit 1
fi

echo "==> Build successful:"
ls -la build/web | head -20
