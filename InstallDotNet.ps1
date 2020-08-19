#This will install .Net 3.5 for Windows 10

#Specify a temporary location 
$strTemDir = $env:TEMP + "\DotNet3.5Install\"

#create a directory in that location to hold our files
New-Item $strTemDir -ItemType Directory

#Detect OS version
$strOSVersion = (get-computerinfo osVersion).osVersion

#Download both files
wget https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/$strOSVersion/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab -OutFile $strTemDir\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~en-US~.cab
wget https://github.com/linuxx/DotNet-3.5-Installer/raw/master/Versions/$strOSVersion/Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~~.cab -OutFile $strTemDir\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~~.cab 

#Install the feature 
dism.exe /online /enable-feature /featurename:NetFX3 /All /Source:$strTemDir /LimitAccess

#Clean up!
Remove-Item -path $strTemDir -Recurse -Force