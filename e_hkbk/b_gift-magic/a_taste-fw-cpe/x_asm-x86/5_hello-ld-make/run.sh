nasm -f elf hello.asm
ld -m elf_i386 hello.o -o i_hello
./i_hello
rm i_hello hello.o
