 <#
.SYNOPSIS
    Remediates STIG ID: WN10-AU-000560.

.NOTEs
.NOTES
    Author          : Sam Nuristani
    GitHub          : https://github.com/samnuristani
    Date Created    : 2025-04-15
    Last Modified   : 2025-04-15
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000560

.DESCRIPTION
    Configures auditing for "Other Logon/Logoff Events" to audit both Success and Failure.
    Verifies the setting and reports compliance status.
#>

function Set-AuditPolicyStrict {
    param (
        [string]$Subcategory
    )

    Write-Host "`nConfiguring audit policy for '$Subcategory'..." -ForegroundColor Cyan

    try {
        # Enable Success and Failure auditing
        AuditPol.exe /set /subcategory:"$Subcategory" /success:enable /failure:enable | Out-Null
        Start-Sleep -Seconds 1

        # Verify compliance
        $status = AuditPol.exe /get /subcategory:"$Subcategory"
        if ($status -match "Success\s+Failure") {
            Write-Host "✅ COMPLIANT: '$Subcategory' is set to 'Success and Failure'." -ForegroundColor Green
        }
        else {
            Write-Host "❌ NON-COMPLIANT: '$Subcategory' is not fully enabled." -ForegroundColor Red
            Write-Host "   Current setting: $($status.Trim())" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "❌ ERROR applying audit policy: $_" -ForegroundColor Red
    }
}

# Run remediation for this specific STIG
Set-AuditPolicyStrict -Subcategory "Other Logon/Logoff Events"
 
