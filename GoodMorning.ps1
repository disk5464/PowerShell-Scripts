#This script opens pages and programs that are needed at the bginning of the day
#Last modified 8/4/19
###############################
#kill any existing sessions of outlook becasue they become disconected after a while
Stop-Process -Name OUTLOOK
Stop-Process -Name Teams
###############################
#This starts everything and sets some variables

$UserName = $env:USERNAME
$TeamsPath = "C:\Users\" + $UserName + "\AppData\Local\Microsoft\Teams\current\Teams.exe"

Start-Process -FilePath "Outlook"
Start-Process -FilePath $TeamsPath -WindowStyle Minimized
Start "https://Open.spotify.com"
###############################
#This shows a nice little good morning notification bassed off the day and a random number
$MessageNumber = Get-Random -Maximum 4 -Minimum 1

if($MessageNumber -eq "1")
{
    $test = "Good Morning"
}

if($MessageNumber -eq "2")
{
    $test = "Lovely weather were having today?"
}

if($MessageNumber -eq "3")
{
    $test = "Did you see that ludicrous display last night?"
}

if($MessageNumber -eq "4")
{
    $test = "If big brother is always watching, who's watching big brother?"
}
###############################
#Taken from https://mcpmag.com/articles/2017/09/07/creating-a-balloon-tip-notification-using-powershell.aspx
$currDay = Get-date -Format dddd
Add-Type -AssemblyName system.windows.forms
$global:balloon = New-Object System.Windows.Forms.NotifyIcon 
Get-Member -InputObject  $Global:balloon 
[void](Register-ObjectEvent  -InputObject $balloon  -EventName MouseDoubleClick  -SourceIdentifier IconClicked  -Action {

  #Perform  cleanup actions on balloon tip

  $global:balloon.dispose()

  Unregister-Event  -SourceIdentifier IconClicked

  Remove-Job -Name IconClicked

  Remove-Variable  -Name balloon  -Scope Global

})
$path = (Get-Process -id $pid).Path

  $balloon.Icon  = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
  [System.Windows.Forms.ToolTipIcon] | Get-Member -Static -Type Property
  $balloon.BalloonTipIcon  = [System.Windows.Forms.ToolTipIcon]::Info
 
  if ($currDay -eq "Friday")
  {
    $balloon.BalloonTipText  = 'Good morning, Happy Friday.'
  }
  
  else
  {
    $balloon.BalloonTipText  = ($test)
  }

  $balloon.BalloonTipTitle  = "Hello There!" 
  $balloon.Visible  = $true 
  $balloon.ShowBalloonTip(5000) 

