# Get Privileges for role "App Volumes Manager":
# Get-VIPrivilege -role "App Volumes Manager" | Format-Table -Property id > .\appvolumes_role_ids.txt

# the following creates a role $cvRole and adds required permissions.  if $cvRole
# already exists, the role will be updated to include all required permissions.
# no permissions are removed from $cvRole

$role = "App Volumes Manager 1"
$rolepermfile = "appvolumes_role_ids.txt"
$viserver = "192.168.1.235"

Connect-VIServer -server $viserver

$roleids = @()

Get-Content $rolepermfile | Foreach-Object{
    $roleids += $_
}

New-VIRole -name $role -Privilege (Get-VIPrivilege -Server $viserver -id $roleids) -Server $viserver
Set-VIRole -Role $role -AddPrivilege (Get-VIPrivilege -Server $viserver -id $roleids) -Server $viserver

Disconnect-VIServer -server $viserver -Confirm:$false

