param([switch]$Offline)
$ErrorActionPreference = 'Stop'
$toolRoot = Join-Path (Split-Path $PSScriptRoot -Parent) '.tools'
$jdk = Get-ChildItem -LiteralPath $toolRoot -Directory -Filter 'jdk-17*' | Select-Object -First 1
$maven = Join-Path $toolRoot 'apache-maven-3.9.9\bin\mvn.cmd'
if (-not $jdk -or -not (Test-Path -LiteralPath $maven)) {
    throw 'Portable JDK/Maven not found. Install JDK 17 and Maven, then run mvn clean test.'
}
$env:JAVA_HOME = $jdk.FullName
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
$env:MAVEN_OPTS = "-Dmaven.repo.local=`"$(Join-Path $toolRoot 'm2')`" -Dstyle.color=never"
Push-Location $PSScriptRoot
try {
    if ($Offline) { & $maven -o clean test } else { & $maven clean test }
    $buildExitCode = $LASTEXITCODE
} finally {
    Pop-Location
}
exit $buildExitCode
