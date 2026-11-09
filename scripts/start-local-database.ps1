$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$mariaRoot = Join-Path $projectRoot '.local\mariadb\mariadb-11.4.13-winx64'
$dataDirectory = Join-Path $projectRoot '.local\mariadb\data'
$server = Join-Path $mariaRoot 'bin\mariadbd.exe'
$admin = Join-Path $mariaRoot 'bin\mariadb-admin.exe'
$config = Join-Path $dataDirectory 'my.ini'
$envFile = Join-Path $projectRoot 'be-kamaimo\.env'

if (-not (Test-Path -LiteralPath $server)) {
  throw 'MariaDB portable belum tersedia di folder .local.'
}
if (-not (Test-Path -LiteralPath $envFile)) {
  throw 'Konfigurasi be-kamaimo\.env belum tersedia.'
}

$passwordLine = Get-Content -LiteralPath $envFile |
  Where-Object { $_ -match '^DB_PASSWORD=' } |
  Select-Object -First 1
$dbPassword = if ($passwordLine) { $passwordLine.Substring(12) } else { '' }
$adminArguments = @(
  '--protocol=TCP'
  '--host=127.0.0.1'
  '--port=3306'
  '--user=root'
  "--password=$dbPassword"
  '--skip-ssl'
  'ping'
)

& $admin @adminArguments 2>$null
if ($LASTEXITCODE -eq 0) {
  Write-Host 'MariaDB lokal sudah aktif di 127.0.0.1:3306.'
  exit 0
}

$arguments = @(
  "--defaults-file=$config"
  '--bind-address=127.0.0.1'
  '--console'
)
Start-Process -FilePath $server -ArgumentList $arguments -WindowStyle Hidden | Out-Null

for ($attempt = 0; $attempt -lt 20; $attempt++) {
  Start-Sleep -Milliseconds 500
  & $admin @adminArguments 2>$null
  if ($LASTEXITCODE -eq 0) {
    Write-Host 'MariaDB lokal aktif di 127.0.0.1:3306.'
    exit 0
  }
}

throw 'MariaDB lokal gagal aktif. Periksa log pada .local\mariadb\data.'
