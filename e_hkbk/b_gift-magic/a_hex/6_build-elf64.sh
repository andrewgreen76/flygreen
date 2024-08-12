nasm -f elf64 -o z.o 3_gen.asm
ld -o 7_test64.elf z.o
./7_test64.elf
