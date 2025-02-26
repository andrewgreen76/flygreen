rm a.out
gcc 0_pong.c -lm

if [ -e ./a.out ]; then
    read -n 1 -s -r -p "Press any key to continue..."
    ./a.out
    ls -1
    emacs -nw 0_pong.c
else
    echo "Executable \"\"\"./a.out\"\"\" does NOT exist."
fi
