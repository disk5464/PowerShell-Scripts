#This script will install the SQLServer module from the PSgallery. It first fixes the PSgallery since Vanguard uses a proxy and by default blocks the gallery
#This was mainly taken from https://spaghettidba.com/2017/12/19/recovering-the-psgallery-repository-behind-a-corporate-proxy/
#You also might have to run this as admin
#Last updates 6/29/19
################################################
################################################
#This first part will astablish some variables 
$usrName = $env:USERNAME
$ProfilePath = "C:\Users\" + $usrName + "\Documents\WindowsPowerShell"
################################################
#These next lines will open notepad, add the required lines, and save it.
notepad $PROFILE
Add-Content $ProfilePath "'n[system.net.webrequest]::defaultwebproxy = new-object system.net.webproxy('http://YourProxyHostNameGoesHere:ProxyPortGoesHere')"
Add-Content $ProfilePath "'n[system.net.webrequest]::defaultwebproxy.credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials [system.net.webrequest]::defaultwebproxy.BypassProxyOnLocal = $true "
################################################
#The first line will display the current repositiories that are installed. At this point PSgallery should be installed. The next two lines updates NuGet and installs the SQL cmdlet
Register-PSRepository -Default
Install-PackageProvider -scope CurrentUser -Name NuGet -RequiredVersion 2.8.5.201 -Force
Install-Module -Name SqlServer -Scope CurrentUser
Install-Module -Name DBATools -Scope CurrentUser
################################################
echo "If all has gone correctly NuGet Should have been updated, SQLServer is installed, and the galery should be fixed"



