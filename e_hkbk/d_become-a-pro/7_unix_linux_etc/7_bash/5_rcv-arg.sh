#!/bin/bash

# Access the first argument
argument=$1

# Check if an argument is provided
if [ -z "$argument" ]; then
  echo "No argument provided."
else
  echo "Argument provided: $argument"
fi
