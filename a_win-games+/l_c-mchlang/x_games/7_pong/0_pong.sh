BIN_EXE="./bin/pong.bin"
PONG_SRC="./src/pong.c"

gcc -o $BIN_EXE $PONG_SRC 

if [ -e $BIN_EXE ]; then
    read -n 1 -s -r -p "Press any key to continue..."
    echo
    $BIN_EXE
    rm $BIN_EXE
    emacs -nw $PONG_SRC
    clear
    ls -1
else
    echo "Executable \"\"\"./" + $BIN_EXE + "\"\"\" was NOT generated."
fi
