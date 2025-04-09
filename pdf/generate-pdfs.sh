#!/bin/bash

lecture_topics=(
    "introduction"
    "git-and-github"
    "testing-fundamentals"
    "unit-testing"
    "test-driven-development"
)

assignments=(
    "git-and-github"
    "unit-tests"
    "integration-tests"
    "end-to-end-tests"
    "project"
)

# practicalities=(
#     "TODO"
# )

for topic in "${lecture_topics[@]}"; do
  node print.js "https://cs362.alexulbrich.com/lectures/$topic" "lecture-notes-$topic.pdf"
done

for topic in "${assignments[@]}"; do
  node print.js "https://cs362.alexulbrich.com/assignments/$topic" "assignment-$topic.pdf"
done

# for topic in "${practicalities[@]}"; do
#   node print.js "https://cs362.alexulbrich.com/practicalities/$topic" "practicalities-$topic.pdf"
# done