       #This will generate an email, sender, subject, and body. It will then open the email in outlook.
       #Now all that is left is to email the people that need to know. THis will do that
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
       $mail.Subject = (' a thing has just been retired')

       #Optional, set the body
       $mail.Body = ('Dear person, ' + "`n" + 'A thing' + ' has just been retired. If there are any wuestions or concerns please let me know. ' + "`n" + ' Regards,' + "`n" + "`n" + $Fullname)

       ##################
       #These lines will take all the data, put it into an email and bring it up for the user.
       #Get the new email object
       $inspector = $mail.GetInspector

       #Bring the message window to the front
       $inspector.Activate()