o_filename=d_o32.o
o_profname=f_asmr-o32-prof.txt
o_dumpname=h_asmr-o32-dump.txt

e_filename=j_test32.elf
e_profname=l_ld-e32-prof.txt
e_dumpname=n_ld-e32-dump.txt

#========= .o reflects OS/bit-width =========

nasm -f elf32 -o $o_filename 5_gen.asm

objdump -f $o_filename > $o_profname
hexdump -C $o_filename > $o_dumpname

#======== .elf reflects OS/btwd+arch ========

ld -m elf_i386 -o $e_filename $o_filename

objdump -f $e_filename > $e_profname
readelf -h $e_filename >> $e_profname
hexdump -C $e_filename > $e_dumpname

#############################################

./$e_filename
