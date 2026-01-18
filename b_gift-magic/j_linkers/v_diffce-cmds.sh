
# best: byte-by-byte difference with context
diff -u <(xxd -g1 obj1.o) <(xxd -g1 obj2.o)

# or with hexdump
hexdump -C obj1.o > 1.hex
hexdump -C obj2.o > 2.hex
vimdiff 1.hex 2.hex

# or if small files: just cmp
cmp -l obj1.o obj2.o   # prints byte offsets where they differ

#
