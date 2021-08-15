<#
.SYNOPSIS
This function will enter the Visual Studio Developer Powershell mode, and will return the installation path of the version selected using the $DisplayNameMatch

.PARAMETER DisplayNameMatch
A regex that will be matched against the DisplayName of the instance. You can also send in "latest" to just get the latest version. Default: "latest"

.NOTES
Depends upon VSWHERE.exe. Requires that at the very least Visual Studio 2017 is installed or greater. Can be used to enter the developer powershell for
lower versions as long as VSWHERE.EXE is found.

.EXAMPLE
PS> $installPath = Invoke-VSDeveloperPowershell -DisplayNameMatch "latest"
PS> Write-Host "installPath = $installPath"

.EXAMPLE
PS> $installPath = Invoke-VSDeveloperPowershell -DisplayNameMatch "2017"
PS> Write-Host "installPath = $installPath"

.EXAMPLE
PS> $installPath = Invoke-VSDeveloperPowershell -DisplayNameMatch "2019" -Verbose
PS> Write-Host "installPath = $installPath"

.EXAMPLE
PS> $installPath = Invoke-VSDeveloperPowershell -DisplayNameMatch "Visual.*2019"
PS> Write-Host "installPath = $installPath"

.OUTPUTS
    System.String. Returns the Visual Studio installation Path.

.LINK About vshwere: https://docs.microsoft.com/en-us/visualstudio/install/tools-for-managing-visual-studio-instances?using-vswhereexe
#>
function Invoke-VSDeveloperPowershell {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]
        $DisplayNameMatch = "latest"
    )

    # TIM C: I extrapolated how to enter the Developer Shell from the shortcut that installs with VS 2019 called: "Developer PowerShell for VS 2019".
    # I added the take on VSWHERE so it will work for any version 2017+

    #. "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -?
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
            $instance = (. $vsWhere -format json | ConvertFrom-Json) `
                | Where-Object { $_.displayName -imatch $DisplayNameMatch }
        }

        if (!($instance)) {
            throw "An instance of Visual Studio could not be found using: $DisplayNameMatch"
            exit -2
        } elseif ($instance.GetType().Name -ieq "Object[]" -and $instance.Count -gt 1) {
            throw "Too many instances of Visual Studio were found using: $DisplayNameMatch, please alter your regex so that it is more selective."
            exit -3
        }

        $vsDevCmdPath = [System.IO.Path]::Combine($instance.installationPath, "Common7\Tools\VsDevCmd.bat")

        if (!(Test-Path $vsDevCmdPath)) {
            throw "Could not locate VsDevCmd.bat at: $vsDevCmdPath"
            exit -4
        }

        Write-Verbose "Found VsDevCmd.bat at $vsDevCmdPath"

        $ret = InvokeProcess -logName "VSDevShell" -exe "cmd.exe" -exeArgs "/c ""$vsDevCmdPath"""

        if ($ret -ne 0) {
            throw "Unable to enter Visual Studio Developer Powershell."
            exit $ret;
        }

        return $instance.installationPath
    }
}

function InvokeProcess (){
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidGlobalVars', '')] #Needed for the process events
	param(
        [System.String]$logName,
        [System.String]$exe,
        [System.String]$exeArgs
    )

	process {
		Write-Verbose "Running: $exe args: $exeArgs"

		$global:LogFormatName = $logName
		$global:logDateFormat = "MM-dd-yyyy HH:mm:ss.fff"
		$processInfo = New-Object System.Diagnostics.ProcessStartInfo
		$processInfo.FileName = $exe
		$processInfo.RedirectStandardError = $true
		$processInfo.RedirectStandardOutput = $true
		$processInfo.UseShellExecute = $false
		$processInfo.CreateNoWindow = $true
		$processInfo.Arguments = $exeArgs
		$process = New-Object System.Diagnostics.Process
		$process.StartInfo = $processInfo

		# Register Object Events for stdin\stdout reading
		$OutEvent = Register-ObjectEvent -Action {
			$data = $Event.SourceEventArgs.Data
			if ($data) {
				Write-Output "$global:LogFormatName[$(get-date -Format "$global:logDateFormat")]: $($data)"
			}
		} -InputObject $process -EventName OutputDataReceived

		$ErrEvent = Register-ObjectEvent -Action {
			$data = $Event.SourceEventArgs.Data
			if ($data) {
				Write-Warning "$global:LogFormatName[$(get-date -Format "$global:logDateFormat")]: $($data)"
			}
		} -InputObject $process -EventName ErrorDataReceived

		$process.Start() | Out-Null
		# Begin reading stdin\stdout
		$process.BeginOutputReadLine()
		$process.BeginErrorReadLine()
		$process.WaitForExit()

		$ret = $process.ExitCode
		# Unregister events
		$OutEvent.Name, $ErrEvent.Name | ForEach-Object { Unregister-Event -SourceIdentifier $_ }

		return $ret
	}
}


