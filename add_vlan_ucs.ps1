param([string]$vlid = "vlid", [string]$vlname = "vlname")

$vlsum= [int]$vlid+50
$vlsumend = [int]$vlsum-1


<#write-host "VLsum=" $vlsum
write-host#>

write-host “Creating Vlans from $vlid to $vlsumend” -foreground green
for ($i=[int]$vlid;$i -lt [int]$vlsum; $i++) {
	
	
		<#write-host  -Name $i-$vlname -id $i #>
write-host “Creation of Vlan $i $vlname initiated”  -foreground green
	Get-UcsLanCloud | Add-UcsVlan -Name $i-$vlname -id $i
}

