nasm -f elf32 -o z.o 1_main.asm
ld -m elf_i386 -o run z.o
./run
