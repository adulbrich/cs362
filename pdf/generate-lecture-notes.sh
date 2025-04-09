#!/bin/bash

# Define array of lecture topics
lecture_topics=(
    "introduction"
    "git-and-github"
    "testing-fundamentals"
    "unit-testing"
    "test-driven-development"
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
            "https://cs362.alexulbrich.com/lectures/$topic" \
            --page-wait-until 'networkidle0' \
            --format "Letter" \
            --last "/lectures/$next_topic" \
            --exclude "/lectures/$next_topic" \
            --footer ./footer.html \
            --header ./header.html \
            --filename "lecture-notes-$topic" \
            --no-contents \
            --margins '2cm 1cm 2cm 1cm' \
            --print-bg
    else
        npx starlight-to-pdf \
            "https://cs362.alexulbrich.com/lectures/$topic" \
            --page-wait-until 'networkidle0' \
            --format "Letter" \
            --last "/assignments/introduction" \
            --exclude "/assignments/introduction" \
            --footer ./footer.html \
            --header ./header.html \
            --filename "lecture-notes-$topic" \
            --no-contents \
            --margins '2cm 1cm 2cm 1cm' \
            --print-bg
    fi
done
