a=`cat l_auto_add.sh | head -6 | tail -1`
eval $a

#!/bin/bash

# File containing commands, one per line
file="commands.txt"

# Check if the file exists
if [ -e "$file" ]; then
  # Read each line from the file
  while read -r line; do
    # Run the line as a command using eval
    eval "$line"
  done < "$file"
else
  echo "File '$file' does not exist."
fi

