# Install .NET 3.5 for Windows 10 and 11

$strTemDir = "$env:TEMP\DotNet3.5Install\"
New-Item $strTemDir -ItemType Directory -Force | Out-Null

# Get OS info
$osInfo = Get-ComputerInfo
$build = [int]$osInfo.OsBuildNumber

if ($build -ge 22000) {
    Write-Host "Detected Windows 11 (Build $build)"

    # Windows 11 - single CAB
    $cab = "microsoft-windows-netfx3-ondemand-package~31bf3856ad364e35~amd64~~.cab"
    $url = "https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/$($osInfo.OsVersion)/$cab"

    Invoke-WebRequest $url -OutFile "$strTemDir\$cab"

}
elseif ($build -lt 22000) {
    Write-Host "Detected Windows 10 (Build $build)"

    # Windows 10 - two CABs
    $cab1 = "Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab"
    $cab2 = "Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~~.cab"

    $baseUrl = "https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/$($osInfo.OsVersion)/"

    Invoke-WebRequest "$baseUrl$cab1" -OutFile "$strTemDir\$cab1"
    Invoke-WebRequest "$baseUrl$cab2" -OutFile "$strTemDir\$cab2"
}
else {
    Write-Host "Unable to determine OS version" -ForegroundColor Red
    exit 1
}

# Install .NET 3.5
dism.exe /online /enable-feature /featurename:NetFX3 /All /Source:$strTemDir /LimitAccess

# Cleanup
Remove-Item -Path $strTemDir -Recurse -Force