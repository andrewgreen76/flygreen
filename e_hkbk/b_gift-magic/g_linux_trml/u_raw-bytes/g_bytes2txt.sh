# Define a byte array as hexadecimal values
raw_bytes="48656C6C6F20576F726C64"  # This represents "Hello World" in hexadecimal

# Convert the hexadecimal string to binary and write it to a file
echo -n "$raw_bytes" | xxd -r -p > output.txt

# Read the raw bytes from the file using xxd
#xxd -p -c 256 output.txt
