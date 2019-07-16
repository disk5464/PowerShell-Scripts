#This pings the core server to see if its online, if the server is online this should be as well. 
#After connecting it will get the IP addresses for all the vms and output it to a txt
#Last modified 7/15/19
#######################
#This installs the vmware modules
install-module -name vmware.powercli -Scope CurrentUser
#######################
$Ping = ""
$Ping = Ping COREWIN16 | Where-Object {$_ -match "Request timed out" -or $_ -match "Destination host unreachable"}

if ($Ping -ne "")
{
    Write-Host "This error occured" + $ping
}
#######################
#This gets the user's credentials for the server
$VmwareCred = Get-Credential -Message "Enter your vmware username and password"
#######################
#Thisis so that the server dosen't get tripped up on the fact that the server does not hava a certificate
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
#######################
#This connects you to the server
    try
    {
        Connect-VIServer 10.0.0.229 -ErrorAction Stop -Credential $VmwareCred
    }

    catch [VMware.VimAutomation.Sdk.Types.V1.ErrorHandling.VimException.ViServerConnectionException]
    {
        Write-host "Could not connect. Aborting"
        return   
    }
#######################
#This will get the ip for every VM on the system and output it to a txt
Get-vm | Format-Table name, @{N="IP";E={@($_.Guest.IPAddress)}} | Out-File C:\Temp\IPaddresses.txt




