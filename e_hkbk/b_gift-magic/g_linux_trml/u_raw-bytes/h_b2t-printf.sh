# Define raw bytes as a sequence of decimal values (example: "72 101 108 108 111 32 87 111 114 108 100")
raw_bytes="72 101 108 108 111 32 87 111 114 108 100"

# Convert the decimal values to characters and write to a file
printf "$(printf '\\x%x ' $raw_bytes)" > n_output.txt
