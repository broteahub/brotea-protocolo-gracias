#!/bin/bash

# Script to replace words in all files in the ETH-Denver-2025/docs directory using direct commands
# Usage: ./replace_words_cmd.sh [source_singular] [target_singular] [source_plural] [target_plural]
# Example: ./replace_words_cmd.sh acknowledgment appreciation acknowledgments appreciations

# Default values if not provided
SOURCE_SINGULAR=${1:-"acknowledgment"}
TARGET_SINGULAR=${2:-"appreciation"}
SOURCE_PLURAL=${3:-"acknowledgments"}
TARGET_PLURAL=${4:-"appreciations"}

# Set the directory path relative to the script location
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOCS_DIR="$SCRIPT_DIR/../docs"

# Check if the docs directory exists
if [ ! -d "$DOCS_DIR" ]; then
    echo "Error: Directory $DOCS_DIR does not exist."
    exit 1
fi

echo "Starting replacement process using direct commands..."
echo "Replacing:"
echo "  - '$SOURCE_SINGULAR' with '$TARGET_SINGULAR'"
echo "  - '$SOURCE_PLURAL' with '$TARGET_PLURAL'"
echo "  - Capitalized versions of both"

# Get capitalized versions of the words
SOURCE_SINGULAR_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${SOURCE_SINGULAR:0:1})${SOURCE_SINGULAR:1}"
TARGET_SINGULAR_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${TARGET_SINGULAR:0:1})${TARGET_SINGULAR:1}"
SOURCE_PLURAL_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${SOURCE_PLURAL:0:1})${SOURCE_PLURAL:1}"
TARGET_PLURAL_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${TARGET_PLURAL:0:1})${TARGET_PLURAL:1}"

# Determine the sed command based on the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS requires an empty string after -i
    SED_CMD="sed -i ''"
else
    # Linux doesn't need the empty string
    SED_CMD="sed -i"
fi

# Create a backup directory
BACKUP_DIR="$SCRIPT_DIR/backups"
mkdir -p "$BACKUP_DIR"
echo "Created backup directory: $BACKUP_DIR"

# Get the current date and time for the backup filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/docs_backup_$TIMESTAMP.tar.gz"

# Create a backup of all markdown files
echo "Creating backup of all markdown files..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS (BSD find doesn't support -printf)
    cd "$DOCS_DIR" && tar -czf "$BACKUP_FILE" $(find . -name "*.md" | sed 's|^\./||')
else
    # Linux (GNU find)
    tar -czf "$BACKUP_FILE" -C "$DOCS_DIR" $(find "$DOCS_DIR" -name "*.md" -printf "%P\n")
fi
echo "Backup created at: $BACKUP_FILE"

# Find all markdown files and perform replacements
echo "Performing replacements on all markdown files..."
find "$DOCS_DIR" -name "*.md" | while read file; do
    echo "Processing file: $file"
    
    # Replace plural forms
    $SED_CMD "s/$SOURCE_PLURAL/$TARGET_PLURAL/g" "$file"
    $SED_CMD "s/$SOURCE_PLURAL_CAP/$TARGET_PLURAL_CAP/g" "$file"
    
    # Replace singular forms
    $SED_CMD "s/$SOURCE_SINGULAR/$TARGET_SINGULAR/g" "$file"
    $SED_CMD "s/$SOURCE_SINGULAR_CAP/$TARGET_SINGULAR_CAP/g" "$file"
    
    echo "Replacement completed for $file"
done

echo "All replacements completed successfully!"
echo "Backup archive created at: $BACKUP_FILE"

# Show a summary of changes
echo -e "\nSummary of changes:"
echo "Files processed: $(find "$DOCS_DIR" -name "*.md" | wc -l)"
echo "Backup location: $BACKUP_FILE"
echo "Words replaced:"
echo "  - '$SOURCE_SINGULAR' → '$TARGET_SINGULAR'"
echo "  - '$SOURCE_PLURAL' → '$TARGET_PLURAL'"
echo "  - '$SOURCE_SINGULAR_CAP' → '$TARGET_SINGULAR_CAP'"
echo "  - '$SOURCE_PLURAL_CAP' → '$TARGET_PLURAL_CAP'"
