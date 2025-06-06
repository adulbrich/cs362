#!/bin/bash

lecture_topics=(
    "introduction"
    "git-and-github"
    "testing-fundamentals"
    "unit-testing"
    "test-driven-development"
    "ui-integration-testing"
    "test-doubles"
    "end-to-end-testing"
    "git-and-github-collaboration"
    "ci-cd"
    "coverage"
    "maintainability"
    "reliability-testing"
)

assignments=(
    "git-and-github"
    "unit-tests"
    "integration-tests"
    "end-to-end-tests"
    "project"
)

practicalities=(
    "peer-evaluation"
)

for topic in "${lecture_topics[@]}"; do
  node print.js "https://cs362.alexulbrich.com/lectures/$topic" "lecture-notes-$topic.pdf"
done

for topic in "${assignments[@]}"; do
  node print.js "https://cs362.alexulbrich.com/assignments/$topic" "assignment-$topic.pdf"
done

for topic in "${practicalities[@]}"; do
  node print.js "https://cs362.alexulbrich.com/practicalities/$topic" "practicalities-$topic.pdf"
done