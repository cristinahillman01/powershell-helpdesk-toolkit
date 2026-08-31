# Get-SystemInfo.ps1
# This script collects basic information that may be useful when
# troubleshooting a Windows device in an IT support environment.

# Display a heading so the output is easy to read
Write-Host "=== System Information ===" -ForegroundColor Cyan
Write-Host ""

# Get information about the computer system, including
# the manufacturer, model and installed physical memory
$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem

# Get information about the installed Windows operating system
$operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem

# Display the computer name using a Windows environment variable
Write-Host "Computer Name: $env:COMPUTERNAME"

# Display the username of the currently logged-in user
Write-Host "Current User: $env:USERNAME"

# Display the name of the installed operating system
Write-Host "Operating System: $($operatingSystem.Caption)"

# Display the Windows version number
Write-Host "OS Version: $($operatingSystem.Version)"

# Display the computer manufacturer
Write-Host "Manufacturer: $($computerSystem.Manufacturer)"

# Display the computer model
Write-Host "Model: $($computerSystem.Model)"

# Convert RAM from bytes to gigabytes and round the result
# to two decimal places before displaying it
$ramGB = [math]::Round(
    $computerSystem.TotalPhysicalMemory / 1GB,
    2
)

Write-Host "Installed RAM: $ramGB GB"
