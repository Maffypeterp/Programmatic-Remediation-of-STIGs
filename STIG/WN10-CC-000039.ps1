<#
.SYNOPSIS
    "Run as a different user" must be removed from context menus.

.NOTES
    Author          : Maffy Peterpaul
    LinkedIn        : linkedin.com/in/maffy-peterpaul
    GitHub          : github.com/Maffypeterp
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000039

.TESTED ON
    Date(s) Tested  : 
    Tested By       :
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000039).ps1 
#>

# Run this script as Administrator

# Registry paths and value
$RegPaths = @(
    "HKLM:\SOFTWARE\Classes\batfile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\cmdfile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\exefile\shell\runasuser",
    "HKLM:\SOFTWARE\Classes\mscfile\shell\runasuser"
)
$ValueName = "SuppressionPolicy"
$DesiredValue = 0x00001000

foreach ($Path in $RegPaths) {
    # Ensure the registry key exists
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }

    # Get current value
    $currentValue = Get-ItemProperty -Path $Path -Name $ValueName -ErrorAction SilentlyContinue

    # Set value if missing or incorrect
    if ($null -eq $currentValue.$ValueName -or $currentValue.$ValueName -ne $DesiredValue) {
        Set-ItemProperty -Path $Path -Name $ValueName -Value $DesiredValue -Type DWord
        Write-Output "Registry value $ValueName set to $DesiredValue at $Path"
    } else {
        Write-Output "$ValueName is already configured correctly at $Path"
    }
}
