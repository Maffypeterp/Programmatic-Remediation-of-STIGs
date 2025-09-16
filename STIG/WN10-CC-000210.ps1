<#
.SYNOPSIS
    The Windows Defender SmartScreen for Explorer must be enabled.

.NOTES
    Author          : Maffy Peterpaul
    LinkedIn        : linkedin.com/in/maffy-peterpaul
    GitHub          : github.com/Maffypeterp
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000210

.TESTED ON
    Date(s) Tested  : 
    Tested By       :
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000210).ps1 
#>

# Run this script as Administrator

# Registry paths and values
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$EnableSmartScreenName = "EnableSmartScreen"
$ShellSmartScreenLevelName = "ShellSmartScreenLevel"

# Detect Windows version for LTSB specifics
$OSVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId

# Set defaults based on version
switch ($OSVersion) {
    "1607" { $EnableSmartScreenValue = 1 }  # v1607 LTSB
    "1507" { $EnableSmartScreenValue = 2 }  # v1507 LTSB
    default { 
        $EnableSmartScreenValue = 1        # Standard/other Windows versions
        $ShellSmartScreenLevelValue = "Block"
    }
}

# Ensure the registry key exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Configure EnableSmartScreen
$currentEnable = Get-ItemProperty -Path $RegPath -Name $EnableSmartScreenName -ErrorAction SilentlyContinue
if ($null -eq $currentEnable.$EnableSmartScreenName -or $currentEnable.$EnableSmartScreenName -ne $EnableSmartScreenValue) {
    Set-ItemProperty -Path $RegPath -Name $EnableSmartScreenName -Value $EnableSmartScreenValue -Type DWord
    Write-Output "Registry value EnableSmartScreen set to $EnableSmartScreenValue"
} else {
    Write-Output "EnableSmartScreen is already configured correctly"
}

# Configure ShellSmartScreenLevel if applicable
if ($ShellSmartScreenLevelValue) {
    $currentShell = Get-ItemProperty -Path $RegPath -Name $ShellSmartScreenLevelName -ErrorAction SilentlyContinue
    if ($null -eq $currentShell.$ShellSmartScreenLevelName -or $currentShell.$ShellSmartScreenLevelName -ne $ShellSmartScreenLevelValue) {
        Set-ItemProperty -Path $RegPath -Name $ShellSmartScreenLevelName -Value $ShellSmartScreenLevelValue -Type String
        Write-Output "Registry value ShellSmartScreenLevel set to $ShellSmartScreenLevelValue"
    } else {
        Write-Output "ShellSmartScreenLevel is already configured correctly"
    }
}
