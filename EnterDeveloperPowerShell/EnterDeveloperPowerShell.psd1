#
# Module manifest for module 'EnterDeveloperPowerShell'
#
# Generated by: tcartwright
#
# Generated on: 8/15/2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'EnterDeveloperPowerShell.psm1'

# Version number of this module.
ModuleVersion = '1.0.10'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '8a3826b9-1e90-4063-9d36-4a8a1bf32146'

# Author of this module
Author = 'tcartwright'

# Company or vendor of this module
CompanyName = 'tcartwright'

# Copyright statement for this module
Copyright = '(c) 2021 tcartwright. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This function will enter the "Visual Studio Developer Command Prompt" mode in PowerShell for the Visual Studio version matching the $DisplayNameMatch.'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('Enter-VisualStudioDeveloperShell')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('Windows', 'VisualStudio', 'DeveloperCommandPrompt', 'PowerShell', 'VsDevCmd', 'VS')

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/tcartwright/EnterDeveloperPowerShell/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/tcartwright/EnterDeveloperPowerShell'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = @'
1.0.0 20210815
* Initial  release to PS Gallery		
1.0.2 20210815
* Fixed isse where RootModule was commented
* Attempted to edit description
1.0.3 20210815
* Shorted description, and removed readme 		
1.0.5
* final working version
1.0.6
* Updated script to return newest Version when multiples are found.
1.0.7
* Updated LicenseUri and ProjectUri in manifest.
1.0.8
* Updated manifest Description and site readme with slight wording change.
1.0.9
* More manifest and readme changes.
* Updated Tags
1.0.10
* Renamed function name to be clearer.
* Updated Tags
'@

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

