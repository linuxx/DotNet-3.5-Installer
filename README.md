In an elevated powershell prompt, run the following commands:

* cd \\
* wget https://raw.githubusercontent.com/linuxx/DotNet-3.5-Installer/master/InstallDotNet.ps1 -OutFile InstallDotNet.ps1
* .\InstallDotNet.ps1



Look to see the version of .net installed
* reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP"
