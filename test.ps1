Start-UcsTransaction
$mo = Get-UcsLanCloud | Add-UcsFabricNetGroup -Descr "" -Name "ACI-VDS" -NativeNet "" -PolicyOwner
"local" -Type "mgmt"
$mo_1 = $mo | Add-UcsFabricPooledVlan -ModifyPresent -Name "1250-ACI-VDS"
$mo_2 = $mo | Add-UcsFabricPooledVlan -ModifyPresent -Name "1251-ACI-VDS"
$mo_3 = $mo | Add-UcsFabricPooledVlan -ModifyPresent -Name "1252-ACI-VDS"
$mo_4 = $mo | Add-UcsFabricPooledVlan -ModifyPresent -Name "1253-ACI-VDS"
$mo_5 = $mo | Add-UcsFabricPooledVlan -ModifyPresent -Name "1254-ACI-VDS"
$mo_6 = $mo | Add-UcsFabricPooledVlan -ModifyPresent -Name "1255-ACI-VDS"
$mo_7 = $mo | Add-UcsFabricPooledVlan -ModifyPresent -Name "1256-ACI-VDS"
Complete-UcsTransaction