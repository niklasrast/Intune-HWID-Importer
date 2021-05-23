<#
    .SYNOPSIS 
    Automatic CSV Importer for new AutoPilot Devices 

    .DESCRIPTION
    Install:   PowerShell.exe -ExecutionPolicy Bypass -Command .\apimporter.ps1

    .ENVIRONMENT
    PowerShell 5.0

    .AUTHOR
    Niklas Rast
#>

$ErrorActionPreference="SilentlyContinue"
$logFile = ('{0}\Client_import_{1}.log' -f "${PSScriptRoot}\Logs", (Get-Date -Format "dd.MM.yyyy"))

Start-Transcript -path $logFile

#Switch to script folder
Set-Location ${PSScriptRoot}

#Check if folder Logs exists or create
if ($true -eq (Test-Path -Path "${PSScriptRoot}\Logs")){
    Write-Host "Log dir exists"
} else {
    New-Item -Path $PSScriptRoot -Name Logs -ItemType Directory -Force
    Write-Host -ForegroundColor "Created folder Logs, please retry."
    Exit
}

#Check if folder NEW exists or create
if ($true -eq (Test-Path -Path "${PSScriptRoot}\NEW")){
    Write-Host "NEW dir exists"
} else {
    New-Item -Path $PSScriptRoot -Name NEW -ItemType Directory -Force
    Write-Host -ForegroundColor "Created folder NEW, please add csv-files into and retry."
    Exit
}

#Check if folder Imported exists or create
if ($true -eq (Test-Path -Path "${PSScriptRoot}\Imported")) {
    Write-Host "Imported dir exists"
} else {
    New-Item -Path $PSScriptRoot -Name Imported -ItemType Directory -Force
    Write-Host -ForegroundColor "Created folder Imported, please retry."
    Exit
}

#Install Module AzureAD if not existing and import to session
If(Get-Module -ListAvailable -Name "AzureAD"){
    Write-Host -ForegroundColor Green 'AzureAD Module is installed'
    Import-Module AzureAD
}
else{
    Write-Host -ForegroundColor Yellow "Installing and Importing AzureAD Module"
    Install-Module AzureAD
    Import-Module AzureAD
}

#Install Module Microsoft.Graph.Intune if not existing and import to session
If(Get-Module -ListAvailable -Name "Microsoft.Graph.Intune"){
    Write-Host -ForegroundColor Green 'Microsoft.Graph.Intune Module is installed'
    Import-Module Microsoft.Graph.Intune
}
else{
    Write-Host -ForegroundColor Yellow "Installing and Importing Microsoft.Graph.Intune Module"
    Install-Module Microsoft.Graph.Intune
    Import-Module Microsoft.Graph.Intune
}

#Install Module WindowsAutoPilotIntune if not existing and import to session
If(Get-Module -ListAvailable -Name "WindowsAutoPilotIntune"){
    Write-Host -ForegroundColor Green 'WindowsAutoPilotIntune Module is installed'
    Import-Module WindowsAutoPilotIntune
}
else{
    Write-Host -ForegroundColor Yellow "Installing and Importing WindowsAutoPilotIntune Module"
    Install-Module WindowsAutoPilotIntune
    Import-Module WindowsAutoPilotIntune
}

#Connect to MS Graph API
Connect-MSGraph

#Get all csv files
$newclients = ((Get-ChildItem -Path ${PSScriptRoot}\NEW).FullName)

#Count csv files and inform admin about the number ob csv files in the new folder
#Write-Host -ForegroundColor Green "Found " $newclients.Length "Clients in NEW directory."

#Import all csv files through foreach loop
foreach ($client in $newclients) {
    Write-Host -ForegroundColor Yellow "Importing Client $client ..."
    Import-AutoPilotCSV -csvFile $client
    Move-Item -Path $client -Destination "${PSScriptRoot}\Imported" -Force
}

Stop-Transcript