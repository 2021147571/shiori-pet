param(
    [string]$InstallRoot,
    [string]$PackagePath
)
$ErrorActionPreference = 'Stop'
if (-not $InstallRoot) {
    $InstallRoot = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE '.codex' }
}
$baseUrl = 'https://raw.githubusercontent.com/2021147571/shiori-pet/main'
$expected = @{
    'pet.json' = '9eab6e55964421a6d6cbbd5c9ab332d54b05824fbecae15e66add0507f04ef66'
    'spritesheet.webp' = '0b26f4e95696f2c6bd2f3437fe679411296fde9b35d3148d54c3008552dce087'
}
$staging = Join-Path ([IO.Path]::GetTempPath()) ('shiori-pet-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $staging | Out-Null
try {
    foreach ($fileName in $expected.Keys) {
        $filePath = Join-Path $staging $fileName
        if ($PackagePath) {
            Copy-Item -LiteralPath (Join-Path $PackagePath $fileName) -Destination $filePath
        } else {
            Invoke-WebRequest -UseBasicParsing -Uri "$baseUrl/$fileName" -OutFile $filePath
        }
        if ((Get-FileHash -LiteralPath $filePath -Algorithm SHA256).Hash.ToLowerInvariant() -ne $expected[$fileName]) {
            throw "Checksum mismatch: $fileName. No files installed."
        }
    }
    $destination = Join-Path $InstallRoot 'pets/shiori'
    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    foreach ($fileName in $expected.Keys) {
        Copy-Item -LiteralPath (Join-Path $staging $fileName) -Destination (Join-Path $destination $fileName) -Force
    }
    Write-Host "Installed Shiori (水产) to $destination"
    Write-Host 'Open Settings > Pets, refresh, and select 水产.'
} finally {
    foreach ($fileName in $expected.Keys) {
        $temporaryFile = Join-Path $staging $fileName
        if (Test-Path -LiteralPath $temporaryFile) { Remove-Item -LiteralPath $temporaryFile }
    }
    Remove-Item -LiteralPath $staging
}
