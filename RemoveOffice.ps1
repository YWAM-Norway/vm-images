# Script to remove Office Click-to-run
# Erik Grøtnes 05.04.2026
#
# * Get link to Office Deployment Toolkit (ODT)
# * Download ODT
# * Create config file to remove all office apps
# * Run ODT with config
# * Delete temporary folder
#######################################################
$ErrorActionPreference = 'Stop'

$workDir   = 'C:\Temp\ODT'
$odtExe    = Join-Path $workDir 'officedeploymenttool.exe'
$setupExe  = Join-Path $workDir 'setup.exe'
$xmlPath   = Join-Path $workDir 'remove-office.xml'

New-Item -ItemType Directory -Path $workDir -Force | Out-Null

# Hent siste Office Deployment Toolkit link
$pageUrl = "https://www.microsoft.com/en-us/download/details.aspx?id=49117"

Write-Host "Fetching ODT download page..."
$response = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing

# Finn alle download.microsoft.com linker
$links = $response.Links | Where-Object {
    $_.href -like "*download.microsoft.com*" -and
    $_.href -like "*officedeploymenttool*.exe"
}

if (-not $links) {
    throw "Fant ikke ODT download link!"
}

# Velg første (vanligvis riktig)
$odtDownloadUrl = $links[0].href

Write-Host "Found ODT URL:"
Write-Host $odtDownloadUrl


Write-Host "Downloading ODT..."
Invoke-WebRequest -Uri $odtDownloadUrl -OutFile $odtExe

# Pakk ut ODT til arbeidsmappen
# Hvis denne parameterkombinasjonen ikke fungerer i ditt miljø,
# pakk ut ODT på forhånd og legg setup.exe sammen med scriptet.
Write-Host "Unpacking ODT..."
Start-Process -FilePath $odtExe -ArgumentList "/quiet /extract:$workDir" -Wait

# Lag uninstall-XML
Write-Host "Writing config file..."
@'
<Configuration>
  <Display Level="None" AcceptEULA="TRUE" />
  <Property Name="FORCEAPPSHUTDOWN" Value="TRUE" />
  <Remove All="TRUE" />
</Configuration>
'@ | Set-Content -Path $xmlPath -Encoding UTF8

# Kjør uninstall
Write-Host "Running uninstall..."
Start-Process -FilePath $setupExe -ArgumentList "/configure `"$xmlPath`"" -Wait -NoNewWindow

Write-Host "Cleaning up..."
Remove-Item -Path $workDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Done."
