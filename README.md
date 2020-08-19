# .Net 3.5 installer for Windows 10
This script will install .net 3.5 on Windows 10. Works on the following Windows 10 versions:

OS Build | Version | Supported
------------- | ------------- | ------------- 
Windows 10.0.17134  | 1803 | :heavy_check_mark:
Windows 10.0.17763  | 1809 | :heavy_check_mark:
Windows 10.0.18362  | 1903 | :heavy_check_mark:
Windows 10.0.18363 | 1909 | :heavy_check_mark:
Windows 10.0.19041 | 2004 | :heavy_check_mark:


In an elevated powershell prompt, run the following commands:

* cd \\
* wget https://raw.githubusercontent.com/linuxx/DotNet-3.5-Installer/master/InstallDotNet.ps1 -OutFile InstallDotNet.ps1
* .\InstallDotNet.ps1



Look to see the version of .net installed
* reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP"

Make sure you have unrestricted ExecutionPolicy enabled
* Set-ExecutionPolicy Unrestricted


## FAQ
Q: Will it work on Windows (not 10) 
A: No

Q: Will it work on Server
A: Dont know

Q: It says that the script isn't signed
A: Set your execution policy

Q: My Windows 10 version is older, and not listed, will it work?
A: No, upgrade 
