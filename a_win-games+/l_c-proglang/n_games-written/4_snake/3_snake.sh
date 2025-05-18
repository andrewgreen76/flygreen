SNAKE_SRC="4_snake_dumb_crude.c"

rm a.out
gcc $SNAKE_SRC -lm

if [ -e ./a.out ]; then
    read -n 1 -s -r -p "Press any key to continue..."
    ./a.out
    ls -1
    emacs -nw $SNAKE_SRC
else
    echo "Executable \"\"\"./a.out\"\"\" does NOT exist."
fi
