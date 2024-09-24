# Menentukan URL dari installer Notepad++ (ganti '8.4.6' dengan versi terbaru)
$notepadPlusPlusUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7/npp.8.7.Installer.x64.exe"

# Menentukan lokasi untuk menyimpan installer
$installerPath = "$env:TEMP\npp_installer.exe"

# Mengunduh installer
Write-Host "Mengunduh Notepad++ dari $notepadPlusPlusUrl..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $notepadPlusPlusUrl -OutFile $installerPath -ErrorAction Stop

# Memeriksa apakah unduhan berhasil
if (Test-Path $installerPath) {
    Write-Host "Unduhan selesai. Memulai instalasi..." -ForegroundColor Green

    # Menjalankan installer
    Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

    Write-Host "Instalasi selesai." -ForegroundColor Green

    # Menghapus installer setelah instalasi
    Remove-Item $installerPath -Force
    Write-Host "File installer telah dihapus." -ForegroundColor Yellow
} else {
    Write-Host "Unduhan gagal. Silakan coba lagi." -ForegroundColor Red
}
