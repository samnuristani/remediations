 <#
.SYNOPSIS
    Remediates STIG ID: WN10-SO-000030.

.DESCRIPTION
    Ensures the setting "Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings" is Enabled.
    This allows detailed subcategory-level auditing via AuditPol.exe to take effect.

.NOTES
    STIG ID: WN10-SO-000030
    Registry Path: HKLM\System\CurrentControlSet\Control\Lsa
    Value Name: SCENoApplyLegacyAuditPolicy
    Value Data: 1 (enabled)
#>

Write-Host "Remediating STIG ID: WIN10-SO-000030..." -ForegroundColor Cyan

$regPath = "HKLM:\System\CurrentControlSet\Control\Lsa"
$valueName = "SCENoApplyLegacyAuditPolicy"
$desiredValue = 1

try {
    # Set the registry value
    if (!(Test-Path $regPath)) {
        Write-Host "Creating registry path: $regPath"
        New-Item -Path $regPath -Force | Out-Null
    }

    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

    # Verify the setting
    $currentValue = Get-ItemProperty -Path $regPath -Name $valueName
    if ($currentValue.$valueName -eq $desiredValue) {
        Write-Host "SUCCESS: Audit policy subcategory override is ENABLED." -ForegroundColor Green
    } else {
        Write-Host "ERROR: Failed to apply registry setting." -ForegroundColor Red
    }
}
catch {
    Write-Host "EXCEPTION: $_" -ForegroundColor Red
}
