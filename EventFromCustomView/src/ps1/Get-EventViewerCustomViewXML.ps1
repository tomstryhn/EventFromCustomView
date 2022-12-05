<#PSScriptInfo

.DESCRIPTION Function to list Event Viewer Custom View XML

.VERSION 1.0.0.0

.GUID fc7e7b77-0d7b-49c5-aa0d-acfed07a2bc3

.AUTHOR Tom Stryhn

.COMPANYNAME Tom Stryhn

.COPYRIGHT 2022 (c) Tom Stryhn

.LICENSEURI https://github.com/tomstryhn/Get-EventViewerCustomViewXML/blob/main/LICENSE

.PROJECTURI https://github.com/tomstryhn/Get-EventViewerCustomViewXML

#>
function Get-EventViewerCustomViewXML {

<#
.SYNOPSIS
Get Name and Description from exported Microsoft Event Viewer Custom View XML

.DESCRIPTION
Filtering on XML files, and will try and sort out non-Custom View XMLs.

.PARAMETER Path
Path to parse (Defaults to Get-Location)

.PARAMETER Recurse
Will do a recursive search from the Path

.EXAMPLE
PS C:\EventViewer> Get-EventViewerCustomViewXML -Recurse

FileName   Name                                    Description
--------   ----                                    -----------
049517.xml Legacy Kerberos Ticket Encryption Types Legacy Kerberos Ticket Encryption Types: DES-CBC-CRC, DES-CBC-MD5...
0226D5.xml NTLMv1 Authentications                  NTLMv1 (Windows New Technology LAN Manager) Authentications

.NOTES
FUNCTION: Get-EventViewerCustomViewXML
AUTHOR:   Tom Stryhn
GITHUB:   https://github.com/tomstryhn/

.INPUTS
[string]

.OUTPUTS
[System.Management.Automation.PSCustomObject]

#>

    [CmdletBinding()]
    param (
        # Path
        [Parameter()]
        [string]
        $Path = (Get-Location),

        # Parameter help description
        [Parameter()]
        [switch]
        $Recurse
    )

    $customFilterXMLs = (Get-ChildItem -Path $Path -File -Recurse:$Recurse | Where-Object { ($_.Extension -match '.xml') -and ((Get-Content $_.FullName -TotalCount 1) -match '^\<ViewerConfig\>') })

    foreach($customFilterXML in $customFilterXMLs) {

        $xmlContent = [xml](Get-Content $customFilterXML.FullName)

        $output = [PSCustomObject]@{
            FileName    = $customFilterXML.Name
            Name        = $xmlContent.ViewerConfig.QueryConfig.QueryNode.Name
            Description = $xmlContent.ViewerConfig.QueryConfig.QueryNode.Description
            Path        = $customFilterXML.Directory.FullName
        }
        $output
    }
}