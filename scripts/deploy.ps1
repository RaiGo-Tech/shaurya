# Shaurya — one-command deploy helpers (run from project root)

param(
    [ValidateSet("netlify", "vercel", "build")]
    [string]$Target = "build"
)

$root = $PSScriptRoot | Split-Path -Parent
Set-Location $root

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

Write-Host "Building Flutter web..." -ForegroundColor Cyan
flutter pub get
flutter build web --release
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Build ready: build/web" -ForegroundColor Green

switch ($Target) {
    "build" {
        Write-Host "`nNext steps:" -ForegroundColor Yellow
        Write-Host "  Netlify: npx netlify-cli login"
        Write-Host "           npx netlify-cli deploy --prod --dir=build/web"
        Write-Host "  Vercel:  npx vercel login"
        Write-Host "           npx vercel deploy build/web --prod"
    }
    "netlify" {
        npx netlify-cli deploy --prod --dir=build/web
    }
    "vercel" {
        npx vercel deploy build/web --prod
    }
}
