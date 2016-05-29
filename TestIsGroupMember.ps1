#requires -Version 1 -Modules ActiveDirectory
function Test-IsGroupMember
{
    param (
        [Parameter(Mandatory=$True,
                Position=1,
        ValueFromPipeline=$True)]
        [string[]$Usernames,
        [Parameter(Mandatory=$True,
                Position=2,
        ValueFromPipeline=$True)]
        [string[]]$Groups
    )

    foreach ($strGroup in $Groups) {
        $arrMembers = @()
        $arrMembers = (Get-ADGroupMember -Identity $strGroup -Recursive).SamAccountName
        Write-Output "$strGroup has $($arrMembers.count) members"
        $Usernames | % { if ($arrMembers -contains $_) { write-output " * $_ is a member of $strGroup" } }
        Write-Output ''
    }
}

#Examples
#Test-IsGroupMember @('user1','user2','user3','ThmsRynr') @('Group1','Group2','Group3')
#Test-IsGroupMember ThmsRynr SomeGroup
#Test-IsGroupMember -Usernames (Get-ADGroupMember InterestingGroup).SamAccountName -Groups (Get-ADGroup -filter "Name -like '*Keyword*'").SamAccountName