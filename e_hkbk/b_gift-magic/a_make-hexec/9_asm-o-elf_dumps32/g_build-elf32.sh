nasm -f elf32 -o z.o d_gen.asm
ld -m elf_i386 -o j_test32.elf z.o
./j_test32.elf
