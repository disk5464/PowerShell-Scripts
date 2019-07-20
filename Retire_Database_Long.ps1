#This script is designed to retire a production MS SQL Server DB
#It has not been modified and should be considered non-functional
#Last modified 6/19/19
###############################
#To make life easier this will use the DBA tools module. Which makes it required for this script to work
#It will first check for the module and if it does not exist installs it
If(Get-Module -ListAvailable -Name DBATools)
{
    Write-Host "DBATools exists, moving on"
}
else
{
    Write-Host "DBATOols does not exist. It will now be installed. If this fails consult the Fix_PSgallery_Install_SQL script. Beginning instalation"
    Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
    Install-Module -Name DBATools -Scope CurrentUser -Force
}
###############################
#This section will set up the menu funtion
function Show-Menu
{
    param (
        [string]$Title = 'SQL Database retirement Menu'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' to begin retiring a database."
    Write-Host "2: Press '2' to finish retiring a database."
    Write-Host "Q: Press 'Q' to quit."
    Write-Host "=========================================================="
}
########################################
#This part will present the user with the options and allwow them to select theiur choice
Show-Menu -Title 'SQL Database retirement Menu'
$selection = Read-Host "What would you like to do today?"
Write-Host "=========================================================="
Write-Host "=========================================================="
switch ($selection)
{
    '1'
    {
       #######################
       #This allows you to specify the instance that you are going top use and then connects to it.
       $Instance = Read-Host -Prompt "What instance do you want to retire?"
       Connect-DbaInstance -SqlInstance $Instance
       #######################
       #This part will find the required jobs and list their current status. It will then disable the ones we want.

       #This gets the lsit of jobs and if a job's name contains the word backup, it gets confirmation, adn then disables the job
       $listofJobs = Get-DBAgentJob
       foreach ($job in $listofJobs)
       {
            if($job -like '*Backup*')
            {
                #This tells the user what job is about to be disabled and prompts them for conformaiton
                $jobConfirm = Read-host -Prompt ('The job: ' + $job.Name + ' Will be disabled. Press enter to continue or q to quit')
                
                if($jobConfirm = "")
                {
                    #The -SQLinstance filter is here in case the user is connected to multiple instances. If it causes problems just delete it
                    Set-DbaAgentJob -SqlInstance $Instance -Job $job -Disabled
                    Write-host $job + " on " + $Instance + " has been disabled"
                }

                #This is for if the user decides to not disable the targeted job
                if($jobConfirm -eq "q")
                {
                    Write-Host "Job not disabled"
                }
            }

            if($job -like '*DatabaseIntegrityCheck*')
            {
                #This tells the user what job is about to be disabled and prompts them for conformaiton
                $jobConfirm = Read-host -Prompt ('The job: ' + $job.Name + ' Will be disabled. Press enter to continue or q to quit')
                
                if($jobConfirm = "")
                {
                    #The -SQLinstance filter is here in case the user is connected to multiple instances. If it causes problems just delete it
                    Set-DbaAgentJob -SqlInstance $Instance -Job $job -Disabled
                    Write-host $job + " on " + $Instance + " has been disabled"
                }

                #This is for if the user decides to not disable the targeted job
                if($jobConfirm -eq "q")
                {
                    Write-Host "Job not disabled"
                }
            }

            if($job -like '*IndexOptimizer*')
            {
                #This tells the user what job is about to be disabled and prompts them for conformaiton
                $jobConfirm = Read-host -Prompt ('The job: ' + $job.Name + ' Will be disabled. Press enter to continue or q to quit')
                
                if($jobConfirm = "")
                {
                    #The -SQLinstance filter is here in case the user is connected to multiple instances. If it causes problems just delete it
                    Set-DbaAgentJob -SqlInstance $Instance -Job $job -Disabled
                    Write-host $job + " on " + $Instance + " has been disabled"
                }

                #This is for if the user decides to not disable the targeted job
                if($jobConfirm -eq "q")
                {
                    Write-Host "Job not disabled"
                }
            }

            if($job -like '*Transaction*')
            {
                #This tells the user what job is about to be disabled and prompts them for conformaiton
                $jobConfirm = Read-host -Prompt ('The job: ' + $job.Name + ' Will be disabled. Press enter to continue or q to quit')
                
                if($jobConfirm = "")
                {
                    #The -SQLinstance filter is here in case the user is connected to multiple instances. If it causes problems just delete it
                    Set-DbaAgentJob -SqlInstance $Instance -Job $job -Disabled
                    Write-host $job + " on " + $Instance + " has been disabled"
                }

                #This is for if the user decides to not disable the targeted job
                if($jobConfirm -eq "q")
                {
                    Write-Host "Job not disabled"
                }
            }
       }
       ##################
       #This is used to section off the job disableing section
       Wrte-host "=========================================================="
       ##################
       #This get the database's name that we want to take offline

       $databaseName = Read-Host -Prompt "Which database do you want to take offline?"
       ##################
       #This step will double check that the correct database has been selected adn then takes it offline

       $DBCheck = Read-Host -Prompt ($databaseName + ' is about to be taken offline, Procede? (Yes or no)')
       if ($DBCheck-eq 'yes' -or $DBCheck -eq 'no')
       {
            if($DBCheck -eq 'yes')
            {
                Set-DbaDbState -SqlInstance $Instance -Database $databaseName
                write-host ($databaseName + ' has been taken offline.')
            }

            if($DBCheck -eq 'no')
            {
                Write-Host "No was selected. No action will be taken"
                return
            }
       }
       
       else
       {
        Write-Host "Neither yes no no was selected. No action will be taken"
        return
       }
       ##################
       #At this point you have to wait seven days so the script stops and exits here

       Write-Host "Now that the database has been taken offline, you must wait 7 days."
       return
       ##################

       #just some breething room in the script


       ##################
    }
    
    '2'
    {
       ##################
       #This allows you to specify the instance that you are going to use and then connects to it.

       $Instance = Read-Host -Prompt "Welcome back, what instance do you want to retire?"
       Connect-DbaInstance -SqlInstance $Instance
       ##################
       #This part will find the required jobs and list their current status. It will then delete the ones we want.

       #This gets the lsit of jobs and if a job's name contains the word backup, it gets confirmation, adn then deleted the job
       $listofJobs = Get-DBAgentJob
       foreach ($job in $listofJobs)
       {
            if($job -like '*Backup*')
            {
                #This tells the user what job is about to be deleted and prompts them for conformaiton
                $jobConfirm = Read-host -Prompt ('The job: ' + $job.Name + ' Will be deleted. Press enter to continue or q to quit')
                
                if($jobConfirm = "")
                {
                    #The -SQLinstance filter is here in case the user is connected to multiple instances. If it causes problems just delete it
                    Remove-DbaAgentJob -SqlInstance $Instance -Job $job 
                    Write-host $job + " on " + $Instance + " has been deleted"
                }

                #This is for if the user decides to not deleted the targeted job
                if($jobConfirm -eq "q")
                {
                    Write-Host "Job not deleted"
                }
            }

            if($job -like '*DatabaseIntegrityCheck*')
            {
                #This tells the user what job is about to be deleted and prompts them for conformaiton
                $jobConfirm = Read-host -Prompt ('The job: ' + $job.Name + ' Will be deleted. Press enter to continue or q to quit')
                
                if($jobConfirm = "")
                {
                    #The -SQLinstance filter is here in case the user is connected to multiple instances. If it causes problems just delete it
                    Remove-DbaAgentJob -SqlInstance $Instance -Job $job 
                    Write-host $job + " on " + $Instance + " has been deleted"
                }

                #This is for if the user decides to not deleted the targeted job
                if($jobConfirm -eq "q")
                {
                    Write-Host "Job not deleted"
                }
            }

            if($job -like '*IndexOptimizer*')
            {
                #This tells the user what job is about to be deleted and prompts them for conformaiton
                $jobConfirm = Read-host -Prompt ('The job: ' + $job.Name + ' Will be deleted. Press enter to continue or q to quit')
                
                if($jobConfirm = "")
                {
                    #The -SQLinstance filter is here in case the user is connected to multiple instances. If it causes problems just delete it
                    Remove-DbaAgentJob -SqlInstance $Instance -Job $job 
                    Write-host $job + " on " + $Instance + " has been deleted"
                }

                #This is for if the user decides to not deleted the targeted job
                if($jobConfirm -eq "q")
                {
                    Write-Host "Job not deleted"
                }
            }

            if($job -like '*Transaction*')
            {
                #This tells the user what job is about to be deleted and prompts them for conformaiton
                $jobConfirm = Read-host -Prompt ('The job: ' + $job.Name + ' Will be deleted. Press enter to continue or q to quit')
                
                if($jobConfirm = "")
                {
                    #The -SQLinstance filter is here in case the user is connected to multiple instances. If it causes problems just delete it
                    Remove-DbaAgentJob -SqlInstance $Instance -Job $job 
                    Write-host $job + " on " + $Instance + " has been deleted"
                }

                #This is for if the user decides to not deleted the targeted job
                if($jobConfirm -eq "q")
                {
                    Write-Host "Job not deleted"
                }
            }
       }
       ##################
       #This will double check that the user wants to delete the server and then delete it

       $databaseName = Read-host "Which database do you want to delete?"
       ##################
       #This step will double check that the correct database has been selected adn then takes it offline

       $DBcheck = Read-host -Prompt ($databaseName + ' is about to be deleted, do you want to proceed? (Yes or no)')
       if($DBCheck -eq 'yes' -or 'no')
       {
            if($DBCheck -eq 'yes')
            {
                $FinalCheck = Read-Host ('If you are sure that you want to delete ' + $databaseName + ' type I WANT TO DELETE THE DATABASE and then press enter')
                if($FinalCheck -eq 'I WANT TO DELETE THE DATABASE')
                {
                    #These next twqo lines gives the user one final chance to close powershell before the database is dropped
                    Write-Host "Deleting Database"
                    Start-Sleep -Seconds 2

                    #This drops the table
                    Remove-DbaAgDatabase -SqlInstance $Instance -Database $databaseName
                    Write-host ($databaseName + ' has been taken offline')
                }
            }

            if($DBCheck -eq 'no')
            {
                Write-Host "No was selected. No action will be taken"
                return
            }
       }

       else
       {
            Write-Host "Nerither yes no no was selected. No action will be taken"
            return
       }
       ##################
       #Now all that is left is to email the people that need to know. This will do that
       #These lines will get the user's full name and put it into a variable
       $dom = $env:USERDOMAIN
       $usr = $env:USERNAME
       $Fullname = ([adsi]"WinNT://$dom/$usr,user").fullname

       ##################
       #These next lines will fill in the reciever and the body of the message
       $ol = New-Object -ComObject outlook.Application

       #Create the email
       $mail = $ol.CreateItem(0)

       #This sets the recipients
       $mail.To = "Testrecp@gmail.com"
       $mail.CC = "TestCC@Gmail.com"

       #Optional, set the subject
       $mail.Subject = ($databaseName + ' has just been retired')

       #Optional, set the body
       $mail.Body = ('Dear person, ' + "`n" + $databaseName + ' has just been retired. If there are any wuestions or concerns please let me know. ' + "`n" + ' Regards,' + "`n" + "`n" + $Fullname)

       ##################
       #These lines will take all the data, put it into an email and bring it up for the user.
       #Get the new email object
       $inspector = $mail.GetInspector

       #Bring the message window to the front
       $inspector.Activate()
    }
    

    'q'
    {
        return
    }

}