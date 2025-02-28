#!/bin/bash

# Script to replace words in all files in the ETH-Denver-2025/docs directory
# Usage: ./replace_words.sh [source_singular] [target_singular] [source_plural] [target_plural]
# Example: ./replace_words.sh acknowledgment appreciation acknowledgments appreciations

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

echo "Starting replacement process..."
echo "Replacing:"
echo "  - '$SOURCE_SINGULAR' with '$TARGET_SINGULAR'"
echo "  - '$SOURCE_PLURAL' with '$TARGET_PLURAL'"
echo "  - Capitalized versions of both"

# Loop through all files in the docs directory
for file in "$DOCS_DIR"/*.md; do
    if [ -f "$file" ]; then
        echo "Processing file: $file"
        
        # Create a backup of the original file
        cp "$file" "${file}.bak"
        
        # Get capitalized versions of the words
        SOURCE_SINGULAR_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${SOURCE_SINGULAR:0:1})${SOURCE_SINGULAR:1}"
        TARGET_SINGULAR_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${TARGET_SINGULAR:0:1})${TARGET_SINGULAR:1}"
        SOURCE_PLURAL_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${SOURCE_PLURAL:0:1})${SOURCE_PLURAL:1}"
        TARGET_PLURAL_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${TARGET_PLURAL:0:1})${TARGET_PLURAL:1}"
        
        # Check if we're on macOS or Linux and use appropriate sed syntax
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            # Replace plural forms
            sed -i '' "s/$SOURCE_PLURAL/$TARGET_PLURAL/g" "$file"
            sed -i '' "s/$SOURCE_PLURAL_CAP/$TARGET_PLURAL_CAP/g" "$file"
            
            # Replace singular forms
            sed -i '' "s/$SOURCE_SINGULAR/$TARGET_SINGULAR/g" "$file"
            sed -i '' "s/$SOURCE_SINGULAR_CAP/$TARGET_SINGULAR_CAP/g" "$file"
        else
            # Linux
            # Replace plural forms
            sed -i "s/$SOURCE_PLURAL/$TARGET_PLURAL/g" "$file"
            sed -i "s/$SOURCE_PLURAL_CAP/$TARGET_PLURAL_CAP/g" "$file"
            
            # Replace singular forms
            sed -i "s/$SOURCE_SINGULAR/$TARGET_SINGULAR/g" "$file"
            sed -i "s/$SOURCE_SINGULAR_CAP/$TARGET_SINGULAR_CAP/g" "$file"
        fi
        
        echo "Replacement completed for $file"
    fi
done

echo "All replacements completed successfully!"
echo "Backup files with .bak extension have been created."
