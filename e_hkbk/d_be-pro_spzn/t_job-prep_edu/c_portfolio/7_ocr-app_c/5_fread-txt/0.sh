C_FILE="5_read-bmp.c"
FNAME="b.bmp"
MODE="rb"

emacs -nw $C_FILE
gcc $C_FILE -o zun.out
./zun.out $FNAME $MODE
#rm zun.out
