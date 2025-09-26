SRC=0.c
OUT=5.out

gcc -O3 -flto $SRC -o $OUT
./$OUT
rm $OUT
hexdump 9_hexd-tgt.txt
