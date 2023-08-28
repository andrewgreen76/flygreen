$C_FILE="1_txt-bytes.c"

emacs -nw $C_FILE
gcc $C_FILE -o zun.out
./zun.out 
#rm zun.out
