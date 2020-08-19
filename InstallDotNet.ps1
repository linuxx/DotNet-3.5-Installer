#This will install .Net 3.5 for the version of windows you are using

$strTemDir = $env:TEMP + "\DotNet3.5Install"

New-Item $strTemDir 

$strOSVersion = (get-computerinfo osVersion).osVersion

wget https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/$strOSVersion/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab -OutFile $strTemDir\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab


Write-output https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/$strOSVersion/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab