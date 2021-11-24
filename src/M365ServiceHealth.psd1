@{
	RootModule 		= 'M365ServiceHealth.psm1' 
	ModuleVersion 		= '0.0.2' 
	# RequiredModules = @(ModuleName = 'ExchangeOnlineManagement'; ModuleVersion = '2.0.5'; Guid = 'b5eced50-afa4-455b-847a-d8fb64140a22')
	# Requires = @(ModuleName = 'ExchangeOnlineManagement'; ModuleVersion = '2.0.3'; Guid = 'b5eced50-afa4-455b-847a-d8fb64140a22')
	CompatiblePSEditions 	= 'Desktop', 'Core'
	PowerShellVersion = '5.1' 
	GUID 			= '605fc8c1-0d1f-4749-ad3e-1ed55d071291' 
	Author 			= 'Andrés Gorzelany @andresgorzelany' 
	CompanyName 		= 'Andrés Gorzelany' 
	Copyright 		= '(c) Andrés Gorzelany. All rights reserved.' 
	Description 		= 'M365ServiceHealth works by providing different cmdlets to retrieve Microsoft 365 Service status by querying the official Graph service communications API. More information at https://github.com/get-itips/M365ServiceHealth'
	FunctionsToExport 	= @('Get-M365ServiceHealth','Get-M365ServiceHealthIssues','Connect-M365ServiceHealth', 'Disconnect-M365ServiceHealth') 
	CmdletsToExport 	= @() 
	VariablesToExport 	= @() 
	AliasesToExport 	= @() 
	PrivateData 		= @{
	PSData 			= @{} 
	} 
}
