o_filename=g_o32.o
o_profname=j_asmr-o32-prof.txt
o_dumpname=m_asmr-o32-dump.txt

e_filename=p_test32.elf
e_profname=t_ld-e32-prof.txt
e_dumpname=w_ld-e32-dump.txt

#========= .o reflects OS/bit-width =========

nasm -f elf32 -o $o_filename 5_gen.asm

objdump -f $o_filename > $o_profname
readelf -h $o_filename >> $o_profname
hexdump -C $o_filename > $o_dumpname

#======== .elf reflects OS/btwd+arch ========

ld -m elf_i386 -o t_test32.elf $o_filename

objdump -f $e_filename > $e_profname
readelf -h $e_filename >> $e_profname
hexdump -C $e_filename > $e_dumpname

#############################################

./t_test32.elf

