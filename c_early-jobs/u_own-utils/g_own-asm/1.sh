nasm -f elf64 0_nothing.asm -o 0_nothing.o
ld 0_nothing.o

#> echo $?   # prints 0
