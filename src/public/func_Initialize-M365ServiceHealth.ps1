Function Initialize-M365ServiceHealth { 
		[CmdletBinding()]
		Param( 
				[Parameter(Position = 0, Mandatory = $true)][String]$ClientId, 
                [Parameter(Position = 0, Mandatory = $true)][String]$ClientSecret,
                [Parameter(Position = 0, Mandatory = $true)][String]$TenantName
		) 
		Process {
                #Set the input params as Global variables for future use
                $Global:M365ServiceHealthClientId=$ClientId
                $Global:M365ServiceHealthClientSecret=$ClientSecret
                $Global:M365ServiceHealthTenantName=$TenantName
                #End setting global variables
                Write-Host "Tenant parameters set."
		} 
	}                