nasm -f elf hello-n.asm
ld -m elf_i386 hello-n.o -o e_hello
./e_hello
