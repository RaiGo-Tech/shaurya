#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing Flutter SDK (stable)..."
FLUTTER_HOME="${HOME}/flutter"
if [ ! -d "$FLUTTER_HOME/.git" ]; then
  rm -rf "$FLUTTER_HOME"
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_HOME"
fi

export PATH="$FLUTTER_HOME/bin:$PATH"
flutter --version
flutter config --enable-web --no-analytics

echo "==> Fetching Dart/Flutter dependencies..."
flutter pub get

echo "==> Building Flutter web (release)..."
flutter build web --release

echo "==> Web build output:"
ls -la build/web
