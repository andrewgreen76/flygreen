#!bin/bash

./a.out "John" & ./a.out "Paul" & ./a.out "George" & ./a.out "Ringo" &

# Ctrl+C           to kill the sole currently running process 
# pkill a.out      to kill all processes running the same executable under the same name 
