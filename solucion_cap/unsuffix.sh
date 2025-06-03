#!/bin/bash

# Validate that one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <filename>"
    exit 1
fi

# Validate that the file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

# Validate that the file has an extension
if [[ "$1" != *.* ]]; then
    echo "Error: File '$1' does not have an extension."
    exit 1
fi

# Remove the extension from the filename
new_name="${1%.*}"

# Check if a file with the new name already exists
if [ -e "$new_name" ]; then
    echo "Error: A file named '$new_name' already exists."
    exit 1
fi

mv "$1" "$new_name"
echo "Extension removed. New file name: '$new_name'"