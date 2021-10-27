Function Get-M365ServiceHealthIssues { 
		[CmdletBinding()]
		Param( 
                [Parameter(Position = 0, Mandatory = $true)][String]$ServiceName
		) 
		Process {
            
            if($Global:M365ServiceHealthClientSecret -eq $null -or $Global:M365ServiceHealthClientId -eq $Null -or $Global:M365ServiceHealthTenantName -eq $null ){
			
			Write-Host "Please run Initialize-M365ServiceHealth, Tenant parameters not set."
			break
			}

            #Request token
			$access_token=Get-M365ServiceHealthToken -ClientId $Global:M365ServiceHealthClientId -clientSecret $Global:M365ServiceHealthClientSecret -TenantName $Global:M365ServiceHealthTenantName
			#End Request token

            $apiUrlPart1 = 'https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/healthOverviews/'
            $apiUrlPart2 = '?$expand=issues'
            $apiUrl = $apiUrlPart1 + $ServiceName + $apiUrlPart2

            $Data = Invoke-RestMethod -Headers @{Authorization = "Bearer $access_token"} -Uri $apiUrl -Method Get

            $Data.issues | Where-Object {$_.IsResolved -ne 'True'} | Format-List id,featureGroup,title, lastModifiedDateTime

        }
}        