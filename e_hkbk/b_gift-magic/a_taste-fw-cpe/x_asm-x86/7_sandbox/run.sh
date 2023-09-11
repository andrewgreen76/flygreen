nasm -f elf hello-n.asm
ld -m elf_i386 hello-n.o -o i_hello
./i_hello
rm i_hello hello-n.o
