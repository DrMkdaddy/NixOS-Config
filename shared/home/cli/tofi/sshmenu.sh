#!/bin/env bash

# List the files in /home/noor/.ssh/, excluding the specified patterns, and pass the result to tofi
selected_key=$(
    for file in /home/noor/.ssh/*; do
        if [[ ! "$file" =~ \.pub$ && "$file" != /home/noor/.ssh/authorized_keys && "$file" != /home/noor/.ssh/known_hosts ]]; then
            echo "$file"
        fi
    done | tofi
)

# Check if a key was selected
if [ -n "$selected_key" ]; then
    # Run ssh-add with the selected key
    ssh-add "$selected_key"
else
    echo "No key selected."
fi

