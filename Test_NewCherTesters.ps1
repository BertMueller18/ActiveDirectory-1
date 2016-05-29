$Instance = Get-ADUser chertest01
$password_ss = ConvertTo-SecureString -String 'cherT3st' -AsPlainText -Force

function New-CherTestUser {
    param ([Parameter(Mandatory=$True)]
        $Number
    )
    
    $FNumber = $Number | % { "{0:d2}" -f $_ }
    
    $Attrs = @{
        'Instance'=$Instance
        'Name'="CherTest $($FNumber)"
        'DisplayName'="CherTest $($Fnumber)"
        'GivenName'='CherTest'
        'SurName'=$Fnumber
        'AccountPassword'=$password_ss
        'Enabled'=$enabled
        'ChangePasswordAtLogon'=$false
        'SamAccountName'="chertest$($Fnumber)"
        'Path'='OU=Cherwell Test Accounts,OU=TO,OU=IST,OU=Clients,DC=abcp,DC=ab,DC=bluecross,DC=ca'
        'UserPrincipalName'="chertest$($Fnumber)@abcp.ab.bluecross,ca"
    }

    New-ADUser @Attrs
    Add-ADGroupMember -Identity 'Cherwell_users_sync' -Members "chertest$($Fnumber)"
}

3..25 | % { New-CherTestUser -Number $_ }