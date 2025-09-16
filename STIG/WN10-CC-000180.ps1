<#
.SYNOPSIS
    Autoplay must be turned off for non-volume devices.

.NOTES
    Author          : Maffy Peterpaul
    LinkedIn        : linkedin.com/in/maffy-peterpaul
    GitHub          : github.com/Maffypeterp
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000180

.TESTED ON
    Date(s) Tested  : 
    Tested By       :
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000180).ps1 
#>

# Run this script as Administrator

# Registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$ValueName = "NoAutoplayfornonVolume"
$DesiredValue = 1

# Ensure the registry key exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Get current value
$currentValue = Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue

# Set value if missing or incorrect
if ($null -eq $currentValue.$ValueName -or $currentValue.$ValueName -ne $DesiredValue) {
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Registry value $ValueName set to $DesiredValue"
} else {
    Write-Output "$ValueName is already configured correctly"
}
