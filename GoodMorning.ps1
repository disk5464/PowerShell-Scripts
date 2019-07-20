#This script opens pages and programs that are needed at the ebginning of the day
###############################
#kill any existing sessions of outlook becasue they become disconected after a while
Stop-Process -Name OUTLOOK
###############################
#This starts everything
Start-Process -FilePath "Outlook"
Start "https://Open.spotify.com"
###############################
#This shows a little notification
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
 
  if ($currDay -eq "Friday"){
  $balloon.BalloonTipText  = 'Good morning, Happy Friday.'}
  else{$balloon.BalloonTipText  = 'Good morning'}

  $balloon.BalloonTipTitle  = "Hello Nick" 
  $balloon.Visible  = $true 
  $balloon.ShowBalloonTip(5000) 

