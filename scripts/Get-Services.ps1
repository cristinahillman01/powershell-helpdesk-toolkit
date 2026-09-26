# ============================================
# Get-Services.ps1
# Purpose: Check Windows services
# ============================================

# Allow the user to provide a service name
param(
    [string]$Name = "*"
)

# Display the script heading
Write-Host "===================================="
Write-Host "          SERVICE CHECK"
Write-Host "===================================="

# Try to find the requested service
try {
    $Services = Get-Service -Name $Name -ErrorAction Stop
}
catch {
    Write-Host "Service could not be found."
    exit
}

# Display information about the service
Write-Host ""
Write-Host "Service: $($Services.Name)"
Write-Host "Display Name: $($Services.DisplayName)"
Write-Host "Status: $($Services.Status)"

# Check whether the service is running
if ($Services.Status -eq "Running") {
    Write-Host "Health: PASS - Service is running."
}
else {
    Write-Host "Health: WARNING - Service is not running."
}

# Display completion message
Write-Host ""
Write-Host "===================================="
Write-Host "          CHECK COMPLETE"
Write-Host "===================================="
