<#
.SYNOPSIS
    IPv6 source routing must be configured to the highest protection.

.NOTES
    Author          : Maffy Peterpaul
    LinkedIn        : linkedin.com/in/maffy-peterpaul
    GitHub          : github.com/Maffypeterp
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       :
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000020).ps1 
#>

# Run this script as Administrator

# Ensure DisableIpSourceRouting is set to 2
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$ValueName = "DisableIpSourceRouting"
$DesiredValue = 2

# Check if the registry key exists; create if missing
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Get current value
$currentValue = Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue

# If value is missing or not equal to desired, set it
if ($null -eq $currentValue.$ValueName -or $currentValue.$ValueName -ne $DesiredValue) {
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Registry value DisableIpSourceRouting set to $DesiredValue"
} else {
    Write-Output "Registry value DisableIpSourceRouting is already configured correctly"
}
