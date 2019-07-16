$List_of_names = Import-Csv -Path 'C:\Users\Administrator\Desktop\CSV FIST AND LAST.csv' -Header first,last,first_and_last,email,display_name,user_name
 $num_of_users = 0
 foreach($name in $List_of_names)
 {
    New-ADuser -GivenName $name.first -Surname $name.last -Name $name.display_name -EmailAddress $name.email -SamAccountName $name.user_name
    $num_of_users = $num_of_users + 1
    Write-Host $name.first_and_last "Was created"
 }

 Write-host "Number of users created" $num_of_users