<#
.SYNOPSIS
    The network selection user interface (UI) must not be displayed on the logon screen.

.NOTES
    Author          : Maffy Peterpaul
    LinkedIn        : linkedin.com/in/maffy-peterpaul
    GitHub          : github.com/Maffypeterp
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000120

.TESTED ON
    Date(s) Tested  : 
    Tested By       :
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000120).ps1 
#>

# Run this script as Administrator

# Ensure DontDisplayNetworkSelectionUI is set to 1
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$ValueName = "DontDisplayNetworkSelectionUI"
$DesiredValue = 1

# Check if the registry key exists; create if missing
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Get current value
$currentValue = Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue

# If value is missing or not equal to desired, set it
if ($null -eq $currentValue.$ValueName -or $currentValue.$ValueName -ne $DesiredValue) {
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Registry value DontDisplayNetworkSelectionUI set to $DesiredValue"
} else {
    Write-Output "Registry value DontDisplayNetworkSelectionUI is already configured correctly"
}
