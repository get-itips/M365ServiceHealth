Function Get-M365ServiceHealth { 
		[CmdletBinding()]
		Param( 
                [Parameter(Position = 0, Mandatory = $true)][String]$Access_Token

		) 
		Process { 
            $apiUrl = 'https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/healthOverviews'
            $Data = Invoke-RestMethod -Headers @{Authorization = "Bearer $access_token"} -Uri $apiUrl -Method Get
            return $Data.value
		} 
	}