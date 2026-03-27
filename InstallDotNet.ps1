# Install .NET 3.5 for Windows 10 and 11

# Check for admin privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Error: This script requires Administrator privileges!" -ForegroundColor Red
    exit 1
}

$tempDir = "$env:TEMP\DotNet3.5Install\"
$sourceBaseUrl = "https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/"

try {
    # Create temp directory
    New-Item $tempDir -ItemType Directory -Force | Out-Null

    # Get OS info
    $osInfo = Get-ComputerInfo
    $buildNumber = [int]$osInfo.OsBuildNumber

    Write-Host "Detected OS Build: $buildNumber"

    # Map build numbers to folder versions
    $versionFolder = switch ($buildNumber) {
        { $_ -ge 26200 } { "10.0.26200" }
        { $_ -ge 26100 } { "10.0.26100" }
        { $_ -ge 22631 } { "10.0.22631" }
        { $_ -ge 22621 } { "10.0.22621" }
        { $_ -ge 22000 } { "10.0.22000" }
        { $_ -ge 19045 } { "10.0.19045" }
        { $_ -ge 19044 } { "10.0.19044" }
        { $_ -ge 19043 } { "10.0.19043" }
        { $_ -ge 19042 } { "10.0.19042" }
        { $_ -ge 19041 } { "10.0.19041" }
        { $_ -ge 18363 } { "10.0.18363" }
        { $_ -ge 18362 } { "10.0.18362" }
        { $_ -ge 17763 } { "10.0.17763" }
        { $_ -ge 17134 } { "10.0.17134" }
        default { $null }
    }

    if ($null -eq $versionFolder) {
        Write-Host "Error: Unsupported OS build number: $buildNumber" -ForegroundColor Red
        exit 1
    }

    Write-Host "Using version folder: $versionFolder"

    $url = "$sourceBaseUrl$versionFolder/"

    # Check internet connectivity
    try {
        $null = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop
    } catch {
        Write-Host "Error: Unable to reach GitHub repository. Check internet connectivity." -ForegroundColor Red
        exit 1
    }

    if ($buildNumber -ge 22000) {
        Write-Host "Detected Windows 11 (Build $buildNumber)"
        $cabs = @("microsoft-windows-netfx3-ondemand-package~31bf3856ad364e35~amd64~~.cab")
    }
    else {
        Write-Host "Detected Windows 10 (Build $buildNumber)"
        $cabs = @(
            "Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab",
            "Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~~.cab"
        )
    }

    # Download CAB files
    foreach ($cab in $cabs) {
        $fileUrl = "$url$cab"
        $outputPath = "$tempDir\$cab"

        Write-Host "Downloading: $cab" -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri $fileUrl -OutFile $outputPath -UseBasicParsing
            if (Test-Path $outputPath) {
                Write-Host "  ✓ Downloaded successfully" -ForegroundColor Green
            }
            else {
                Write-Host "  ✗ Download failed - file not found" -ForegroundColor Red
                exit 1
            }
        }
        catch {
            Write-Host "  ✗ Download error: $_" -ForegroundColor Red
            exit 1
        }
    }

    # Install .NET 3.5
    Write-Host "Installing .NET Framework 3.5..." -ForegroundColor Cyan
    $dismResult = dism.exe /online /enable-feature /featurename:NetFX3 /All /Source:$tempDir /LimitAccess
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ".NET Framework 3.5 installed successfully!" -ForegroundColor Green
    }
    else {
        Write-Host "DISM installation failed with exit code: $LASTEXITCODE" -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "Error: $($_)" -ForegroundColor Red
    exit 1
}
finally {
    # Cleanup temp directory (always runs, even on error)
    if (Test-Path $tempDir) {
        Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Cleanup complete." -ForegroundColor Green
    }
}