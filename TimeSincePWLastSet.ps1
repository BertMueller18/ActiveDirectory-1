#requires -Version 1 -Modules ActiveDirectory
function Get-TimeSinceLastPWSet 
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True,
                Position = 1,
        ValueFromPipeline = $True)]
        [string]$Username
    )
    
    $tsSinceLastPWSet = New-TimeSpan -Start $(Get-ADUser $Username -Properties Passwordlastset).Passwordlastset -End $(Get-Date)
    Write-Output $tsSinceLastPWSet
}