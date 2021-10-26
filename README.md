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

Get a token using the ´Get-M365ServiceHealthToken -ClientId XXXX -ClientSecret XXXX -TenantName XXXX´

Provide that token to 

## Future
I plan in adding more cmdlets based on the [service communications API of Microsoft Graph](https://docs.microsoft.com/graph/api/resources/service-communications-api-overview).

Contributions are very well welcomed!