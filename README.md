# M365ServiceHealth

## Introduction

Started to build this module for educational purposes and also because I am a Microsoft 365 Multi-Tenant administrator and wanted to have the service status being refreshed in a PowerShell window (or better, in a Windows Terminal pane) while working.

## Cmdlets
The module is pretty simple, so far you can find:

- Get-M365ServiceHealth
- Get-M365ServiceHealthIssues
- Get-M365ServiceHealthToken

## Requirements

The module requires an application registered in AAD.
The application needs to have this permission:

- ServiceHealth.Read.All

## How to use

To get an overview of Microsoft 365 Services health:

`Get-M365ServiceHealth` Syntax:

```powershell
Get-M365ServiceHealth -ClientId <String> -ClientSecret <String> -TenantName <String> [-Refresh <UInt32>]
```
To get a list of unresolved issues per service:

```powershell
Get-M365ServiceHealthIssues -ServiceName <String> -ClientId <String> -ClientSecret <String> -TenantName <String>
```


By default it will refresh every 60 seconds but you can specify using -Refresh parameter.

## Future

- I plan in adding more cmdlets based on the [service communications API of Microsoft Graph](https://docs.microsoft.com/graph/api/resources/service-communications-api-overview).
- Docs
- Better error handling
- Better token handling

Contributions are very well welcomed!