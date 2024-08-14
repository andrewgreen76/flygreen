
stat -c%s [target_file]    # byte count (incl. \0)

file [minimal_elf.bin]     # file properties
    # minimal_elf.bin: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, stripped

gdb [minimal_elf.bin]      # loading the bin exec    - ~ (gdb) file [prog.bin]
                           # setting the entry point - ~ (gdb) set architecture i386
                                                     # ~ (gdb) set $pc = 0x08048000
                           # running the executable  - ~ (gdb) run

readelf -h [prog.elf]

objdump -f [prog.elf]

hexdump -C [prog.elf] 

#
