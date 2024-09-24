Set-Alias chromeInstall "iex (irm 'https://raw.githubusercontent.com/johndoe/my-scripts/main/install-chrome-script.ps1')"
# URL untuk mengunduh Google Chrome installer
$chromeInstallerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"

# Lokasi penyimpanan sementara untuk installer
$installerPath = "$env:TEMP\chrome_installer.exe"

# Mengunduh installer Google Chrome
Invoke-WebRequest -Uri $chromeInstallerUrl -OutFile $installerPath

# Menjalankan installer secara diam-diam (silent install)
Start-Process -FilePath $installerPath -Args "/silent /install" -Wait

# Menghapus installer setelah instalasi selesai
Remove-Item $installerPath

Write-Host "Google Chrome telah berhasil diinstal."
