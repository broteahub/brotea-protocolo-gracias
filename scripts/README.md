# Word Replacement Scripts for ETH-Denver-2025 Project

This directory contains utility scripts for replacing words in the ETH-Denver-2025 project documentation.

## Available Scripts

### 1. `replace_words.sh`

This script replaces specified words in files within the `docs` directory, creating individual backups of each modified file.

#### Features:
- Parameterizable to replace any words, not just "acknowledgment/s" with "appreciation/s"
- Creates backups of original files with `.bak` extension
- Works on both macOS and Linux
- Uses the script's location to determine the docs directory path
- Handles both singular and plural forms with proper capitalization
- Supports dry-run mode to preview changes without making them
- Can search specific file types (not just .md files)
- Optional recursive search in subdirectories
- Verbose mode for detailed output
- Help option with usage information

#### Usage:
```bash
# Default usage (replaces acknowledgment/s with appreciation/s)
./replace_words.sh

# Show help and usage information
./replace_words.sh -h

# Custom usage with parameters
./replace_words.sh [options] [source_singular] [target_singular] [source_plural] [target_plural]

# Examples:
./replace_words.sh "thanks" "gratitude" "thank you" "much appreciated"
./replace_words.sh -d -v acknowledgment appreciation  # Dry run with verbose output
./replace_words.sh -f "*.txt" -r word replacement     # Search recursively in .txt files
```

### 2. `replace_words_with_archive.sh`

This script performs the same replacements as `replace_words.sh` but creates a single compressed backup archive of all files before making changes.

#### Features:
- Parameterizable to replace any words, not just "acknowledgment/s" with "appreciation/s"
- Creates a timestamped backup archive of all files before making changes
- Works on both macOS and Linux
- Provides a detailed summary of changes after completion
- Uses the script's location to determine the docs directory path
- Handles both singular and plural forms with proper capitalization
- Supports dry-run mode to preview changes without making them
- Can search specific file types (not just .md files)
- Optional recursive search in subdirectories
- Verbose mode for detailed output
- Help option with usage information

#### Usage:
```bash
# Default usage (replaces acknowledgment/s with appreciation/s)
./replace_words_with_archive.sh

# Show help and usage information
./replace_words_with_archive.sh -h

# Custom usage with parameters
./replace_words_with_archive.sh [options] [source_singular] [target_singular] [source_plural] [target_plural]

# Examples:
./replace_words_with_archive.sh "thanks" "gratitude" "thank you" "much appreciated"
./replace_words_with_archive.sh -d -v acknowledgment appreciation  # Dry run with verbose output
./replace_words_with_archive.sh -f "*.txt" -r word replacement     # Search recursively in .txt files
```

## Choosing Between Scripts

- Use `replace_words.sh` if you want individual backups of each file
- Use `replace_words_with_archive.sh` if you prefer a single compressed backup archive

Both scripts perform the same text replacements but differ in their backup strategy.

## Command Line Options

Both scripts support the following command line options:

| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message and exit |
| `-d, --dry-run` | Show what would be changed without making changes |
| `-f, --file-pattern PATTERN` | Specify file pattern to search (default: *.md) |
| `-r, --recursive` | Search recursively in subdirectories |
| `-v, --verbose` | Enable verbose output |

## Examples

### Basic Usage
```bash
./replace_words.sh
```

### Custom Word Replacement
```bash
./replace_words.sh "code" "script" "codes" "scripts"
```

### Dry Run with Verbose Output
```bash
./replace_words.sh -d -v
```

### Search in Text Files Only
```bash
./replace_words.sh -f "*.txt" word replacement
```

### Recursive Search
```bash
./replace_words_with_archive.sh -r acknowledgment appreciation
```
