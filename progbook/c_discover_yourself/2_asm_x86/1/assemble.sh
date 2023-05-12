nasm -f elf32 print_a.asm -o print_a.o
ld -m elf_i386 print_a.o -o print_a
