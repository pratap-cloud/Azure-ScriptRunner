﻿#Requires -Version 5.0
#Requires -Modules Az.Compute

<#
    .SYNOPSIS
        Gets available virtual machine sizes
    
    .DESCRIPTION  
        
    .NOTES
        This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
        The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
        The terms of use for ScriptRunner do not apply to this script. In particular, ScriptRunner Software GmbH assumes no liability for the function, 
        the use and the consequences of the use of this freely available script.
        PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of ScriptRunner Software GmbH.
        © ScriptRunner Software GmbH

    .COMPONENT
        Requires Module Az.Compute
        Requires Library script AzureAzLibrary.ps1

   

    .Parameter VMName        
        [sr-en] Specifies the name of the virtual machine that this cmdlet gets the available virtual machine sizes for resizing
        [sr-de] Name der virtuellen Maschine

    .Parameter Location        
        [sr-en] Specifies the location for which this cmdlet gets the available virtual machine sizes
        [sr-de] Location der virtuellen Maschine

    .Parameter ResourceGroupName
        [sr-en] Specifies the name of the resource group of the virtual machine
        [sr-de] Name der resource group die die virtuelle Maschine enthält
#>

param( 
    [Parameter(Mandatory = $true,ParameterSetName = "Resource group")]
    [string]$ResourceGroupName,
    [Parameter(Mandatory = $true,ParameterSetName = "Resource group")]
    [string]$VMName,
    [Parameter(Mandatory = $true,ParameterSetName = "Location")]
    [string]$Location
)

Import-Module Az.Compute

try{
    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'}
    
    if($PSCmdlet.ParameterSetName -eq "Resource group"){
        $cmdArgs.Add('ResourceGroupName',$ResourceGroupName)
        if([System.String]::IsNullOrWhiteSpace($VMName) -eq $false){
            $cmdArgs.Add('VMName',$VMName)
        }
    }
    else{
        $cmdArgs.Add('Location',$Location)
    }

    $ret = Get-AzVMSize @cmdArgs | Select-Object *

    if($SRXEnv) {
        $SRXEnv.ResultMessage = $ret 
    }
    else{
        Write-Output $ret
    }
}
catch{
    throw
}
finally{
}