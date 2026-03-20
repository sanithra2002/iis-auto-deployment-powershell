🔥 IIS Automated Deployment Tool (PowerShell)
📌 Overview

This PowerShell script automates the deployment of a web application to an IIS server. It identifies the target site using a specific port, safely stops the associated application pool, deploys updated files from a ZIP archive, and restarts the service.

This tool is designed to simplify and standardize web application deployments in Windows-based environments.

⚙️ Features

Automatically detects IIS site using port number

Identifies and manages associated Application Pool

Safely stops and starts the Application Pool

Extracts ZIP deployment package

Replaces existing application files

Provides deployment status output

🛠️ Requirements

Windows Server / Windows with IIS installed

PowerShell 5.1 or later

IIS Management Module (WebAdministration)

Administrator privileges

📂 Script Configuration

Update the following variables inside the script:

$port = 8080
$zipSourcePath = "C:\Path\To\Your\Backend.zip"
$tempExtractPath = "C:\Temp\ExtractPath\"
▶️ How It Works

Detects IIS site running on specified port

Retrieves Application Pool and physical path

Stops the Application Pool

Extracts ZIP package to temporary location

Copies updated files to IIS directory

Restarts the Application Pool

🚀 Usage

Run PowerShell as Administrator and execute:

.\IIS-Auto-Deployment.ps1
📊 Example Output
Found Application Pool: DefaultAppPool
Stopping Application Pool...
Application Pool state: Stopped
Deployment completed successfully
⚠️ Notes

Ensure the ZIP file structure is correct before deployment

Existing files will be overwritten

Temporary extraction folder will be deleted and recreated

💡 Future Improvements

Add logging system (log file generation)

Add rollback mechanism

Support multiple server deployments

Add configuration file (JSON-based deployment settings)
