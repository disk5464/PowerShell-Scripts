#THis script will imprt a bunch of functions It should be stored in the same location as the functions. 
#To add more functions add them to the $TestFiles array
#Last modified 8/4/19
##############################
#Since the script moves powershell to where the modules are this will allow us to return to the starting location at the end of it
$Beginninglocation = Get-Location
##############################
#This just welcomes the user
Write-Host "=================== Import Functions ======================"
##############################
#This will set up some variables along with an array with the names of the funtions we are going to import

$filepath = Read-Host -Prompt "Where are the functions located?"
If($filepath -eq "q")
{
    return
}

Else
{
    cd $filepath
}

$ModuleArray = @("\SearchGoogle.psm1")
##############################
#This will test to see if the module file is in the current directory and it it is it will be imported
for($i=0; $i -lt $ModuleArray.length; i++)
{
    try
    {
        $dot = "."
        $combined = $dot + $ModuleArray[$i]
        Import-Module $combined
    }   
    catch
    {
        Write-Host $ModuleArray[$i] + "could not be found. Make sure that Powershell is in the right directory and try again"
    }
}
##############################
#This tells the user the import has been completed and then moves them back to the orginal directory
Write-Host "Function import complete"
cd $Beginninglocation


