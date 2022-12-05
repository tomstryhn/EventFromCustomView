@{

    # Script module or binary module file associated with this manifest.
    RootModule = 'EventFromCustomView.psm1'

    # Version number of this module.
    ModuleVersion = '1.0.0.0'

    # ID used to uniquely identify this module
    GUID = '7f0dfd10-b39c-4985-8b0b-f49697475afe'

    # Author of this module
    Author = 'Tom Stryhn'

    # Company or vendor of this module
    CompanyName = 'Tom Stryhn'

    # Copyright statement for this module
    Copyright = 'Copyright (c) 2022 Tom Stryhn'

    # Description of the functionality provided by this module.
    Description = 'PowerShell Module for using Microsoft Windows Event Viewer Custom Views for Event Log Filtering in PowerShell'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Get-EventFromCustomViewXML',
                          'Get-EventViewerCustomViewXML')

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    FileList = @('EventFromCustomView.psd1',
                 'EventFromCustomView.psm1',
                 'LICENSE',
                 '.\src\ps1\Get-EventFromCustomViewXML.ps1',
                 '.\src\ps1\Get-EventViewerCustomViewXML.ps1')

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @('PSEdition_Desktop',
                     'Microsoft-Windows',
                     'Event-Viewer',
                     'Custom-View')

            # A URL to the license for this module.
            LicenseUri = 'https://opensource.org/licenses/MIT'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/tomstryhn/EventFromCustomView'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

            # ExternalModuleDependencies = @()

        } # End of PSData hashtable
    } # End of PrivateData hashtable
}