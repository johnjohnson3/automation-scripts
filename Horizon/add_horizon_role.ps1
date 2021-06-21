# Get Privileges for role "Horizon Role":
# Get-VIPrivilege -role "Horizon Role" | Format-Table -Property id > .\horizon_role_ids.txt

# the following creates a role $role and adds required permissions.  if $role
# already exists, the role will be updated to include all required permissions.
# no permissions are removed from $role

$role = "Horizon Role"
$rolepermfile = "horizon_role_ids.txt"
$viserver = "192.168.1.235"

Connect-VIServer -server $viserver

$roleids = @()

Get-Content $rolepermfile | Foreach-Object{
    $roleids += $_
}

New-VIRole -name $role -Privilege (Get-VIPrivilege -Server $viserver -id $roleids) -Server $viserver
Set-VIRole -Role $role -AddPrivilege (Get-VIPrivilege -Server $viserver -id $roleids) -Server $viserver

Disconnect-VIServer -server $viserver -Confirm:$false

