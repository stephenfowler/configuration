#
# Download and reference NuGet packages
#
Write-BoxstarterMessage 'Download and reference NuGet packages'
$tempPackages = Join-Path $env:TEMP ((Get-Date).Ticks)
NuGet.exe install -x Newtonsoft.Json -OutputDirectory $tempPackages
Add-Type -Path (Join-Path $tempPackages 'Newtonsoft.Json\lib\net40\Newtonsoft.Json.dll')

#
# Install Visual Studio extensions
#
Write-BoxstarterMessage 'Install Visual Studio extensions'
$vsextensions = Get-Content ('./vs-extensions.json') -Raw | ConvertFrom-Json
$vsixInstaller = Join-Path $env:VS140COMNTOOLS '..\IDE\VSIXInstaller.exe'

Write-BoxstarterMessage $vsixInstaller

$downloads = $env:TEMP
$webclient = New-Object System.Net.WebClient
$vsextensions.PSObject.Properties | ForEach-Object {

    $downloadLocation = Join-Path -Path $downloads $_.Value.FileName
    If (Test-Path $downloadLocation)
    {
        $msg = 'Skipping download ' + $($_.Value.FileName)
        Write-BoxstarterMessage $msg
    }
    Else
    {
        $msg = 'Downloading ' + $($_.Value.FileName) + ' from ' + $($_.Value.DownloadUrl)
        Write-BoxstarterMessage $msg

        $webclient.DownloadFile($_.Value.DownloadUrl, $downloadLocation) 

        $msg = 'Saving download to ' + $($downloadLocation)
        Write-BoxstarterMessage $msg
    }

    $msg = 'Installing VS package ' + $($_.Value.Package)
    Write-BoxstarterMessage $msg

    & $vsixInstaller /q $downloadLocation
}
