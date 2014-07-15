param
(
$VCenterServer,
$User,
$Password)

Import-Module "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\prtgshell-master\prtgshell.psm1"
Add-PsSnapin VMware.VimAutomation.Core -ea "SilentlyContinue"
#$Mycred = Get-Credential

#$Mycred = Get-Credential
Connect-VIServer vcenter.infra.melbourne.co.uk -User prtg@system-domain -Password AK5mBFSnwu+R -WarningAction Ignore |Out-Null
#Disconnect-VIServer vcenter



$TotalCapacityGB=0
$TotalFreeSpaceGB=0
$xmlOutput=""

$xmlOutput+="<prtg>"

foreach( $Store in Get-Datastore | where {$_.name -like "ultravmclustervolume*"})
{
$xmlOutput += Set-PrtgResult "$($store.name) Free Space"     $(($store.FreeSpaceGB/$store.CapacityGB)*100) % -ShowChart
#write-host "$($Store.Name) capcity: $($store.CapacityGB)"
$TotalCapacityGB+= $store.CapacityGB
$TotalFreeSpaceGB+=$Store.FreeSpaceGB
}

$xmlOUtput+=Set-PrtgResult "Overall Free Space" $(($TotalFreeSpaceGB/$TotalCapacityGB)*100) % -ShowChart
$xmlOUtput+=Set-PrtgResult "Total Capacity GB" $TotalCapacityGB GB
#$TotalCapacityGB= $store.CapacityGB



$xmlOUtput +="</prtg>"
#$xmlOUtput += set-prtgresult "Free Space GB" 22 sec
#Write-Host   $TotalCapacityGB
return $xmlOUtput