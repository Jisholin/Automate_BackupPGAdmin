# -NoProfile -ExecutionPolicy Unrestricted -NonInteractive -File "D:\DEVELOPMENT BACKUPS\PowerShell - PG_Backup.ps1"

# Set the password for PostgreSQL
$env:PGPASSWORD = "50d3x0"

# Define the path to pg_dump and the base backup folder location
$pgDumpPath = "C:\Program Files\PostgreSQL\17\bin\pg_dump.exe"
$baseBackupFolder = "C:\DEVELOPMENT-BACKUP" 

# Get the current date and time, formatted as YYYY-MM-DD_HHMMSS
$dateTime = Get-Date -Format "yyyy-MM-dd HHmm"
$folderDate = Get-Date -Format "yyyy-MM-dd"

# Define the backup folder with the date in the folder name
$backupFolder = "$baseBackupFolder\Traczo_Migration [$folderDate]"

# Ensure the backup folder exists
if (-not (Test-Path $backupFolder)) {
    New-Item -ItemType Directory -Path $backupFolder
}

# Define the PostgreSQL connection details
$dbHost = "103.91.187.114"  # Renamed variable to avoid conflict with $host
$port = 5432
$username = "icegen"

# Array of database names
$databases = @("TRACZO_TAWAM", "TRACZO_Integration", "icegen_logger")

# Loop through each database and run pg_dump
foreach ($dbname in $databases) {
    # Define the backup file path for each database
    $backupFilePath = "$backupFolder\$dbname" + "_$dateTime.backup"

    # Run the pg_dump command
    Write-Host "Backing up database: $dbname"
    & "$pgDumpPath" --host=$dbHost --port=$port --username=$username --dbname=$dbname --file=$backupFilePath --format=custom

    Write-Host "Backup completed for $dbname at: $backupFilePath"
}

# Remove the password environment variable after execution
Remove-Item Env:PGPASSWORD
