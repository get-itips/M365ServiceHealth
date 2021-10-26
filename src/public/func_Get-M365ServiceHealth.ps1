Function Get-M365ServiceHealth { 
		[CmdletBinding()]
		Param( 
                [Parameter(Position = 0, Mandatory = $true)][String]$Access_Token
				[Parameter(Position = 0, Mandatory = $false)][String]$Refresh
		) 
		Process { 
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
							default { $color = "0" }
						}
						$e = [char]27
						"$e[${color}m$($_.status)${e}[0m"
					}
				}
				$now=Get-Date
				Write-Host "Last updated $now"
				Start-Sleep -Seconds $Refresh
				Clear-Host
			}	

		} 
	}