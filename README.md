# PowerShell "Visual Studio Developer Command Prompt"
This function will enter the "Visual Studio Developer Command Prompt" mode for the Visual Studio version matching the $DisplayNameMatch. 

### NOTES
- Depends upon VSWHERE.exe. Requires that at the very least Visual Studio 2017 is installed or greater. Can be used to enter the developer powershell for lower versions as long as VSWHERE.EXE is found. [About vshere.exe](https://docs.microsoft.com/en-us/visualstudio/install/tools-for-managing-visual-studio-instances?using-vswhereexe)
- If run multiple times, a warning will be written out. This warning can be ignored.
- If multiple instances are found matching, then the latest version will be used.

### Examples: 

Gets the latest Visual Studio Installed and enters the developer mode for that version
```powershell
PS> Import-Module EnterDeveloperPowerShell
PS> Enter-VisualStudioDeveloperShell # This is the same as passing in latest
```

Gets the latest Visual Studio version installed, and enters the developer command prompt for that version
```powershell
PS> Import-Module EnterDeveloperPowerShell
PS> Enter-VisualStudioDeveloperShell -DisplayNameMatch "latest"
```

Gets the Visual Studio 2015 **if** Installed and enters the developer mode for that version. If not installed, an exception will be thrown
```powershell
PS> Import-Module EnterDeveloperPowerShell
PS> Enter-VisualStudioDeveloperShell -DisplayNameMatch "2015"
```

Shows an example getting the path using just version
```powershell
PS> Import-Module EnterDeveloperPowerShell
PS> Enter-VisualStudioDeveloperShell -DisplayNameMatch "2019"
```

Shows an example that could return multiple instaled versions, when this happens the newest version is selected.
```powershell
PS> Import-Module EnterDeveloperPowerShell
PS> Enter-VisualStudioDeveloperShell -DisplayNameMatch "2015|2017|2019"
```

### Possible Exceptions
- VSWHERE.exe is not found
- No instances are found for the $DisplayNameMatch supplied
- VsDevCmd.bat could not be found in the install
- The invocation of VsDevCmd.bat fails

[PowerShell Gallery Module](https://www.powershellgallery.com/packages/EnterDeveloperPowerShell/)

[Start Developer Command Prompt](https://github.com/Microsoft/vswhere/wiki/Start-Developer-Command-Prompt)

