Import-Module WebAdministration
 
$port = 8080
$zipSourcePath = "C:\BK_update12312025\Backend.zip"
$tempExtractPath = "C:\BK_update1231202511\"
 
# Get the site running on port 8080
$site = Get-IISSite | Where-Object { $_.Bindings.BindingInformation -like "*:8080:*" }
 
if ($null -eq $site) {
    Write-Error "No IIS site found running on port $port."
    exit 1
}
 
# Get the application pool name / path
$appPoolName = $site.Applications["/"].ApplicationPoolName
$physicalPath = $site.Applications["/"].VirtualDirectories["/"].PhysicalPath
 
if ([string]::IsNullOrWhiteSpace($appPoolName)) {
    Write-Error "No Application Pool found for the site on port $port."
    exit 1
}
 
Write-Output "Found Application Pool: $appPoolName"
Write-Output "Found Application Pool path : $physicalPath"
 
# Display current app pool info
Get-IISAppPool -Name $appPoolName
 
# Stop the application pool
Write-Output "Stopping Application Pool '$appPoolName'..."
Stop-WebAppPool -Name $appPoolName
 
# Wait a moment for the state to update
Start-Sleep -Seconds 2
 
# Check and display the status
$appPoolState = (Get-WebAppPoolState -Name $appPoolName).Value
Write-Output "Application Pool state: $appPoolState"
 
if ($appPoolState -ne "Stopped") {
    Write-Warning "Application Pool did not stop as expected. Current state: $appPoolState"
}
 
# Prepare extract directory
if (Test-Path $tempExtractPath) {
    Remove-Item $tempExtractPath -Recurse -Force
}
New-Item -ItemType Directory -Path $tempExtractPath | Out-Null
 
# Extract ZIP
Expand-Archive -Path $zipSourcePath -DestinationPath $tempExtractPath -Force
 
# Copy files
Copy-Item "$tempExtractPath\New folder\*" $physicalPath -Recurse -Force
 
# Start App Pool
Start-WebAppPool -Name $appPoolName
 
Write-Output "Deployment completed successfully"