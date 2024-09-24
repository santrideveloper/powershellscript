# Definisikan variabel untuk URL download Chrome
$url = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BD7A8B8B8-9A86-4DDE-8FCA-4614A8A28B25%7D%26lang%3Den%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26brand%3DGCEB%26dmg%3D1%26ap%3Dx64-stable-statsdef_1%26brand%3DGCEB/dmg/GCEB%2FGoogleChromeEnterpriseBundle%2F102.0.5005.63%2FGoogleChromeEnterpriseBundle64.zip"

# Definisikan direktori untuk menyimpan file download
$downloadDir = "$env:USERPROFILE\Downloads"

# Buat direktori download jika belum ada
if (!(Test-Path -Path $downloadDir)) {
    New-Item -ItemType Directory -Path $downloadDir
}

# Download file installer Chrome
$fileName = "GoogleChromeEnterpriseBundle64.zip"
$filePath = Join-Path -Path $downloadDir -ChildPath $fileName
Invoke-WebRequest -Uri $url -OutFile $filePath

# Ekstrak file installer Chrome
$extractDir = Join-Path -Path $downloadDir -ChildPath "Chrome"
if (!(Test-Path -Path $extractDir)) {
    New-Item -ItemType Directory -Path $extractDir
}
Expand-Archive -Path $filePath -DestinationPath $extractDir -Force

# Jalankan file installer Chrome
$installerPath = Join-Path -Path $extractDir -ChildPath "GoogleChromeEnterpriseBundle64\Setup.exe"
Start-Process -FilePath $installerPath -ArgumentList "/silent /install"
