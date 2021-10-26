Function Get-M365ServiceHealth { 
		[CmdletBinding()]
		Param( 
				[Parameter(Position = 0, Mandatory = $false)][String]$Refresh = 60,
				[Parameter(Position = 0, Mandatory = $true)][String]$ClientId, 
                [Parameter(Position = 0, Mandatory = $true)][String]$ClientSecret,
                [Parameter(Position = 0, Mandatory = $true)][String]$TenantName
		) 
		Process {

			#Request token
			$access_token=Get-M365ServiceHealthToken -ClientId $clientId -clientSecret $clientSecret -TenantName $tenantName
			#End Request token
			$processBeginTime=Get-Date
			
            $apiUrl = 'https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/healthOverviews'
            while($true){
				$Data = Invoke-RestMethod -Headers @{Authorization = "Bearer $access_token"} -Uri $apiUrl -Method Get
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
							'serviceDegradation' {$color="27"; break}
							default { $color = "0" }
						}
						$e = [char]27
						"$e[${color}m$($_.status)${e}[0m"
					}
				}
				$now=Get-Date
				Write-Host "Last updated $now"
				$now.AddSeconds($refresh)
				Write-Host "Refreshing at $now"
				Start-Sleep -Seconds $Refresh
				Clear-Host
				if(((get-date)-$processBeginTime).TotalMinutes -gt 55){
					$access_token=Get-M365ServiceHealthToken -ClientId $clientId -clientSecret $clientSecret -TenantName $tenantName
					}
			}	

		} 
	}