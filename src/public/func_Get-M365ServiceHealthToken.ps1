Function Get-M365ServiceHealthToken { 
		[CmdletBinding()]
		Param( 
				[Parameter(Position = 0, Mandatory = $true)][String]$ClientId, 
                [Parameter(Position = 0, Mandatory = $true)][String]$ClientSecret,
                [Parameter(Position = 0, Mandatory = $true)][String]$TenantName
		) 
		Process { 
                $resource = "https://graph.microsoft.com/"  
                $tokenBody = @{  
                Grant_Type    = "client_credentials"  
                Scope         = "https://graph.microsoft.com/.default"  
                Client_Id     = $clientId  
                Client_Secret = $clientSecret  
                }

                  
				$graphTokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantName/oauth2/v2.0/token" -Method POST -Body $tokenBody
                return $graphTokenResponse.access_token
		} 
	}