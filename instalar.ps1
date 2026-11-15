# Instala o Flameshot (se precisar) e aplica a config deste repositorio.
# Uso: clique direito > "Executar com o PowerShell"
#   ou: powershell -ExecutionPolicy Bypass -File instalar.ps1

$ErrorActionPreference = 'Stop'
$exe = 'C:\Program Files\Flameshot\bin\flameshot.exe'

if (-not (Test-Path $exe)) {
    Write-Host 'Flameshot nao encontrado, instalando pelo winget...'
    winget install --id Flameshot.Flameshot -e --accept-source-agreements --accept-package-agreements
}

# Pasta onde as prints serao salvas: Imagens\prints
$prints = Join-Path ([Environment]::GetFolderPath('MyPictures')) 'prints'
New-Item -ItemType Directory -Force $prints | Out-Null

# Fecha o Flameshot para ele nao sobrescrever a config
Get-Process flameshot -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Milliseconds 500

# Copia a config trocando o caminho da pasta de prints
$cfgDir = Join-Path $env:APPDATA 'flameshot'
New-Item -ItemType Directory -Force $cfgDir | Out-Null
$cfg = Join-Path $cfgDir 'flameshot.ini'
if (Test-Path $cfg) { Copy-Item $cfg "$cfg.bak" -Force }

$modelo = [IO.File]::ReadAllText((Join-Path $PSScriptRoot 'flameshot.ini'))
$texto = $modelo.Replace('__SAVEPATH__', ($prints -replace '\\', '/'))
[IO.File]::WriteAllText($cfg, $texto, (New-Object Text.UTF8Encoding $false))

if (Test-Path $exe) { Start-Process $exe }
Write-Host "Pronto! Prints serao salvas em: $prints"
Write-Host 'Atalho: Win+Shift+S  |  Ctrl+S salva e copia o caminho do arquivo'
