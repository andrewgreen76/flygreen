nasm -f elf a_hello-n.asm
ld -m elf_i386 b_hello-nasm.o -o u_hello
