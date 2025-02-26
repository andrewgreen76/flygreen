rm a.out
gcc 4_snake_dumb_crude.c -lm

if [ -e ./a.out ]; then
    read -n 1 -s -r -p "Press any key to continue..."
    ./a.out
    ls -1
    emacs -nw 4_snake_dumb_crude.c
else
    echo "Executable \"\"\"./a.out\"\"\" does NOT exist."
fi
