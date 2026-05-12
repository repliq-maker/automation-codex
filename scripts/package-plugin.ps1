$ErrorActionPreference = "Stop"

$pluginRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).ProviderPath
$pluginName = Split-Path $pluginRoot -Leaf
$distDir = Join-Path $pluginRoot "dist"
$zipPath = Join-Path $distDir "$pluginName.zip"

$pluginRootFull = [System.IO.Path]::GetFullPath($pluginRoot)
$distDirFull = [System.IO.Path]::GetFullPath($distDir)
if (-not $distDirFull.StartsWith($pluginRootFull, [System.StringComparison]::OrdinalIgnoreCase)) {
  throw "Refusing to package because dist path is outside the plugin root."
}

if (Test-Path $distDir) {
  Remove-Item -LiteralPath $distDir -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $distDir | Out-Null

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

if (Test-Path $zipPath) {
  Remove-Item -LiteralPath $zipPath -Force
}

$zip = [System.IO.Compression.ZipFile]::Open($zipPath, [System.IO.Compression.ZipArchiveMode]::Create)
try {
  $rootPrefix = $pluginRootFull
  if (-not $rootPrefix.EndsWith([System.IO.Path]::DirectorySeparatorChar)) {
    $rootPrefix = $rootPrefix + [System.IO.Path]::DirectorySeparatorChar
  }

  Get-ChildItem -LiteralPath $pluginRoot -Recurse -Force -File |
    Where-Object {
      -not $_.FullName.StartsWith($distDirFull, [System.StringComparison]::OrdinalIgnoreCase)
    } |
    ForEach-Object {
      $relativePath = $_.FullName.Substring($rootPrefix.Length)
      $entryPath = "$pluginName/$($relativePath -replace "\\", "/")"
      [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $_.FullName, $entryPath) | Out-Null
    }
}
finally {
  $zip.Dispose()
}

Write-Output "Created $zipPath"
