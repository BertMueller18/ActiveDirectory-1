#-------Edit/fill in these vars-------#
$oldnum = 'fakers'
$newnum = 'number'
$newdesc = 'name of dept - new description'
#----------Quit editing vars----------#

$newdept = "$newdesc [$newnum]"
$filter = "(&(objectCategory=user)(objectClass=user)(department=*$oldnum*))"
$users = get-aduser -LDAPFilter $filter -properties Department,Description
foreach ($user in $users)
{
    Write-Output "Changing $user description to $newdesc and department to $newdept"
    Set-ADUser -Identity $user -Description $newdesc -Department $newdept
}