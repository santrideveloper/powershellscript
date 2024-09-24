# URL untuk mengunduh Google Chrome installer
$chromeInstallerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"

# Lokasi penyimpanan sementara untuk installer
$installerPath = "$env:TEMP\chrome_installer.exe"

# Fungsi untuk menampilkan progress
function Download-WithProgress {
    param (
        [string]$url,
        [string]$outputPath
    )

    # Menggunakan Invoke-WebRequest dengan -OutFile dan menampilkan progress
    $webRequest = Invoke-WebRequest -Uri $url -OutFile $outputPath -UseBasicP -ProgressVariable progress

    # Menampilkan progress
    while ($progress.Status -ne "Completed") {
        Write-Progress -Status $progress.Status -CurrentOperation $progress.Operation -PercentComplete $progress.PercentComplete
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
