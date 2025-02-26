#!/bin/bash

BIN_EXE="./bin/pong.bin"
PONG_SRC="./src/pong.c"

make  #gcc -o $BIN_EXE $PONG_SRC -lm

if [ -e $BIN_EXE ]; then
    read -n 1 -s -r -p "Press any key to continue..."
    $BIN_EXE
    make clean
    emacs -nw $PONG_SRC
    clear
    ls -1
else
    echo "Executable \"\"\"./" + $BIN_EXE + "\"\"\" was NOT generated."
fi
