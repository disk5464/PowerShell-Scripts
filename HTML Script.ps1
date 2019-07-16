#This script takles a user's input and creates an HTML page based of the imputs. Make sure that there is no existing file before runniong
#This script really shouldn't exist. It takes more time to write the script than to just write the HTML
#Last modified 7/9/19
########################################
Write-Host "=================================Welcome to the HTML page creator================================="
$imput = Read-Host "Enter 1 for <HTML>, 2 for <sub>, 3 for <a>, 4 for <input>, 5 for <address>, 6 for <h1>, 7 for <h2>"
########################################
$HTMLOne = ""
$HTMLTwo = ""
$HTMLThree = ""
$HTMLFour = ""
$HTMLFive = ""
$HTMLSix = ""
$HTMLSeven = ""
$HTMLBreak =  "<br>"
########################################
if ($imput -like '*1*')
{
    $HTMLOne = "<HTML> This is an HTML section </HTML>"
    Write-Host "Added an <HTML> Section"
}

if ($imput -like '*2*')
{
    $HTMLTwo = "<sub> This is a subscript section </sub>"
    Write-Host "Added a <sub> Section"
}

if ($imput -like '*3*')
{
    $HTMLThree = '<a href="https://www.w3schools.com">Visit W3Schools.com!</a>'
    Write-Host "Added an <a> Section"
}

if ($imput -like '*4*')
{
    $HTMLFour = 'First name: <input type="text" name="FirstName" value="Bob"> ' 
    Write-Host "Added an <Input> Section"
}

if ($imput -like '*5*')
{
    $HTMLFive = '<address>
                 Written by <a href="mailto:webmaster@example.com">Jon Doe</a>.<br> 
                 Visit us at:<br>
                 Example.com<br>
                 Box 564, Disneyland<br>
                 USA
                 </address>'
    Write-Host "Added an <address> Section"
}


if ($imput -like '*6*')
{
    $HTMLSix = '<h1> This is an h1 section </h1>'
    Write-Host "Added an <h1> Section"
}


if ($imput -like '*7*')
{
    $HTMLSeven = '<h2> This is an h2 section </h2>'
    Write-Host "Added an <h2> Section"
}
########################################
$finalHTML = $HTMLOne + $HTMLBreak + $HTMLTwo + $HTMLBreak +  $HTMLThree + $HTMLBreak +$HTMLFour + $HTMLBreak + $HTMLFive + $HTMLBreak + $HTMLSix + $HTMLBreak + $HTMLSeven 
Set-Content -Path C:\Temp\HTMLOutput.html $finalHTML
