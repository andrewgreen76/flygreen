BIN_EXE="./pong.bin"
MAIN_SRC="./main.c"

gcc -o $BIN_EXE $MAIN_SRC 

if [ -e $BIN_EXE ]; then
    echo Project built.
    read -n 1 -s -r -p "Press any key to continue..."
    echo
    $BIN_EXE
    ### We want to see runtime error messages. ###
    echo Program terminated. The main source code file will be displayed.
    read -n 1 -s -r -p "Press any key to continue..."
    rm $BIN_EXE
    emacs -nw $MAIN_SRC
    clear
    ls -1
else
    echo "Executable \""$BIN_EXE"\" was NOT generated."
fi
