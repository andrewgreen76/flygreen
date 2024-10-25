nasm -f elf32 -o j.o 5_gen.asm
ld -m elf_i386 -o t_test32.elf j.o
./t_test32.elf
hexdump -C j.o > p_odump32.txt
hexdump -C t_test32.elf > w_tedump32.txt
