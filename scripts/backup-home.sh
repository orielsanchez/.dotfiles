#!/bin/bash

# Define the source and destination directories
SOURCE="/home/oriel"     # Change this to the directory you want to back up
DESTINATION="/mnt/backup"       # This is where the backups will go

# Create a timestamp for the backup
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')

# Create a backup directory with the timestamp
BACKUP_DIR="$DESTINATION/backup_$TIMESTAMP"
mkdir -p "$BACKUP_DIR"

EXCLUDE_FILE="/home/oriel/rsync-exclude.txt"
# Run rsync to back up the source directory

OPTIONS="-av --delete --exclude-from=$EXCLUDE_FILE --stats"

rsync $OPTIONS "$SOURCE" "$BACKUP_DIR"

# Optional: Remove backups older than 7 days (change as needed)
find "$DESTINATION" -type d -name "backup_*" -mtime +7 -exec rm -rf {} \;

echo "Backup completed at $TIMESTAMP"
