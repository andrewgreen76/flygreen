nasm -f elf64 -o z.o 3_gen.asm
ld -o 7_testelf64.out z.o
./7_testelf64.out