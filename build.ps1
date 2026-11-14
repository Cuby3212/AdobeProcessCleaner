$ErrorActionPreference = 'Stop'
$compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (-not (Test-Path -LiteralPath $compiler)) {
    $compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework\v4.0.30319\csc.exe'
}
& $compiler /nologo /optimize+ /target:exe /platform:anycpu "/out:$PSScriptRoot\AdobeProcessCleaner.exe" "$PSScriptRoot\AdobeProcessCleaner.cs"
if ($LASTEXITCODE -ne 0) { throw 'Error de compilacion.' }
Write-Host 'AdobeProcessCleaner.exe compilado.'
