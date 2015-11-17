$fromVMname = ACI-Ubuntu
$newVMName = $args
$tgtEsxName = cphacilab-esxi-1.cisco.com
$tgtDatastoreName = CPHLAB-Nimble-ESXi

$cloneTask = New-VM -Name $newVMName -VM (Get-VM $fromVMname) -VMHost (Get-VMHost $tgtEsxName) -Datastore (Get-Datastore $tgtDatastoreName) -RunAsync
Wait-Task -Task $cloneTask -ErrorAction SilentlyContinue
Get-Task | where {$_.Id -eq $cloneTask.Id} | %{
     if($_.State -eq "Error"){
          $event = Get-VIEvent -Start $_.FinishTime | where {$_.DestName -eq $newVMName} | select -First 1
          $emailFrom = <from-email-address>
          $emailTo = <to-email-address>
          $subject = "Clone of " + $newVMName + " failed"
          $body = $event.FullFormattedMessage
          $smtpServer = <your-smtp-server>
          $smtp = new-object Net.Mail.SmtpClient($smtpServer)
          $smtp.Send($emailFrom, $emailTo, $subject, $body)
     }
}