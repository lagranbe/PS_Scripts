param([string]$vlid = "vlid", [string]$grpname = "grpname")


$vlsum= [int]$vlid+50
$vlsumend = [int]$vlsum-1
Start-UcsTransaction



write-host $grpname / $vlid
write-host "Creating Vlan-Group $grpname" -foreground green
write-host $mo


write-host """ Get-UcsLanCloud | Add-UcsFabricNetGroup -Descr """" -Name "$grpname" -NativeNet """" -PolicyOwner
"local" -Type ""mgmt"" "
Complete-UcsTransaction


for ($i=[int]$vlid;$i -lt [int]$vlsum; $i++) {
	
	
		write-host "$m0 Add-UcsFabricPooledVlan -ModifyPresent -Name "$i-$grpname""

	
}

#>