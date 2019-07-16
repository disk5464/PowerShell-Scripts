#The purpose of this scrupt is for a user to first select a database that is on the system and display its status (Online/Offline)
#This has not been tested, so it proabbly dosen't work.
#Last modiffied 6/28/19
#######################################
#######################################
#This gets the instance the user wants to access, logs thjem into the SQL Server and then displays the available servers.
$computerName = $env:COMPUTERNAME
$InstanceRequest = Read-Host "What instance do you weant to connect to?"
$Instance = "MyComputer\" + $InstanceRequest
$Credential = $host.UI.PromptForCredential("Feed me credentials", "Please enter the username and password for the instance you want to connec to.", "", "NetBiosUserName")
Invoke-Sqlcmd -ServerInstance $Instance -Username $Credential.UserName -Password $Credential.Password

$DatabasesOnComputer = Get-SqlInstance -Credential $Credential -ServerInstance $Instance | Get-SqlDatabase -Credential $Credential

Write-Host $DatabasesOnComputer
$RequestedDatabase = Read-Host -Prompt 'This is the instance you have selected.'

#######################################




