# Automated Hardware-ID Onboarding for Windows Autopilot

![GitHub repo size](https://img.shields.io/github/repo-size/niklasrast/MEM-Intune-HWID-Importer)

![GitHub issues](https://img.shields.io/github/issues-raw/niklasrast/MEM-Intune-HWID-Importer)

![GitHub last commit](https://img.shields.io/github/last-commit/niklasrast/MEM-Intune-HWID-Importer)

Export the hardware id from your clients with the Install-Script -Name Get-WindowsAutoPilotInfo Module from PSGallery first.

This repo contains an powershell scripts to import Windows hardware ids (HWID) for the Windows Autopilot service. You can import many CSV files parallel.
Place all your HWID.CSV files in the folder NEW and run apimporter.ps1. After the import the CSV files will be moved to $PSSCRIPTROOT\Imported. Now you have to wait up to 15 minutes for the Windows Autopilot service to synchronise. After the synchronisation is finished you can reset your Windows clients and the Out-Of-Box-Experience (OOBE) will be controlled from Autopilot - ensure that your clients have a connection to the Internet.


## Import:
```powershell
PowerShell.exe -ExecutionPolicy Bypass -Command .\apimporter.ps1
```

## Logfiles:
The scripts create a logfile with the name of the .ps1 script in the folder $PSSCRIPTROOT\Logs.

## Requirements:
- PowerShell 5.0
- Windows 10
- Azure Active Directory
- Microsoft Intune Subscription
- Microsoft Intune License
- Administrative priviliges for Intune
- The script will install required powershell modules itself

# Feature requests
If you have an idea for a new feature in this repo, send me an issue with the subject Feature request and write your suggestion in the text. I will then check the feature and implement it if necessary.

Created by @niklasrast 