 <#
.SYNOPSIS
    This PowerShell script enables failure auditing for "Other Logon/Logoff Events" 
    using auditpol.exe and ensures it's run with administrator privileges. 
    It helps meet Windows 10 STIG compliance (WIN10-AU-000565) by configuring and 
    verifying the required audit policy.

.NOTES
    Author          : Sam Nuristani
    GitHub          : https://github.com/samnuristani
    Date Created    : 2025-04-13
    Last Modified   : 2025-04-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000565

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000565.ps1 
#>

# Ensure script is run as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Please run this script as Administrator."
    exit
}

# Enable auditing for "Other Logon/Logoff Events" - Failure only
Write-Host "Enabling audit for 'Other Logon/Logoff Events' (Failure)..." -ForegroundColor Cyan

# Apply the setting using auditpol
auditpol.exe /set /subcategory:"Other Logon/Logoff Events" /failure:enable

# Confirm the change
Write-Host "`nCurrent Audit Policy:" -ForegroundColor Green
auditpol.exe /get /subcategory:"Other Logon/Logoff Events"
