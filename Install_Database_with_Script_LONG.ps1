#This script will run the DownloadDatabaseLONG script and then install that database
#Last modified 7/9/19
########################################
#This imprts the SQL cmdlets and sets the execution policy. If the SQL Cmdlet is not already installed see Fix_PS_Gallery_SQL.ps1

Import-Module -Name SqlServer
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
########################################
#This will get the location of the DownloadDatabaseLONG script, mvoe it to it's location and then run it. If no location is provided the script will quit
#This sets the location variable and then prompts the user for the file location

$LocationAnswer = ""
$LocationAnswer = Read-Host -Prompt "Do you know where the script is? (Yes or No)"
########################################
#This is a check to see if the user entered a valid response

If($LocationAnswer -eq "yes" -or $LocationAnswer -eq "no")
    {
        #This runs if the user responded ues. It asks for the file path and installs the database via the script
        If($LocationAnswer -eq "yes")
        {
            $ScriptLocation = Read-Host -Prompt "Where is DownloadDatabaseLONG.ps1 located? (Do not include the file name or the \ before the script)"
            cd $ScriptLocation
            .\DownloadDatabaseLONG.ps1
        }

        #This runs if the user responded no. It then mopves to a defult path, assumes the script is there and then runs it
        If($LocationAnswer -eq "no")
        {
            Write-Host "Moving to default directorey. (C:\Users\Administrator\Desktop\Scripts)"
            $ScriptLocation = "C:\Users\Administrator\Desktop\Scripts"
            cd $ScriptLocation
            .\DownloadDatabaseLONG.ps1
        }

    }

#This else statement runs if the user response is invalid
else
{
    Write-Host "No valid imput provided, try again"
}
########################################
#This will get the variables for the computer nama and the instance name, which we will need for the next section

$compName = $env:COMPUTERNAME
$instName ="Default"
$instName = Read-Host -Prompt "What is the instance name?"

If($instName -eq "")
{
    Write-Host "You need to enter an instance name"
}

$combinedInstName = $compName + "\" + $instName
########################################
#This will restore the database to the server
#The $Filename and $output vaiuables are derived from the DonloadDatabaseLong Script
#Since that script runs before the follow command the variables should be available
#Restore-SqlDatabase -ServerInstance $combinedInstName -Database $FileName -BackupFile $output
$fixedPath = $Path + "\" + $FileName
Restore-SqlDatabase -ServerInstance -Database "NewDatabase" -BackupFile "C:\Temp\NewDatabase.bak" -ReplaceDatabase
########################################



