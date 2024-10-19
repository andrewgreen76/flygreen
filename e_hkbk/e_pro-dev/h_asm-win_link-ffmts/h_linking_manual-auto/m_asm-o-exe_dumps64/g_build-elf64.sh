nasm -f elf64 -o z.o 3_gen.asm
ld -o 8_test64.elf z.o
./8_test64.elf
