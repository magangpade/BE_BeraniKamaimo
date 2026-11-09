$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$admin = Join-Path $projectRoot '.local\mariadb\mariadb-11.4.13-winx64\bin\mariadb-admin.exe'
$envFile = Join-Path $projectRoot 'be-kamaimo\.env'

if (-not (Test-Path -LiteralPath $admin)) {
  throw 'MariaDB portable belum tersedia di folder .local.'
}
if (-not (Test-Path -LiteralPath $envFile)) {
  throw 'Konfigurasi be-kamaimo\.env belum tersedia.'
}

$passwordLine = Get-Content -LiteralPath $envFile |
  Where-Object { $_ -match '^DB_PASSWORD=' } |
  Select-Object -First 1
$dbPassword = if ($passwordLine) { $passwordLine.Substring(12) } else { '' }

& $admin --protocol=TCP --host=127.0.0.1 --port=3306 --user=root "--password=$dbPassword" --skip-ssl shutdown
if ($LASTEXITCODE -ne 0) {
  throw 'MariaDB lokal gagal dihentikan.'
}

Write-Host 'MariaDB lokal sudah dihentikan.'
