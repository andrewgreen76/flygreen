PONG_SRC="pong.c"

rm a.out
gcc $PONG_SRC -lm

if [ -e ./a.out ]; then
    read -n 1 -s -r -p "Press any key to continue..."
    ./a.out
    ls -1
    emacs -nw $PONG_SRC
else
    echo "Executable \"\"\"./a.out\"\"\" does NOT exist."
fi
