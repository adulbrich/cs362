#!/bin/bash

# Define array of lecture topics
lecture_topics=(
    "development-environment"
    "git"
    "cpp-basics"
    "comments"
    "expressions"
    "operators"
    "variables"
    "constants"
    "type-casting"
    "shorthand-operators"
    "functions"
    "scope"
    "booleans"
    "if-statements"
    "loops"
    "characters"
    "strings"
    "string-functions"
    "arrays"
    "references"
    "error-handling"
)

# Loop through topics and generate PDFs
for topic in "${lecture_topics[@]}"; do
    # Get the next topic in the array for the --last parameter
    for ((i=0; i<${#lecture_topics[@]}; i++)); do
        if [[ "${lecture_topics[i]}" == "$topic" ]]; then
            next_topic="${lecture_topics[i+1]}"
            break
        fi
    done

    # Generate PDF
    if [[ -n "$next_topic" ]]; then
        npx starlight-to-pdf \
            "https://<TODO>/lectures/$topic" \
            --last "/lectures/$next_topic" \
            --exclude "/lectures/$next_topic" \
            --footer ./footer.html \
            --header ./header.html \
            --filename "lecture-notes-$topic" \
            --no-contents \
            --margins '2cm 1cm 2cm 1cm'
    else
        npx starlight-to-pdf \
            "https://<TODO>/lectures/$topic" \
            --last "/studios/introduction" \
            --exclude "/studios/introduction" \
            --footer ./footer.html \
            --header ./header.html \
            --filename "lecture-notes-$topic" \
            --no-contents \
            --margins '2cm 1cm 2cm 1cm'
    fi
done
