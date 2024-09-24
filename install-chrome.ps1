# URL untuk mengunduh Google Chrome installer
$chromeInstallerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"

# Lokasi penyimpanan sementara untuk installer
$installerPath = "$env:TEMP\chrome_installer.exe"

# Fungsi untuk menampilkan progress saat mengunduh
function Download-WithProgress {
    param (
        [string]$url,
        [string]$outputPath
    )

    # Membuat web client untuk mengunduh file
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadProgressChanged += {
        # Menampilkan progress setiap kali ada perubahan
        Write-Progress -Status "Downloading..." -CurrentOperation "$($_.UserState)" -PercentComplete $_.ProgressPercentage
    }

    # Mengunduh file
    $webClient.DownloadFileAsync($url, $outputPath, "Downloading Chrome Installer")
    
    # Menunggu hingga pengunduhan selesai
    while ($webClient.IsBusy) {
        Start-Sleep -Milliseconds 100
    }
}

# Mengunduh installer Google Chrome dengan progress
Download-WithProgress -url $chromeInstallerUrl -outputPath $installerPath

# Menjalankan installer secara diam-diam (silent install)
Start-Process -FilePath $installerPath -Args "/silent /install" -Wait

# Menghapus installer setelah instalasi selesai
Remove-Item $installerPath

Write-Host "Google Chrome telah berhasil diinstal."
