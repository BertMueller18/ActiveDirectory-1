#requires -Version 2 -Modules ActiveDirectory
Get-ADObject -SearchBase $(Get-ADDomain).DeletedObjectsContainer -Filter {
    Deleted -eq $true
} -IncludeDeletedObjects -Properties Name, Description, SamAccountName, userprincipalname, DistinguishedName, WhenChanged |
Select-Object -Property Name, Description, ObjectClass, SamAccountName, userprincipalname, DistinguishedName, WhenChanged |
Out-GridView