nasm -f elf32 -o z.o 3_gen.asm
ld -m elf_i386 -o 5_testelf32.out z.o
./5_testelf32.out
