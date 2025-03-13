import sys

# Check the number of arguments
if len(sys.argv) != 2:
    print("Usage: python3 <arg0=script.py> <arg1>")
    sys.exit(1)


    
filename = sys.argv[1]  # Replace with the actual file path

with open(filename, "r") as file:
    for line in file:
        if line.startswith("URL="):
            url = line.strip()[4:]
            #if url.startswith("https"):
            print(url)
            break

