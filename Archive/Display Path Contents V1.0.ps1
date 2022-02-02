#This asks the user for a folder path and then displays all the files within along with the total size 
#Version 1.0
###############################################################
#Ask for folder path
$Usrimp = Read-Host -Prompt "Enter file path"

#Find any ` and replace them with '
if($Usrimp -contains "`"")
{
    $Usrimp -replace"`","""

}

#Get the items
$folder = Get-ChildItem $Usrimp

#This gets size of the folder and rounds it to two digits
$SizeToBeFormated = (Get-ChildItem $Usrimp -recurse  -ErrorAction SilentlyContinue | Measure-Object -property length -sum).sum / 1GB
$TotalSize  = [math]::Round($SizeToBeFormated,2)

#Write out each item 
Foreach ($item in $folder)
{
            Write-Host $item
}

write-Host  $TotalSize -ForegroundColor  yellow
Read-Host -Prompt "press any key to close"
