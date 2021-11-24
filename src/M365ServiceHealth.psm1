#################################################################################
# M365ServiceHealh for PowerShell Console
# Andrés Gorzelany @andresgorzelany
# Requires AzureAD Application with this Application Permisssion: 
# - ServiceHealth.Read.All
# V0.0.1 - Initial Version - Andrés Gorzelany
# V0.0.2 - Code Rewrite - Andres Bohren @andresbohren
#################################################################################
#Requires -Modules MSAL.PS


#################################################################################
# Public Function Connect-M365ServiceHealth
#################################################################################
Function Connect-M365ServiceHealth { 

<# 
.SYNOPSIS
	Connect to the M365 Service Communication API and get the AccessToken to Query the Service Communications API

.DESCRIPTION
    Connect to the M365 Service Communication API and get the AccessToken to Query the Service Communications API

.PARAMETER TenantId 
    The Name of the Tenant

.PARAMETER ApplicationId 
    The Application ID

.PARAMETER ClientSecret
	The Client Secret

.PARAMETER CertificateThumbprint
	The Thumbprint of your Certificate 

.EXAMPLE
	Connect-M365ServiceHealth 
	Connect-M365ServiceHealth -TenantId <Tenant.onmicrosoft.com> -ApplicationId <AppID> -ClientSecret <ClientSecret>
	Connect-M365ServiceHealth -TenantId <Tenant.onmicrosoft.com> -ApplicationId <AppID> -CertificateThumbprint <CertificateThumbprint>

.LINK
#>


<#
#AzureAD
Connect-AzureAD -ApplicationId $AppID -CertificateThumbprint $CertificateThumbprint -TenantId $TenantId
#ExchangeOnline
Connect-ExchangeOnline -AppID $AppID -CertificateThumbprint $CertificateThumbprint -Organization $TenantId
#MicrosoftTeams
Connect-MicrosoftTeams -ApplicationId $AppID -CertificateThumbprint $CertificateThumbprint -TenantId $TenantId

I guess we should use similar Parameters

#>

	
	Param( 
			[Parameter(Mandatory = $false)][String]$TenantId, 
			[Parameter(Mandatory = $false)][String]$ApplicationId,
			[Parameter(Mandatory = $false)][String]$ClientSecret,
			[Parameter(Mandatory = $false)][String]$CertificateThumbprint
	) 
	Process {


		Write-Host "DEBUG: TenantID: $TenantID"
		Write-Host "DEBUG: ApplicationID: $ApplicationID"
		Write-Host "DEBUG: ClientSecret: $ClientSecret"
		Write-Host "DEBUG: CertificateThumbprint: $CertificateThumbprint"

		#Scope is always Microsoft Graph
		$Scope = "https://graph.microsoft.com/.default"

		If ($TenantId -eq $NULL -and $ApplicationId -eq $NULL -AND $ClientSecret -eq $NULL -and $CertificateThumbprint -eq $NULL)
		{
			###############################################################################
			#Interactive (authorization code flow)
			###############################################################################
			Write-Host "DEBUG: SELECT > Interactive"
			$connectionDetails = @{
				'TenantId'		= $TenantId
				'ClientId'		= $ApplicationId
				'Scope'			= $Scope
				'Interactive'	= $true
			}
			$Token = Get-MsalToken @connectionDetails
			$Global:AccessToken = $Token.AccessToken
			#DEBUG
			$Global:AccessToken

		} 

		If ($TenantId -ne $NULL -and $ApplicationId -ne $NULL -and $ClientSecret -ne $NULL )
		{
			###############################################################################
			#Client Secret
			###############################################################################
			Write-Host "DEBUG: SELECT > Client Secret"
			$ClientSecretSecure = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
			$connectionDetails = @{
				'TenantId'     = $TenantId
				'ClientId'     = $ApplicationId
				'ClientSecret' = $ClientSecretSecure
			}
			$Token = Get-MsalToken @connectionDetails
			$Global:AccessToken = $Token.AccessToken
			#DEBUG
			$Global:AccessToken
		}

		If ($TenantId -ne $NULL -and $ApplicationId -ne $NULL -and $CertificateThumbprint -ne $NULL)
		{
			###############################################################################
			#Certificate
			###############################################################################
			Write-Host "DEBUG: SELECT > Certificate"
			$ClientCertificate = Get-Item Cert:\CurrentUser\My\$CertificateThumbprint
			$connectionDetails = @{
				'TenantId'          = $TenantId
				'ClientId'          = $ApplicationId
				'ClientCertificate' = $ClientCertificate
			}
			$Token = Get-MsalToken @connectionDetails
			$Global:AccessToken = $Token.AccessToken
			#DEBUG
			$Global:AccessToken
		}
	} 
} 





#################################################################################
# Public Function Connect-M365ServiceHealth
#################################################################################
Function Disconnect-M365ServiceHealth { 
<# 
.SYNOPSIS
	Disconnect to the M365 Service Communication API and clear the AccessToken

.DESCRIPTION
    Disconnect to the M365 Service Communication API and clear the AccessToken

.EXAMPLE
	Disconnect-M365ServiceHealth 
#>

	#Clear Tokens 
	Clear-MsalTokenCache

	#Clear Global Variable
	$Global:AccessToken = $null
}



#################################################################################
# Public Function Get-M365ServiceHealthIssues
#################################################################################

Function Get-M365ServiceHealthIssues { 
<# 
.SYNOPSIS
	Get Service Healh Issues for a Specific Service
		
.DESCRIPTION
    Get Service Healh Issues for a Specific Service

.PARAMETER ServiceName
	The ServiceName you want to Query

.EXAMPLE
	Get-M365ServiceHealthIssues -ServiceName <ServiceName> 
	Get-M365ServiceHealthIssues -ServiceName "Exchange Online"
#>

	[CmdletBinding()]
	Param( 
			[Parameter(Position = 0, Mandatory = $true)][String]$ServiceName
	) 
	Process {
		
		if($Global:AccessToken -eq $Null ){
			Write-Host "Please run Connect-M365ServiceHealth, Tenant parameters not set."
			break
		}

		$apiUrlPart1 = 'https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/healthOverviews/'
		$apiUrlPart2 = '?$expand=issues'
		$apiUrl = $apiUrlPart1 + $ServiceName + $apiUrlPart2

		$Data = Invoke-RestMethod -Headers @{Authorization = "Bearer $Global:AccessToken"} -Uri $apiUrl -Method Get

		$Data.issues | Where-Object {$_.IsResolved -ne 'True'} | Format-List id,featureGroup,title, lastModifiedDateTime

	}
}        

#################################################################################
# Public Function Get-M365ServiceHealth
#################################################################################
Function Get-M365ServiceHealth { 
	[CmdletBinding()]
	Param( 
			[Parameter(Position = 0, Mandatory = $false)][String]$Refresh = 60

	) 
	Process {

		if($Global:AccessToken -eq $NULL){
			Write-Host "Please run Connect-M365ServiceHealth, Tenant parameters not set."
			break
		}

		$processBeginTime=Get-Date
		
		$apiUrl = 'https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/healthOverviews'
		while($true){
			$Data = Invoke-RestMethod -Headers @{Authorization = "Bearer $Global:AccessToken"} -Uri $apiUrl -Method Get
			$services = @()
			foreach ($entry in $data.value){
				$obj = New-Object -TypeName PSObject
				$obj | Add-Member -MemberType NoteProperty -Name Service -value $entry.service
				$obj | Add-Member -MemberType NoteProperty -Name Status -value $entry.Status
				
				$services+=$obj
				
			}
			$services | Format-Table Service, @{

			Label = "Status"
			Expression = 
				{

					switch($_.status)
					{
						'restoringService' { $color="96";break}
						'serviceOperational' {$color="92"; break}
						'serviceDegradation' {$color="41"; break}
						default { $color = "0" }
					}
					$e = [char]27
					"$e[${color}m$($_.status)${e}[0m"
				}
			}
			$now=Get-Date
			Write-Host "Last updated $now"
			$now=$now.AddSeconds($refresh)
			Write-Host "Refreshing at $now"
			Start-Sleep -Seconds $Refresh
			Clear-Host
			if(((get-date)-$processBeginTime).TotalMinutes -gt 55){
				$access_token=Get-M365ServiceHealthToken -ClientId $Global:M365ServiceHealthClientId -clientSecret $Global:M365ServiceHealthClientSecret -TenantName $Global:M365ServiceHealthTenantName
				}
		}	

	} 
}


#################################################################################
# Main Script
#################################################################################
Import-Module MSAL.PS
#$Global:$AccessToken=$null
New-Alias -Name "Initialize-M365ServiceHealth" -Value "Connect-M365ServiceHealth"