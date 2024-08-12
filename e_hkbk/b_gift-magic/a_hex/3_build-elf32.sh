nasm -f elf32 -o z.o z.asm
ld -m elf_i386 -o a.out z.o
./a.out
