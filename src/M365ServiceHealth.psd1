@{
	RootModule 		= 'M365ServiceHealth.psm1' 
	ModuleVersion 		= '0.0.1' 
	CompatiblePSEditions 	= 'Desktop', 'Core' 
	GUID 			= '605fc8c1-0d1f-4749-ad3e-1ed55d071291' 
	Author 			= 'Andrés Gorzelany @andresgorzelany' 
	CompanyName 		= 'Unknown' 
	Copyright 		= '(c) Andrés Gorzelany. All rights reserved.' 
	Description 		= 'Created this module for learning purposes on how to develop a module - M365ServiceHealth works by providing different cmdlets to retrieve Microsoft 365 Service status by querying the official Graph service communications API'
	FunctionsToExport 	= 'Get-M365ServiceHealth' 
	CmdletsToExport 	= @() 
	VariablesToExport 	= @() 
	AliasesToExport 	= @() 
	PrivateData 		= @{
	PSData 			= @{} 
	} 
}