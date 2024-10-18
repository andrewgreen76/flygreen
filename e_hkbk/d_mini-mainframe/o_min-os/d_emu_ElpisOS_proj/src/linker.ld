ENTRY(_start)
OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 1M;    /* kernel will be loaded @ 1MB of RAM (0x100000) */
    
    .text :    /* C code here */
    {
	*(.text)
    }

    .rodata :
    {
	*(.rodata)
    }

    .data :
    {
	*(.data)
    }

    .bss :
    {
	*(COMMON)
	*(.bss)
    }

    /* Assembly code section here so that it does not break C code's alignment. */
    
}
