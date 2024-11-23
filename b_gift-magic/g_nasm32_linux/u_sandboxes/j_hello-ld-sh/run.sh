nasm -f elf hello_world_nasm.asm
ld -m elf_i386 hello_world_nasm.o -o hello_world_nasm
