#!/bin/bash

BIN_EXE="./a.out"
PONG_SRC="./src/pong.c"

gcc $PONG_SRC -lm

if [ -e $BIN_EXE ]; then
    read -n 1 -s -r -p "Press any key to continue..."
    $BIN_EXE
    emacs -nw $PONG_SRC
    rm $BIN_EXE
    clear
    ls -1
else
    echo "Executable \"\"\"./" + $BIN_EXE + "\"\"\" does NOT exist."
fi
