this_elf="d_main32.elf"

nasm -f elf32 -o z.o b_gen.asm
ld -m elf_i386 -o $this_elf z.o
./$this_elf
hexdump -C $this_elf > j_dump32.txt
