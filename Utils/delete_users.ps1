# This PowerShell script will delete all users and group

# Get the group that the users are in
param($module)
Write-Host "Deleting $module users"

$groups = Get-AzAdGroup
$groupname = $module + "*"
$toDel = $groups | Where-Object DisplayName -Clike $groupname

# Remove all the users
$usrList = Get-AzADGroupMember -GroupObjectId $toDel.Id
foreach ($usr in $usrList) {Remove-AzADUser -DisplayName $usr.DisplayName}

# Remove the group from AAD
Remove-AzADGroup -ObjectId $toDel.id
