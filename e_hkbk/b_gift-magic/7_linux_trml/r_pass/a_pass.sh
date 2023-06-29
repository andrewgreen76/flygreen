#!/bin/bash

# Prompt for password
read -s -p "Enter password: " password
echo

# Verify the password
if [[ "$password" == "twc" ]]; then
    # Password is correct, execute the Python script
    python3 0.py
else
    # Password is incorrect
    echo "Incorrect password. Exiting."
fi
