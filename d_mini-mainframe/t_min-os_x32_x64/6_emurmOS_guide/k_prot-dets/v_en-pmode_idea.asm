
	cli            ; disable interrupts
	lgdt [gdtr]    ; load GDT register with start address of Global Descriptor Table
	mov eax, cr0 
	or al, 1       ; set PE (Protection Enable) bit in CR0 (Control Register 0)
	mov cr0, eax

; Perform far jump to selector 08h (offset into GDT, pointing at a 32bit PM code segment descriptor) 
; to load CS with proper PM32 descriptor)
	jmp 08h:PModeMain

PModeMain:
; load DS, ES, FS, GS, SS, ESP
