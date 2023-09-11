nasm -f elf hello-n.asm
ld -m elf_i386 hello-n.o -o i_hello-n
./i_hello-n
rm i_hello-n hello-n.o
