ENTRY(_start)
OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 1M;    /* kernel will be loaded @ 1MB of RAM (0x100000) */
    
    .text : ALIGN(4096)    /* C code here */
    {
	*(.text)
    }

    .rodata : ALIGN(4096)
    {
	*(.rodata)
    }

    .data : ALIGN(4096)
    {
	*(.data)
    }

    .bss : ALIGN(4096)
    {
	*(COMMON)
	*(.bss)
    }

    /* Assembly code section here so that it does not break C code's alignment. */
    .asm : ALIGN(4096)
    {
	*(.asm)
    }
}
