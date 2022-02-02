#This asks the user for a folder path and then displays all the files within along with the total size 
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

#Create an array so we can add the items that we will send to the clipboard
$ItemArry = @()

#Write out each item 
Foreach ($item in $folder)
{
           if($item -like "*.torrent*")
           {
                #Take item and remove .torrent from the end
                $trimedItem = $item.ToString().TrimEnd(".torrent")
                Write-Host $trimedItem
                
                #add the item to the array
                $ItemArry += $trimedItem
           }
           else
           {
                Write-Host $item

                #Add the item to the array
                $ItemArry += $item
           }
}

#set the clipboard to the array
Set-Clipboard $ItemArry
Write-Host "Sent the content to the clipboard" -ForegroundColor Yellow

#Display the size of the folder and a read-host so PS dosen't auto close
write-Host  $TotalSize "GB" -ForegroundColor  yellow
Read-Host -Prompt "press any key to close"

