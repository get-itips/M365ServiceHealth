Function Get-M365ServiceHealthToken { 
		[CmdletBinding()]
		Param( 

		) 
		Process {
			if($Global:M365ServiceHealthClientSecret -eq $null -or $Global:M365ServiceHealthClientId -eq $Null -or $Global:M365ServiceHealthTenantName -eq $null ){
			
			Write-Host "Please run Initialize-M365ServiceHealth, Tenant parameters not set."
			break
			}

                #Request structure 
                $resource = "https://graph.microsoft.com/"  
                $tokenBody = @{  
                Grant_Type    = "client_credentials"  
                Scope         = "https://graph.microsoft.com/.default"  
                Client_Id     = $Global:M365ServiceHealthClientId 
                Client_Secret = $Global:M365ServiceHealthClientSecret  
                }

                  
				$graphTokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$Global:M365ServiceHealthTenantName/oauth2/v2.0/token" -Method POST -Body $tokenBody
                return $graphTokenResponse.access_token
		} 
	}