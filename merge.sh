#!/bin/bash

read -p "Enter the directory to crawl: " directory
output_file="output.txt"

# Remove output file if it already exists
if [ -f "$output_file" ]; then
    rm "$output_file"
fi

# Recursive function
process_directory() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            process_directory "$file"
        elif [ -f "$file" ]; then
            echo "Processing $file"
            # Comment with file name
            echo -e "\n# File: $file\n" >> "$output_file"
            cat "$file" >> "$output_file"
        fi
    done
}

# Check if directory exists
if [ -d "$directory" ]; then
    # Process files in the given directory
    for file in "$directory"/*; do
        if [ -f "$file" ]; then
            echo "Processing $file"
            # Comment with file name
            echo -e "\n# File: $file\n" >> "$output_file"
            cat "$file" >> "$output_file"
        fi
    done
    # Start processing from the given directory
    process_directory "$directory"
else
    echo "Directory does not exist."
    exit 1
fi

echo "Done. Output in $output_file"
