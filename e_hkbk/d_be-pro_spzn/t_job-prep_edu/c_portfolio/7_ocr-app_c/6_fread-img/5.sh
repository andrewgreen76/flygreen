C_FILE="2_img-bytes.c"
F_FILE="4.bmp"
MODE="rb"

emacs -nw $C_FILE
gcc $C_FILE -o zun.out
./zun.out $F_FILE $MODE
#rm zun.out
