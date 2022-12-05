# EventFromCustomView PowerShell Module

PowerShell Module for using Microsoft Windows Event Viewer Custom Views for Event Log Filtering in PowerShell

## Table of Content

  - [Version Changes](#version-changes)
  - [Background](#background)
      - [Risk(s)](#risks)
      - [Mitigation](#mitigation)
  - [Importing the Module](#importing-the-module)
  - [Examples](#examples)
  - [Functions](#functions)
      - [Get-EventFromCustomViewXML](#get-eventfromcustomviewxml)
      - [Get-EventViewerCustomView](#get-eventviewercustomviewxml)

## Version Changes

##### 1.0.0.0
- First version published on GitHub

## Background

Most administrators, investigators or supporters have at some point in time, made one or more Custom Views in the Microsoft Windows Event Viewer and then copied parts, or the whole filter, into a PowerShell-script to try and get the same events outputted in their shell. This simple module resolves that, now you just export your Custom View in the Event Viewer to an XML, and uses it directly with the Get-EventFromCustomViewXML, to output the exact same Events.

## Importing the Module

Currently not published in PSGallery, so you have to download the Module and Import it the hard way... (Sorry)

## Examples

Get a list of the Custom Views using the  `Get-EventViewerCustomViewXML`:

```PowerShell

PS C:\EventViewer> Get-EventViewerCustomViewXML -Recurse | Sort-Object Name

FileName   Name                                    Description
--------   ----                                    -----------
01D97C.xml Administrator Logon (Failed)            Failed Administrator Account Logons
049517.xml Legacy Kerberos Ticket Encryption Types Legacy Kerberos Ticket Encryption Types: DES-CBC-CRC, DES-CBC-MD5...
0226D5.xml NTLMv1 Authentications                  NTLMv1 (Windows New Technology LAN Manager) Authentications

PS C:\> _

```

Note that when using `-Recurse` it can be helpful to use the below syntax, to also see where the XML's are located.

```PowerShell

PS C:\> Get-EventViewerCustomViewXML -Recurse | Sort-Object Name | Select-Object FileName,Name,Path

FileName   Name                                    Path
--------   ----                                    ----
01D97C.xml Administrator Logon (Failed)            C:\\CustomViews
049517.xml Legacy Kerberos Ticket Encryption Types C:\\CustomViews
0226D5.xml NTLMv1 Authentications                  C:\\CustomViews

PS C:\> _

```

Then get the Event wanted, using the `Get-EventFromCustomViewXML`:

```PowerShell

PS C:\> Get-EventFromCustomViewXML .\01D97C.xml

   ProviderName: Microsoft-Windows-Security-Auditing

TimeCreated                      Id LevelDisplayName Message
-----------                      -- ---------------- -------
05-12-2022 02:13:47            4625 Information      An account failed to log on....
04-12-2022 22:09:29            4625 Information      An account failed to log on....

PS C:\> _

```

## Functions

The list of the functions contained in this module.

### Get-EventFromCustomViewXML

```PowerShell

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
```

### Get-EventViewerCustomViewXML

```PowerShell
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
```

