#!/bin/bash

# Validate that two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <filename> <extension>"
    exit 1
fi

# Validate that the file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

# Validate that the extension does not contain invalid characters
if [[ "$2" =~ [^a-zA-Z0-9._-] ]]; then
    echo "Error: Extension '$2' contains invalid characters."
    exit 1
fi

mv $1 $1$2