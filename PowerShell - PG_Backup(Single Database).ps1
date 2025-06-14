# -NoProfile -ExecutionPolicy Unrestricted -NonInteractive -File "D:\DEVELOPMENT BACKUPS\PowerShell - PG_Backup.ps1"

# Set the password for PostgreSQL
$env:PGPASSWORD = "50d3x0"

# Define the path to pg_dump and the backup file location
$pgDumpPath = "C:\Program Files\PostgreSQL\17\bin\pg_dump.exe"

# Get the current date and time, formatted as YYYY-MM-DD_HHMMSS
$dateTime = Get-Date -Format "yyyy-MM-dd_HHmmss"

# Define the backup file path with the current date and time
$backupFilePath = "C:\PG_BACKUPS\Traczo_Tawam_Backup_$dateTime.backup"

# Define the PostgreSQL connection details
$dbHost = "103.91.187.114"  # Renamed variable to avoid conflict with $host
$port = 5432
$username = "icegen"
$dbname = "TRACZO_TAWAM"

# Run the pg_dump command
& "$pgDumpPath" --host=$dbHost --port=$port --username=$username --dbname=$dbname --file=$backupFilePath --format=custom

# Remove the password environment variable after execution
Remove-Item Env:PGPASSWORD
