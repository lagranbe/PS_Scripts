#Clones std. vSwitches from one host to antoher.

$srvconnection = get-vc “cphlab-vcenter2.cisco.com”
$sourceHost = “10.54.62.92”
$targetHost = “cphlab-esxi-sp-01.cisco.com”

#Collecting source information
$sourceHostObj = Get-VMHost -Name $sourceHost -Server $srvconnection
write-host “Exporting vSwithes configurations from $sourceHost”
$sourcevSwitches = $sourceHostObj | Get-VirtualSwitch
write-host “Exporting Port Group configurations from $targetHost”
$sourcevPGs = $sourceHostObj | Get-VirtualPortGroup

#Collecting target host information
$targethostObj = Get-VMHost -Name $targetHost -Server $srvconnection
write-host “Exporting vSwithes configurations of target $targetHost”
$targetvSwitches = $targetHostObj | Get-VirtualSwitch
write-host “Exporting Port Group configurations of target $targetHost”
$targetvPGs = $targetHostObj | Get-VirtualPortGroup

# determine the difference
$differencevSwitches = Compare-Object $sourcevSwitches $targetvSwitches
$differencevPGs = Compare-Object $sourcevPGs $targetvPGs

# Only process the difference in vSwitches
$differencevSwitches | %{
$newvSwitch = $_.InputObject
Write-Host “Creating Virtual Switch $($newvSwitch.Name) on $targetHost”
if($newvSwitch.Nic) {
$outputvSwitch = $targethostObj | New-VirtualSwitch -Name $newvSwitch.Name -NumPorts $newvSwitch.NumPorts -Mtu $newvSwitch.Mtu -Nic $newvSwitch.Nic
} else {
$outputvSwitch = $targethostObj | New-VirtualSwitch -Name $newvSwitch.Name -NumPorts $newvSwitch.NumPorts -Mtu $newvSwitch.Mtu
}
}

# Only Process difference in Port Groups
$differencevPGs | %{
$newvPG = $_.InputObject
Write-Host “Creating Port group “”$($newvPG.Name)”” on vSwitch “”$($newvPG.VirtualSwitchName)”” on target host $targetHost”
$outputvPG = $targethostObj | Get-VirtualSwitch -Name $newvPG.VirtualSwitchName | New-VirtualPortGroup -Name $newvPG.Name-VLanId $newvPG.VLanID
}