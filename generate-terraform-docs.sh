#!/bin/bash

root="$(pwd)"

# Find directories, excluding 'examples' completely
find "$root" -type d \( -name examples -prune \) -o -type d -print0 |
while IFS= read -r -d '' module; do
    terraform_file="$module/main.tf"

    if [[ -f "$terraform_file" ]]; then
        echo "****************************************"
        echo "generating terraform-docs for: $module"
        terraform-docs "$module"
        echo ""
    fi
done
