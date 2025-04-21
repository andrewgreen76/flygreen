SRC=0.c
BASENAME=no-optim
BIN=3_$BASENAME.bin
DUMP=4_$BASENAME.dump.txt

gcc -O0 -fno-lto $SRC -o $BIN
./$BIN
hexdump -C $BIN > $DUMP
cat $DUMP | xclip -selection clipboard
