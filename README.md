# EnterDeveloperPowerShell Description
This function will enter the Visual Studio Developer Powershell mode, and will return the installation path of the version selected using the $DisplayNameMatch. Allows any powershell instance to enter "Visual Studio Developer Mode".

### NOTES
Depends upon VSWHERE.exe. Requires that at the very least Visual Studio 2017 is installed or greater. Can be used to enter the developer powershell for lower versions as long as VSWHERE.EXE is found. [About vshere.exe](https://docs.microsoft.com/en-us/visualstudio/install/tools-for-managing-visual-studio-instances?using-vswhereexe)

### Examples: 

Gets the latest Visual Studio Installed and enters the developer mode for that version
```powershell
PS> Import-Module EnterDeveloperPowerShell
PS> $installPath = Invoke-VSDeveloperPowershell -DisplayNameMatch "latest"
PS> Write-Host "installPath = $installPath"
```

Gets the Visual Studio 2017 IF Installed and enters the developer mode for that version. IF not installed, an exception will be thrown
```powershell
PS> Import-Module EnterDeveloperPowerShell
PS> $installPath = Invoke-VSDeveloperPowershell -DisplayNameMatch "latest"
PS> Write-Host "installPath = $installPath"
```

Shows an example getting the path using regex
```powershell
PS> Import-Module EnterDeveloperPowerShell
PS> $installPath = Invoke-VSDeveloperPowershell -DisplayNameMatch "Visual.*2019"
PS> Write-Host "installPath = $installPath"
```

### Possible Exceptions
- VSWHERE.exe is not found
- No instances are found for the $DisplayNameMatch supplied
- Multiple instances are found for the $DisplayNameMatch supplied
- VsDevCmd.bat could not be found in the install
- The invocation of VsDevCmd.bat fails

[PowerShell Gallery Module](https://www.powershellgallery.com/packages/EnterDeveloperPowerShell/)

