SRC=0.c
BASENAME=max-optim
BIN=7_$BASENAME.bin
DUMP=8_$BASENAME.dump.txt

gcc -O3 -flto $SRC -o $BIN
./$BIN
hexdump $BIN > $DUMP
