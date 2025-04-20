SRC=0.c
OUT=5.out

gcc -O0 -fno-lto $SRC -o $OUT
./$OUT
hexdump 9_hexd-tgt.txt
