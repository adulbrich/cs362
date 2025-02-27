#!/bin/bash

# Define array of lecture topics
practicalities=(
    "TODO"
)

# Loop through topics and generate PDFs
for topic in "${practicalities[@]}"; do
    # Get the next topic in the array for the --last parameter
    for ((i=0; i<${#practicalities[@]}; i++)); do
        if [[ "${practicalities[i]}" == "$topic" ]]; then
            next_topic="${practicalities[i+1]}"
            break
        fi
    done

    # Generate PDF
    if [[ -n "$next_topic" ]]; then
        npx starlight-to-pdf \
            "https://cs362.alexulbrich.com/practicalities/$topic" \
            --last "/practicalities/$next_topic" \
            --exclude "/practicalities/$next_topic" \
            --footer ./footer.html \
            --header ./header.html \
            --filename "practicalities-$topic" \
            --no-contents \
            --margins '2cm 1cm 2cm 1cm'
    else
        npx starlight-to-pdf \
            "https://cs362.alexulbrich.com/practicalities/$topic" \
            --last "/lectures/introduction" \
            --exclude "/lectures/introduction" \
            --footer ./footer.html \
            --header ./header.html \
            --filename "practicalities-$topic" \
            --no-contents \
            --margins '2cm 1cm 2cm 1cm'
    fi
done