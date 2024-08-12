nasm -f elf32 -o z.o 3_gen.asm
ld -m elf_i386 -o 5_test32.elf z.o
./5_test32.elf
