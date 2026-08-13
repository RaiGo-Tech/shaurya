# Build Flutter web for production deploy (Netlify / Vercel)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

foreach ($p in @(
    "$root\ios\Flutter\ephemeral",
    "$root\macos\Flutter\ephemeral",
    "$root\windows\Flutter\ephemeral"
)) {
    if (Test-Path $p) {
        attrib -R $p /S /D 2>$null
        Remove-Item -LiteralPath $p -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Set-Location $root
flutter pub get
flutter build web --release
Write-Host "`nBuilt: $root\build\web" -ForegroundColor Green
Write-Host "Deploy with: npx netlify-cli deploy --prod --dir=build/web" -ForegroundColor Cyan
