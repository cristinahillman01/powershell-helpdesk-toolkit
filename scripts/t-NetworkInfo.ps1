<#
.SYNOPSIS
    Displays network configuration information.

.DESCRIPTION
    Shows active network adapters, IP addresses,
    default gateways, and DNS servers.

.NOTES
    Author: Your Name
    Version: 1.0
#>

Write-Host "========================================"
Write-Host "         NETWORK INFORMATION"
Write-Host "========================================"

$Configurations = Get-NetIPConfiguration |
    Where-Object { $_.IPv4Address -ne $null }

if (-not $Configurations) {
    Write-Host "No active IPv4 network configuration found."
    exit
}

foreach ($Config in $Configurations) {

    Write-Host "`nAdapter       : $($Config.InterfaceAlias)"
    Write-Host "IP Address    : $($Config.IPv4Address.IPAddress)"

    if ($Config.IPv4DefaultGateway) {
        Write-Host "Default Gateway: $($Config.IPv4DefaultGateway.NextHop)"
    }
    else {
        Write-Host "Default Gateway: Not configured"
    }

    if ($Config.DNSServer) {
        Write-Host "DNS Servers   : $($Config.DNSServer.ServerAddresses -join ', ')"
    }
    else {
        Write-Host "DNS Servers   : Not configured"
    }
}

Write-Host "`n========================================"
