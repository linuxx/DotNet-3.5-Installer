# .Net 3.5 installer for Windows 10 & Windows 11
This script will install .net 3.5 on Windows 10 and Windows 11. Works on the following versions:

## Windows 10
OS Build | Version | Supported
------------- | ------------- | ------------- 
Windows 10.0.17134  | 1803 | :heavy_check_mark:
Windows 10.0.17763  | 1809 | :heavy_check_mark:
Windows 10.0.18362  | 1903 | :heavy_check_mark:
Windows 10.0.18363 | 1909 | :heavy_check_mark:
Windows 10.0.19041 | 2004 | :heavy_check_mark:
Windows 10.0.19042 | 20H2 | :heavy_check_mark:
Windows 10.0.19043 | 21H1 | :heavy_check_mark:
Windows 10.0.19044 | 21H2 | :heavy_check_mark:

## Windows 11
OS Build | Version | Supported
------------- | ------------- | ------------- 
Windows 11.0.22000  | 21H2 | :heavy_check_mark:
Windows 11.0.22621  | 22H2 | :heavy_check_mark:
Windows 11.0.22631 | 23H2 | :heavy_check_mark:
Windows 11.0.26100 | 24H2 | :heavy_check_mark:
Windows 11.0.26200 | 25H1 | :heavy_check_mark:


In an elevated powershell prompt, run the following commands:

* cd \\
* wget https://raw.githubusercontent.com/linuxx/DotNet-3.5-Installer/master/InstallDotNet.ps1 -OutFile InstallDotNet.ps1
* .\InstallDotNet.ps1



Look to see the version of .net installed
* reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP"

Make sure you have unrestricted ExecutionPolicy enabled
* Set-ExecutionPolicy Unrestricted


## FAQ
    Q: Will it work on Windows (not 10 or 11)? 
    A: No
    
    Q: Will it work on Server
    A: Sometimes
    
    Q: It says that the script isn't signed
    A: Set your execution policy
    
    Q: My Windows version is older and not listed, will it work?
    A: No, upgrade 
