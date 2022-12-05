<#PSScriptInfo

.DESCRIPTION Function to get Event(s) from Microsft Windows EventLog by using an Event Viewer Custom View XML.

.VERSION 1.0.0.0

.GUID 4cb6b3c4-df69-4e8d-b3f1-be51e2afdb57

.AUTHOR Tom Stryhn

.COMPANYNAME Tom Stryhn

.COPYRIGHT 2022 (c) Tom Stryhn

.LICENSEURI https://github.com/tomstryhn/Get-EventFromCustomViewXML/blob/main/LICENSE

.PROJECTURI https://github.com/tomstryhn/Get-EventFromCustomViewXML

#>

function Get-EventFromCustomViewXML {

<#
.SYNOPSIS
Get Event from the EventLog using a Event Viewer Custom View XML.

.DESCRIPTION
Get Event from the EventLog using a Event Viewer Custom View XML

.PARAMETER XMLFile
Path for the Event Viewer Custom View XML file

.EXAMPLE
PS C:\CustomFilters> Get-EventFromCustomViewXML -XMLFile .\01D97C.xml

   ProviderName: Microsoft-Windows-Security-Auditing

TimeCreated                     Id LevelDisplayName Message
-----------                     -- ---------------- -------
05-12-2022 02:13:47           4625 Information      An account failed to log on.…
04-12-2022 22:09:29           4625 Information      An account failed to log on.…
04-12-2022 22:09:28           4625 Information      An account failed to log on.…

.NOTES
FUNCTION: Get-EventFromCustomViewXML
AUTHOR:   Tom Stryhn
GITHUB:   https://github.com/tomstryhn/

.INPUTS
[string]

.OUTPUTS
[System.Diagnostics.Eventing.Reader.EventLogRecord]

#>

    [CmdletBinding()]
    param (
        # CustomFilter
        [Parameter()]
        [ValidateScript({Test-Path $_ -PathType Leaf })]
        [string]
        $XMLFile
    )
    
    $xmlFilter = ([xml](Get-Content $XMLFile)).ViewerConfig.QueryConfig.QueryNode.QueryList.OuterXML

    try {
        Get-WinEvent -FilterXml $xmlFilter
    }
    catch {
        if ($Error[0].Exception.ToString() -ne 'System.Exception: No events were found that match the specified selection criteria.') {
            $Error[0] | Write-Error
        }
        else {
            Write-Verbose -Message 'No events were found that match the specified selection criteria.'
        }
    }
}