nasm -f elf64 -o z.o z.asm
ld -o 7_testelf64.out z.o
./7_testelf64.out
