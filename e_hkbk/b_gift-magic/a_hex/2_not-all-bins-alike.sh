
# generating with : NASM + ld = elf32
nasm -f elf32 -o z.o z.asm
ld -m elf_i386 -o a.out z.o
##> a.out: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, not stripped


# generating with : NASM + ld = elf32 
nasm -f elf64 -o z.o z.asm
ld -o a.out z.o
##> a.out: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped


# generating with : xxd
xxd -r -p <<< "7f454c46..." > minimal_elf.bin
##> minimal_elf.bin: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), no program header, no section header	


# generating with : echo -e
echo -e '\xB8\x01\x00\x00\x00\x31\xDB\xCD\x80' > program.bin
##> y_backup/program.bin: COM executable for DOS	    	      	      	 	 	    	    		 


#
