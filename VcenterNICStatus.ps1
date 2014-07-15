Import-Module "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\prtgshell-master\prtgshell.psm1"
Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"
#$Mycred = Get-Credential
Connect-VIServer vcenter.infra.melbourne.co.uk -User prtg@system-domain -Password AK5mBFSnwu+R -WarningAction Ignore |Out-Null
#Disconnect-VIServer vcenter

$Result=Get-VMHostNetworkAdapter -physical |  where {$_.vmhost -like "*.infra.melbourne.co.uk" -and $_.bitratepersec -EQ 0} 

$xmlOutput=""
$xmlOutput="<prtg>"

if ($result -eq "")
{ $xmloutput += Set-PrtgResult "Number of NIC Uplinks in DOWN State"     0 Count -ShowChart}
else
{ $xmlOutput+= Set-PrtgResult "Number of NIC Uplinks in DOWN State"    $result.count  Count -ShowChart}

$xmlOUtput +="</prtg>"
#$xmlOUtput += set-prtgresult "Free Space GB" 22 sec
#Write-Host   $TotalCapacityGB
return $xmlOUtput