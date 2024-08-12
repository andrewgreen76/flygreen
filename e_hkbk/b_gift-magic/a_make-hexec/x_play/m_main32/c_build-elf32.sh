nasm -f elf32 -o z.o b_gen.asm
ld -m elf_i386 -o d_test32.elf z.o
./d_test32.elf
