
	ORG 0			; REMEMBER: THIS IS JUST AN OFFSET IN QEMU MACHINE'S RAM 
	BITS 16			

	jmp 0x07c0:start 	

start:
	cli			; clear the int flag in FLAGS (disable interrupts) 
	/************************************************************************/
	/* This chunk here is critical to system operability and must not 
	   be interrupted under any circumstances by a hardware interrupt. 
	   If it is interrupted , consistency may be violated and wrong values may 
	   get written to the registers. */
	mov ax , 0x07c0	 	; This method is an alternative to ORG 0x7C00. 
	
	mov ds , ax 		; DS:SI starting address calibrated to 0x7c00. Source buffer offsets are taken care of. 
	mov es , ax 		; ES:DI starting address calibrated to 0x7c00. Destination buffer offsets are taken care of.
				; Data is part of our source code within the same segment @ 0x7C00.

	mov ax , 0x00
	mov ss , ax
	mov sp , 0x7c00 	; Keep in mind : this is a pointer register , not a segment register. 
	
	/* Q : ... in other words, DS and ES must hold the same address as CS because 
	       they are essentially "the same segment" in real mode?

	   A : "... IN REAL MODE, having DS, ES, and CS hold the same value ensures that 
	        all segment registers point to the same memory area, allowing consistent 
	        access to the same code and data within that segment."  

	       "... IN PROTECTED MODE, CS, DS, and ES can hold different values as they represent 
		  distinct segment selectors that allow the processor to manage separate segments 
		  of memory for code, data, and additional purposes within the same process." 

	   Q : Does that mean that, say, DS in real mode works differently from DS in protected mode?

	   A : "Yes, DS in real mode directly points to a physical memory address, while in protected 
		mode, DS acts as a segment selector that references a segment descriptor in the Global 
		Descriptor Table (GDT), allowing for features like memory protection and segmentation."
	*/ 
	/************************************************************************/	
	sti			; enable interrupts
	
	mov si , msg
	call print_msg 
	jmp $			; "halting" point

print_msg:
	mov ah , 0eh
.chk_char:			; The dots are there for branch labels. 
	lodsb
	cmp al , 0 
	je .out			; Halt or not ?
	int 0x10		; print char 
	jmp .chk_char		; read next char 
.out:
	ret

msg:	db 'Hello, World!' , 10 , 0

	times 510-($-$$) db 0	
	dw 0xAA55
