o_fname=j_o32.o

nasm -f elf32 -o $o_fname 5_gen.asm
ld -m elf_i386 -o t_test32.elf $o_fname
./t_test32.elf
hexdump -C $o_fname > p_asmr-o32dump.txt
hexdump -C t_test32.elf > w_ld-e32dump.txt
