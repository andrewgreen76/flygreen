BIN_EXE="./bin/pong.bin"
MAIN_SRC="./src/main.c"

gcc -o $BIN_EXE $MAIN_SRC 

if [ -e $BIN_EXE ]; then
    read -n 1 -s -r -p "Press any key to continue..."
    echo
    $BIN_EXE
    rm $BIN_EXE
    emacs -nw $MAIN_SRC
    clear
    ls -1
else
    echo "Executable \"\"\"./" + $BIN_EXE + "\"\"\" was NOT generated."
fi
