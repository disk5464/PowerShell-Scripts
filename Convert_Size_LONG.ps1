#This will get a csv with file seizes that are in MB and turn them into GB
#Last modified 8/4/19
##############################
#This first part will get the file path and move to it
$filepath = Read-Host -Prompt "Where is the csv located?"
if ($filepath -eq "q")
{
    return
}

else
{
    cd $filepath
}
##############################
#This gets the fiulename, adds thje .csv extention, and then adds it to the file path
$FileName = Read-Host -Prompt "What is thje name of the csv file (Don't add .csv)"
$FileName = $FileName + ".csv"
$FilepathandName = $filepath + $FileName
##############################
#This imports the csv and displays the data

$CSVFIle = Import-Csv ./$FileName -Header Data_in_MB, Data_in_GB, combined

foreach ($Size in $CSVFIle)
{
    $Size.Data_in_GB = $Size.Data_inMB/1000
}

##############################
#THis takes the new values and outputs them to a csv in the current working directory called ConvertedSizes.csv
$CSVFIle | Export-Csv .\ConvertedSized.csv -NoTypeInformation
Write-host "Conversion complete"





