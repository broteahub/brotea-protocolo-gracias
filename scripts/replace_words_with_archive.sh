#!/bin/bash

# Script to replace words in files in the ETH-Denver-2025/docs directory with archive backup
# Author: Cline AI Assistant

# Set default values
SOURCE_SINGULAR="acknowledgment"
TARGET_SINGULAR="appreciation"
SOURCE_PLURAL="acknowledgments"
TARGET_PLURAL="appreciations"
FILE_PATTERN="*.md"
RECURSIVE=false
DRY_RUN=false
VERBOSE=false

# Set the directory path relative to the script location
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOCS_DIR="$SCRIPT_DIR/../docs"

# Function to display help
show_help() {
    echo "Usage: $0 [options] [source_singular] [target_singular] [source_plural] [target_plural]"
    echo
    echo "Replace words in files within the docs directory with archive backup."
    echo
    echo "Options:"
    echo "  -h, --help                 Show this help message and exit"
    echo "  -d, --dry-run              Show what would be changed without making changes"
    echo "  -f, --file-pattern PATTERN Specify file pattern to search (default: *.md)"
    echo "  -r, --recursive            Search recursively in subdirectories"
    echo "  -v, --verbose              Enable verbose output"
    echo
    echo "Arguments:"
    echo "  source_singular            Word to replace (singular form)"
    echo "  target_singular            Replacement word (singular form)"
    echo "  source_plural              Word to replace (plural form)"
    echo "  target_plural              Replacement word (plural form)"
    echo
    echo "Examples:"
    echo "  $0                                              # Use defaults"
    echo "  $0 thanks gratitude \"thank you\" \"much appreciated\"  # Custom words"
    echo "  $0 -f \"*.txt\" word replacement words replacements    # Only in .txt files"
    echo "  $0 -r -v acknowledgment appreciation            # Recursive with verbose output"
    echo
    exit 0
}

# Parse command line options
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -f|--file-pattern)
            FILE_PATTERN="$2"
            shift 2
            ;;
        -r|--recursive)
            RECURSIVE=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            # Assume these are the positional parameters
            if [[ -z "$SOURCE_SINGULAR_ARG" ]]; then
                SOURCE_SINGULAR_ARG="$1"
                shift
            elif [[ -z "$TARGET_SINGULAR_ARG" ]]; then
                TARGET_SINGULAR_ARG="$1"
                shift
            elif [[ -z "$SOURCE_PLURAL_ARG" ]]; then
                SOURCE_PLURAL_ARG="$1"
                shift
            elif [[ -z "$TARGET_PLURAL_ARG" ]]; then
                TARGET_PLURAL_ARG="$1"
                shift
            else
                echo "Error: Too many arguments"
                show_help
            fi
            ;;
    esac
done

# Set positional parameters if provided
if [[ -n "$SOURCE_SINGULAR_ARG" ]]; then SOURCE_SINGULAR="$SOURCE_SINGULAR_ARG"; fi
if [[ -n "$TARGET_SINGULAR_ARG" ]]; then TARGET_SINGULAR="$TARGET_SINGULAR_ARG"; fi
if [[ -n "$SOURCE_PLURAL_ARG" ]]; then SOURCE_PLURAL="$SOURCE_PLURAL_ARG"; fi
if [[ -n "$TARGET_PLURAL_ARG" ]]; then TARGET_PLURAL="$TARGET_PLURAL_ARG"; fi

# Check if the docs directory exists
if [ ! -d "$DOCS_DIR" ]; then
    echo "Error: Directory $DOCS_DIR does not exist."
    exit 1
fi

# Get capitalized versions of the words
SOURCE_SINGULAR_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${SOURCE_SINGULAR:0:1})${SOURCE_SINGULAR:1}"
TARGET_SINGULAR_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${TARGET_SINGULAR:0:1})${TARGET_SINGULAR:1}"
SOURCE_PLURAL_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${SOURCE_PLURAL:0:1})${SOURCE_PLURAL:1}"
TARGET_PLURAL_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${TARGET_PLURAL:0:1})${TARGET_PLURAL:1}"

# Display configuration
echo "Starting word replacement process with archive backup..."
echo "Configuration:"
echo "  - Source directory: $DOCS_DIR"
echo "  - File pattern: $FILE_PATTERN"
echo "  - Recursive search: $RECURSIVE"
echo "  - Dry run: $DRY_RUN"
echo "  - Verbose output: $VERBOSE"
echo "Replacing:"
echo "  - '$SOURCE_SINGULAR' with '$TARGET_SINGULAR'"
echo "  - '$SOURCE_PLURAL' with '$TARGET_PLURAL'"
echo "  - Capitalized versions of both"

# Determine the find command based on recursion option
if [ "$RECURSIVE" = true ]; then
    FIND_CMD="find \"$DOCS_DIR\" -type f -name \"$FILE_PATTERN\""
else
    FIND_CMD="find \"$DOCS_DIR\" -maxdepth 1 -type f -name \"$FILE_PATTERN\""
fi

# Determine the sed command based on the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS requires an empty string after -i
    SED_CMD="sed -i ''"
else
    # Linux doesn't need the empty string
    SED_CMD="sed -i"
fi

# Create a backup archive if not in dry run mode
if [ "$DRY_RUN" = false ]; then
    # Create a backup directory
    BACKUP_DIR="$SCRIPT_DIR/backups"
    mkdir -p "$BACKUP_DIR"
    echo "Created backup directory: $BACKUP_DIR"
    
    # Get the current date and time for the backup filename
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="$BACKUP_DIR/docs_backup_$TIMESTAMP.tar.gz"
    
    echo "Creating backup archive of all matching files..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS (BSD find doesn't support -printf)
        (cd "$DOCS_DIR" && eval "find . -name \"$FILE_PATTERN\"" | sed 's|^\./||' | tar -czf "$BACKUP_FILE" -C "$DOCS_DIR" -T -)
    else
        # Linux (GNU find)
        eval "$FIND_CMD -printf \"%P\n\"" | tar -czf "$BACKUP_FILE" -C "$DOCS_DIR" -T -
    fi
    echo "Backup created at: $BACKUP_FILE"
fi

# Function to process a file
process_file() {
    local file="$1"
    
    if [ "$VERBOSE" = true ]; then
        echo "Processing file: $file"
    else
        echo -n "."
    fi
    
    # Function to show changes that would be made
    show_changes() {
        local pattern="$1"
        local replacement="$2"
        local file="$3"
        
        # Use grep to find matches and show context
        grep --color=always -n "$pattern" "$file" | while read -r line; do
            line_num=$(echo "$line" | cut -d: -f1)
            content=$(echo "$line" | cut -d: -f2-)
            replaced_content="${content//$pattern/$replacement}"
            echo "  Line $line_num:"
            echo "    Original: $content"
            echo "    Changed:  $replaced_content"
            echo
        done
    }
    
    # If in dry run mode, show what would be changed
    if [ "$DRY_RUN" = true ]; then
        echo "Changes that would be made to $file:"
        show_changes "$SOURCE_PLURAL" "$TARGET_PLURAL" "$file"
        show_changes "$SOURCE_PLURAL_CAP" "$TARGET_PLURAL_CAP" "$file"
        show_changes "$SOURCE_SINGULAR" "$TARGET_SINGULAR" "$file"
        show_changes "$SOURCE_SINGULAR_CAP" "$TARGET_SINGULAR_CAP" "$file"
    else
        # Perform the actual replacements
        # Replace plural forms
        $SED_CMD "s/$SOURCE_PLURAL/$TARGET_PLURAL/g" "$file"
        $SED_CMD "s/$SOURCE_PLURAL_CAP/$TARGET_PLURAL_CAP/g" "$file"
        
        # Replace singular forms
        $SED_CMD "s/$SOURCE_SINGULAR/$TARGET_SINGULAR/g" "$file"
        $SED_CMD "s/$SOURCE_SINGULAR_CAP/$TARGET_SINGULAR_CAP/g" "$file"
        
        if [ "$VERBOSE" = true ]; then
            echo "  Replacements completed"
        fi
    fi
}

# Process files
echo "Processing files..."
if [ "$VERBOSE" = false ] && [ "$DRY_RUN" = false ]; then
    echo -n "Processing"
fi

# Use eval to execute the find command and process each file
eval $FIND_CMD | while read -r file; do
    process_file "$file"
done

if [ "$VERBOSE" = false ] && [ "$DRY_RUN" = false ]; then
    echo " Done!"
fi

# Count processed files and occurrences
FILE_COUNT=$(eval $FIND_CMD | wc -l)

# Final message
if [ "$DRY_RUN" = true ]; then
    echo "Dry run completed. No changes were made."
else
    echo "All replacements completed successfully!"
    if [ -n "$BACKUP_FILE" ]; then
        echo "Backup archive created at: $BACKUP_FILE"
    fi
fi

# Show a summary of changes
echo -e "\nSummary:"
echo "Files processed: $FILE_COUNT"

if [ "$DRY_RUN" = false ] && [ -n "$BACKUP_FILE" ]; then
    echo "Backup location: $BACKUP_FILE"
fi

echo "Words replaced:"
echo "  - '$SOURCE_SINGULAR' → '$TARGET_SINGULAR'"
echo "  - '$SOURCE_PLURAL' → '$TARGET_PLURAL'"
echo "  - '$SOURCE_SINGULAR_CAP' → '$TARGET_SINGULAR_CAP'"
echo "  - '$SOURCE_PLURAL_CAP' → '$TARGET_PLURAL_CAP'"
