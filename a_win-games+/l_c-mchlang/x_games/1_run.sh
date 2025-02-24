gcc 0_snake_dumb_crude.c -lm

if [ -e ./a.out ]; then
    ./a.out
else
    echo "Executable \"\"\"./a.out\"\"\" does NOT exist."
fi
