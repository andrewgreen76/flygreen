
;;; 32-BIT CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	[BITS 32]
	section .text    	; Include this file in a section of the linker script. 
	
	global _start
	extern kernel_main
	
;;; Kernel's segments for code and data : 
CODE_SEG equ 0x08 
DATA_SEG equ 0x10 
	
;;; Values in segments and pointers that define the PROTECTED MODE SEGMENTATION MODEL : 
_start:
	mov ax , DATA_SEG 	; Needs to know the GDT offset for DS. 
	mov ds , ax
	mov es , ax
	mov fs , ax
	mov gs , ax
	mov ss , ax
	mov ebp , 0x00200000 	; past A20 (1 MB) , using A21 (into 2 MB) 
	mov esp , ebp 		

	;; Augment memory access to 16 MB : 
	in al, 0x92 		; keyboard controller I/O port (believe it or not) 
	or al, 2		; enable A20 line (for access to the bottom 16 MB memory) 
	out 0x92, al
	;; REMEMBER : `in`/`out` ARE MICROCODED TO INFLUENCE I/O PORTS , NOT MEMORY. 

;;; REMAPPING THE MASTER PIC : ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov al , 00010001b 	; init PIC
	out 0x20 , al 		; Here 0x20 - port number for init ; NOTHING to do with INT 0x20. 

	mov al , 0x20 		; IRQ0 - mapped to INT 0x20 
	out 0x21 , al 		; 0x21 - port (at this clock cycle) for setting a reference for mapping IRQs to INTs 

	mov al , 00000001b	; inform PIC : x86 mode 
	out 0x21 , al 		; 0x21 - port (at this clock cycle) for informing of the architecture/system mode 
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	sti 			; Interrupts are prematurely disabled by default. 
				; ARGUMENT : We are enabling interrupts TOO EARLY - BEFORE we init IDT.  
	call kernel_main
	
	jmp $ 			; "halt"
	
	times 512-($-$$) db 0
	;; We've padded out our kernel sector. 

	;; 
