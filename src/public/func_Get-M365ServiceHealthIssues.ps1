Function Get-M365ServiceHealthIssues { 
		[CmdletBinding()]
		Param( 
				[Parameter(Position = 0, Mandatory = $true)][String]$ClientId, 
                [Parameter(Position = 0, Mandatory = $true)][String]$ClientSecret,
                [Parameter(Position = 0, Mandatory = $true)][String]$TenantName,
                [Parameter(Position = 0, Mandatory = $true)][String]$ServiceName
		) 
		Process {
            
            #Request token
			$access_token=Get-M365ServiceHealthToken -ClientId $clientId -clientSecret $clientSecret -TenantName $tenantName
			#End Request token

            $apiUrlPart1 = 'https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/healthOverviews/'
            $apiUrlPart2 = '?$expand=issues'
            $apiUrl = $apiUrlPart1 + $ServiceName + $apiUrlPart2

            $Data = Invoke-RestMethod -Headers @{Authorization = "Bearer $access_token"} -Uri $apiUrl -Method Get

            $Data.issues | Where-Object {$_.IsResolved -ne 'True'} | Format-List id,featureGroup,title, lastModifiedDateTime

        }
}        