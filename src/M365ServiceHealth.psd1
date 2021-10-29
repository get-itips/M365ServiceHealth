@{
	RootModule 		= 'M365ServiceHealth.psm1' 
	ModuleVersion 		= '0.0.1' 
	CompatiblePSEditions 	= 'Desktop', 'Core' 
	GUID 			= '605fc8c1-0d1f-4749-ad3e-1ed55d071291' 
	Author 			= 'Andrés Gorzelany @andresgorzelany' 
	CompanyName 		= 'Unknown' 
	Copyright 		= '(c) Andrés Gorzelany. All rights reserved.' 
	Description 		= 'M365ServiceHealth works by providing different cmdlets to retrieve Microsoft 365 Service status by querying the official Graph service communications API. More information at https://github.com/get-itips/M365ServiceHealth'
	FunctionsToExport 	= @('Get-M365ServiceHealth','Get-M365ServiceHealthIssues','Get-M365ServiceHealthToken','Initialize-M365ServiceHealth') 
	CmdletsToExport 	= @() 
	VariablesToExport 	= @() 
	AliasesToExport 	= @() 
	PrivateData 		= @{
	PSData 			= @{} 
	} 
}
