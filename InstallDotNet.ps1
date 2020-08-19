#This will install .Net 3.5 for the version of windows you are using

$strTemDir = $env:TEMP + "\DotNet3.5Install\"

New-Item $strTemDir -ItemType Directory

$strOSVersion = (get-computerinfo osVersion).osVersion

wget https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/$strOSVersion/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab -OutFile $strTemDir\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab
wget https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/$strOSVersion/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~~.cab -OutFile $strTemDir\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~~.cab 

dism.exe /online /enable-feature /featurename:NetFX3 /All /Source:$strTemDir /LimitAccess

Remove-Item -path $strTemDir -Recurse -Force

