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

    # Menggunakan Invoke-WebRequest dengan -OutFile untuk mengunduh file
    $webRequest = Invoke-WebRequest -Uri $url -OutFile $outputPath -UseBasicP

    # Jika file berhasil diunduh, tampilkan progress
    if ($webRequest.StatusCode -eq 200) {
        $fileInfo = Get-Item $outputPath
        $fileSize = $fileInfo.Length
        $bytesReceived = 0

        # Menampilkan progress
        while ($bytesReceived -lt $fileSize) {
            $bytesReceived = (Get-Item $outputPath).Length
            $percentComplete = [math]::Round(($bytesReceived / $fileSize) * 100)
            Write-Progress -Status "Downloading..." -CurrentOperation "Downloading $($fileInfo.Name)" -PercentComplete $percentComplete
            Start-Sleep -Milliseconds 100
        }
    }
}

# Mengunduh installer Google Chrome dengan progress
Download-WithProgress -url $chromeInstallerUrl -outputPath $installerPath

# Menjalankan installer secara diam-diam (silent install)
Start-Process -FilePath $installerPath -Args "/silent /install" -Wait

# Menghapus installer setelah instalasi selesai
Remove-Item $installerPath

Write-Host "Google Chrome telah berhasil diinstal."
