o_filename=d_o32.o
o_profname=e_asmr-o32-prof.txt
o_dumpname=f_asmr-o32-dump.txt

e_filename=j_test32
e_profname=k_ld-e32-prof.txt
e_dumpname=l_ld-e32-dump.txt

#######################################################
#              OS }
#       BIT-WIDTH } -> [assembler] -> .o
# EXECUTABLE TYPE }
#######################################################

nasm -f elf32 -o $o_filename b_gen.asm    

objdump -f $o_filename > $o_profname
hexdump -C $o_filename > $o_dumpname

#######################################################
#     ARCHITECTURE }
# operating system } -> [linker] -> executable (.elf) 
#        bit-width }
#  executable type }
#######################################################

ld -m elf_i386 -o $e_filename $o_filename     

objdump -f $e_filename > $e_profname
readelf -h $e_filename >> $e_profname
echo >> $e_profname 

hexdump -C $e_filename > $e_dumpname

#######################################################

./$e_filename
clear
ls -1
