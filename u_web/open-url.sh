#!/bin/bash

# Check if a URL is provided as an argument
if [ $# -eq 0 ]; then
  echo "Please provide a URL as an argument."
  exit 1
fi

# Get the URL from the command-line argument
url=$1

# Open the URL in Mozilla Firefox
firefox "$url"
