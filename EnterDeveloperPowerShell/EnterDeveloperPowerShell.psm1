<#
.SYNOPSIS
This function will enter the Visual Studio Developer Powershell mode of the version selected using the $DisplayNameMatch

.PARAMETER DisplayNameMatch
A regex that will be matched against the DisplayName of the instance. You can also send in "latest" to just get the latest version. Default: "latest"

.NOTES
Depends upon VSWHERE.exe. Requires that at the very least Visual Studio 2017 is installed or greater. Can be used to enter the developer powershell for
lower versions as long as VSWHERE.EXE is found.

.EXAMPLE
PS> Invoke-VSDeveloperPowershell -DisplayNameMatch "latest"

.EXAMPLE
PS> Invoke-VSDeveloperPowershell # This is the same as passing in latest

.EXAMPLE
PS> Invoke-VSDeveloperPowershell -DisplayNameMatch "2017"

.EXAMPLE
PS> Invoke-VSDeveloperPowershell -DisplayNameMatch "2019" -Verbose

.EXAMPLE
PS> Invoke-VSDeveloperPowershell -DisplayNameMatch "Visual.*2019"

.LINK About vshwere: https://docs.microsoft.com/en-us/visualstudio/install/tools-for-managing-visual-studio-instances?using-vswhereexe

.LINK References: https://github.com/Microsoft/vswhere/wiki/Start-Developer-Command-Prompt
#>
function Invoke-VSDeveloperPowershell {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]
        $DisplayNameMatch = "latest"
    )

    process {
        Write-Verbose "Scanning for Visual Studio using: $DisplayNameMatch"

        $vsWhere = "$(${env:ProgramFiles(x86)})\Microsoft Visual Studio\Installer\vswhere.exe"

        if (!(Test-Path $vsWhere)) {
            throw "VSWHERE.EXE not found at $vsWhere. This module requires at leat Visual Studio 2017 or greater is installed as it depends upon VSWHERE.EXE"
            exit -1
        }

        if ($DisplayNameMatch -ieq "latest") {
            $instance = (. $vsWhere -latest -format json | ConvertFrom-Json) | Select-Object -First 1
        } else {
            # if there are multiples returned, try to sort them with the newest at the top and select it
            $instance = (. $vsWhere -format json | ConvertFrom-Json) `
                | Where-Object { $_.displayName -imatch $DisplayNameMatch } `
                | Sort-Object -Descending -Property installationVersion `
                | Select-Object -First 1
        }

        if (!($instance)) {
            throw "An instance of Visual Studio could not be found using: $DisplayNameMatch"
            exit -2
        } 

        $vsDevCmdPath = [System.IO.Path]::Combine($instance.installationPath, "Common7\Tools\VsDevCmd.bat")

        if (!(Test-Path $vsDevCmdPath)) {
            throw "Could not locate VsDevCmd.bat at: $vsDevCmdPath"
            exit -4
        }

        Write-Verbose "Found VsDevCmd.bat at $vsDevCmdPath"

        if ([string]::IsNullOrWhiteSpace($env:VSCMD_VER)) {
            & "$env:comspec" /s /c "`"$($instance.installationPath)\Common7\Tools\vsdevcmd.bat`" && set" | foreach-object {
                if ($_ -match "=") {
                    $name, $value = $_ -split '=', 2
                    Write-Verbose "SETTING $name=$value"
                    Set-Content env:\"$name" $value
                } else {
                    $_
                }
            }
        } else {
            Write-Warning "Visual Studio Developer Command Prompt v$($env:VSCMD_VER) is already installed"
        }
    }
}
