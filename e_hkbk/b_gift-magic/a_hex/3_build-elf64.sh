nasm -f elf64 -o z.o z.asm
ld -o a.out z.o
./a.out
