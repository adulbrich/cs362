#!/usr/bin/env bash
set -e

# Base URL for pages
BASE="https://cs362.alexulbrich.com"

# Lecture topics
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

# Assignments
assignments=(
  "git-and-github"
  "unit-tests"
  "integration-tests"
  "end-to-end-tests"
  "project"
)

# Practicalities
practicalities=(
  "peer-evaluation"
)

echo "Generating individual PDFs with Node.js..."

for topic in "${lecture_topics[@]}"; do
  node print-clean.js "$BASE/lectures/$topic" "./temp/lecture-notes-$topic.pdf"
done

for topic in "${assignments[@]}"; do
  node print-clean.js "$BASE/assignments/$topic" "./temp/assignment-$topic.pdf"
done

for topic in "${practicalities[@]}"; do
  node print-clean.js "$BASE/practicalities/$topic" "./temp/practicalities-$topic.pdf"
done

echo "Combining PDFs with Node.js..."
node combine.js

echo "PDF generation complete!"
