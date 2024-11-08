ENTRY(_start)
OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 1M;    /* kernel will be loaded @ 1MB of RAM (0x100000) */

    /* .text = any code. Typically C , but some assembly can be added as well. */
    /* CC aligns .text to 16 bytes by default. The boot and kernel sectors 
       are manually aligned to 512 bytes , which is a multiple of 16 , so we 
       are good there. */
    /* Our bootstrap and kernel code will go here. */
       
    .text : ALIGN(4096)    /* 4K-alignment (for every section) - just in case. */
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

    /* A section for other assembly code - here so that it does not break C code's alignment. */
    .asm : ALIGN(4096)
    {
	*(.asm)
    }
}
