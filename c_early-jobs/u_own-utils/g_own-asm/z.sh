nasm -f elf64 0_seed.asm -o 2_seed.o
ld 2_seed.o

#> echo $?   # prints 0
