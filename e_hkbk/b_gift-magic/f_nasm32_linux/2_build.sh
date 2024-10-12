src=w_test.asm
o=z.o
exe=a.out

nasm -f elf32 -o $o $src
ld -m elf_i386 -o $exe $o
./$exe
