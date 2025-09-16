<#
.SYNOPSIS
    Insecure logons to an SMB server must be disabled.

.NOTES
    Author          : Maffy Peterpaul
    LinkedIn        : linkedin.com/in/maffy-peterpaul
    GitHub          : github.com/Maffypeterp
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000040

.TESTED ON
    Date(s) Tested  : 
    Tested By       :
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000040).ps1 
#>

# Run this script as Administrator

# Registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"
$ValueName = "AllowInsecureGuestAuth"
$DesiredValue = 0

# Ensure the registry key exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Get current value
$currentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

# Check if value is missing or misconfigured
if ($null -eq $currentValue) {
    Write-Output "$ValueName is not configured. Setting to $DesiredValue."
    New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWORD -Value $DesiredValue -Force | Out-Null
} elseif ($currentValue -ne $DesiredValue) {
    Write-Output "$ValueName is misconfigured ($currentValue). Updating to $DesiredValue."
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue
} else {
    Write-Output "$ValueName is configured correctly ($currentValue)."
}
