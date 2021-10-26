# M365ServiceHealth

## Introduction

Started to build this module for educational purposes and also because I am a Microsoft 365 Multi-Tenant administrator and wanted to have the service status being refreshed in a PowerShell window (or better, in a Windows Terminal pane) while working.

## Cmdlets
The module is pretty simple, so far you can find:

- Get-M365ServiceHealth
- Get-M365ServiceHealthToken

## Requirements

The module requires an application registered in AAD.
The application needs to have this permission:

- ServiceHealth.Read.All

## How to use

`Get-M365ServiceHealth` Syntax:

```powershell
Get-M365ServiceHealth -ClientId <String> -ClientSecret <String> -TenantName <String> [-Refresh <UInt32>]
```

By default it will refresh every 60 seconds but you can specify using -Refresh parameter.

## Future
I plan in adding more cmdlets based on the [service communications API of Microsoft Graph](https://docs.microsoft.com/graph/api/resources/service-communications-api-overview).

Contributions are very well welcomed!