<#
.SYNOPSIS
    Autoplay must be disabled for all drives.

.NOTES
    Author          : Maffy Peterpaul
    LinkedIn        : linkedin.com/in/maffy-peterpaul
    GitHub          : github.com/Maffypeterp
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000190

.TESTED ON
    Date(s) Tested  : 
    Tested By       :
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000190).ps1 
#>

# Run this script as Administrator

# Define the registry path and key
$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$regName = 'NoDriveTypeAutoRun'
$desiredValue = 255  # Decimal equivalent of 0xFF

# Create the registry key path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the value to disable autoplay on all drives
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Confirm the change
$currentValue = Get-ItemPropertyValue -Path $regPath -Name $regName
Write-Host "NoDriveTypeAutoRun is set to: $currentValue (255 = Autoplay disabled on all drives)"
