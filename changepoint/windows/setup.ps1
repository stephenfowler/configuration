#-----------------------------------------------------
#-- Disable shutdown tracker
Invoke-Expression (Join-Path $PSScriptRoot .\disable-windows-shutdown-event-tracker.ps1)


#-----------------------------------------------------
#-- Import the boxstarter hook
cinst -y boxstarter
Import-Module $env:AppData\Boxstarter\Boxstarter.Chocolatey -DisableNameChecking
#-- Start the Chocolatey package install


#-----------------------------------------------------
#-- win config
Set-WindowsExplorerOptions -DisableShowHiddenFilesFoldersDrives -DisableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Disable-InternetExplorerESC
Enable-RemoteDesktop
Disable-UAC
Set-TaskbarOptions -Size Small


#-----------------------------------------------------
#-- utilities
cinst -y curl
cinst -y ie11
cinst -y sysinternals
cinst -y greenshot
cinst -y vim
cinst -y debugview

#-----------------------------------------------------
#-- dev tools
cinst -y gitextensions
cinst -y markdownpad2
cinst -y fiddler4
cinst -y linqpad4
cinst -y nuget.commandline
cinst -y nugetpackageexplorer
cinst -y sublimetext3.app
cinst -y kdiff3
cinst -y nodejs


#-----------------------------------------------------
#-- install visual studio extensions
Invoke-Expression (Join-Path $PSScriptRoot '.\vs-extensions.ps1')


#-----------------------------------------------------
#-- Ensure configuration repository
If (!(Test-Path c:\src\configuration))
{
    git clone git@github.com:dachew/configuration.git c:\src\configuration
}


#-----------------------------------------------------
#-- Install sublime text packages and user settings
If (!(Test-Path "c:\Users\Administrator\AppData\Roaming\Sublime Text 3\Packages\User\README.md"))
{
    Remove-Item "c:\Users\Administrator\AppData\Roaming\Sublime Text 3\Packages\User" -recurse 
    cmd /c "C:\opscode\chef\embedded\bin\ln.exe" -s "C:\hosthome\src\configuration\sublime-text" "C:\Users\Administrator\AppData\Roaming\Sublime Text 3\Packages\User"
}


#-----------------------------------------------------
#-- Install configuration files
If (!(Test-Path $Env:UserProfile\.bashrc))
{
    Copy-Item c:\src\configuration\changepoint\windows\.bashrc $Env:UserProfile\.bashrc
}
If (!(Test-Path $Env:UserProfile\.gitconfig))
{
    Copy-Item c:\src\configuration\changepoint\windows\.gitconfig $Env:UserProfile\.gitconfig
}
If (!(Test-Path $Env:UserProfile\.sshagent.sh))
{
    Copy-Item c:\src\configuration\changepoint\windows\.sshagent.sh $Env:UserProfile\.sshagent.sh
}
