
	;; Directives - code meant FOR THE ASSEMBLER. 
	ORG 0x7c00 		; Has to be 0x7c00 as the memory {0x0 -> 0x7bff} is to be taken by BIOS Data Area , IVT , etc. 
	BITS 16 		; Ready to load 16-bit code and data only. 

	;; Data computed with directives (again, code meant for the assembler) , not code to be loaded into memory by BIOS upon booting. 
				     ; offset of NULL (invalidity) segment in GDT = 0 
CODE_SEG equ gdt_code - gdt_start    ; offset of code in GDT = 8
DATA_SEG equ gdt_data - gdt_start    ; offset of data in GDT = 16

	;; First instructions of boot code to be loaded into memory @ 0x7c00 => meant for BIOS. 
_start:
	jmp short rlboot_at_cs
	nop 			 
	times 33 db 0 	

rlboot_at_cs: 				; Note to self : this might be a case of redundant jumping  
	jmp 0x0:rlboot_at_csoff 	;   that could be simplified. We still want to set CS = ORG + 0x0. 

;;; Values in segments and pointers that define the REAL MODE SEGMENTATION MODEL : 
rlboot_at_csoff:	
	cli
	mov ax , 0x0 	 
	mov ds , ax 	
	mov es , ax	
	mov ss , ax	 
	mov sp , 0x7c00	 
	sti
	
.sw_to_prot:
	cli
	lgdt [gdt_descr] 	
	mov eax , cr0
	or eax , 0x1		; PROTECTION ENABLE raised 
	mov cr0 , eax 		; Though being in 32-bit mode is a definitive characteristic of the protected mode ,
				; it would be argued that loading CR0 with old values but bit 0 raised is the precise
				; moment when we enter the protected mode ; BIOS is no longer available to use , which 
				; means that to perform things like disk operations or loading the kernel into memory
				; we are going to need drivers => protected-mode substitutes for BIOS. No UEFI ! 

	;;; ORG --(offset)-> CS --(offset)-> IP. 
	jmp CODE_SEG:ld_krnl32 	; switch to 32-bit kernel code  
	
;;; GDT CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gdt_start:
;; GDT:0 = ; null descriptor (64 bits) 
gdt_null:			 
	dd 0x0 			
	dd 0x0 			
;; GDT:8 = CS descr 
gdt_code: 			  
	dw 0xffff 		
	dw 0 			
	db 0 			
	db 0x9a			 
	db 11001111b		
	db 0 			
;; GDT:0x10 = 16 = other seg.descrs
gdt_data:	      		 
	dw 0xffff 		
	dw 0 			
	db 0 			
	db 0x92			 
	db 11001111b		
	db 0 			
gdt_end:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gdt_descr:
	dw gdt_end - gdt_start - 1    
	dd gdt_start		       
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LOADING THE KERNEL FROM BOOTABLE MEDIUM TO THE TARGET MACHINE'S RAM : ;;;
	[BITS 32]
ld_krnl32:
	mov eax , 1 		; starting sector to load from - kernel sector ; 0 - boot sector. 
	mov ecx , 100 		; no. sectors to load - for kernel code
	mov edi , 0x00100000 	; target RAM address to load kernel code into from disk 
	call ata_lba_read 	; LBA (instead of CHS) for disk ops
	jmp CODE_SEG:0x00100000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PRIMAL DISK DRIVER : ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ata_lba_read:
	mov ebx , eax 		; reserve LBA to reuse acc. ;   ? LBA = starting sector ?
;;; Send MSB of 32-bit LBA to HDD controller :
	shr eax , 24 		; eax >> 24
	or eax , 0xE0 		; 111..... will select the master (vs. slave) drive at I/O. 
	mov dx , 0x1f6 		; specify dest HDD port for highest byte of LBA
	out dx , al 		 
;;; Send no. kernel sectors to read - to HDD controller : 
	mov eax , ecx 		 
	mov dx , 0x1f2 		 
	out dx , al 		; 100 - representable with a single byte 
				; `out`_src and `in`_dest can work w/ imm.val only in ACC 
				
;;; Send LSB of LBA : 
	mov eax , ebx 
	mov dx , 0x1f3 
	out dx , al 
;;; Send 2nd LSB of LBA : 
	mov dx , 0x1f4
	mov eax , ebx
	shr eax , 8  		
	out dx , al 		
;;; Send 3rd LSB of LBA :
	mov dx , 0x1f5
	mov eax , ebx
	shr eax , 16 		 
	out dx , al 		
;;; Reading from the disk - sending target RAM address to HDD controller :
	mov al , 0x20 		; target RAM addr = 00100000
	mov dx , 0x1f7 		
	out dx , al
	
;;; OUTER LOOP - Read every one of [ECX] sectors into memory :
.next_sector: 			 
	push ecx    ; Preserve count of remaining sectors to read ; We'll reuse ECX. 

;;; INNER CHECK_LOOP - Keep checking on read-enable bit - repeatedly due to controller update delay. 
.try_again:
	mov dx , 0x1f7		; Pull up I/O port status flags/ 
	in al , dx 		
	test al , 8 		; See if bit 3 is set : .... v... 
	jz .try_again
	;;; }

;;; INNER WORD_LOOP - Read every one of 256 words at a time - that's a whole sector :
;;; (Reading a word in an iteration is faster than two indiv. bytes over two iterations.)
	mov ecx, 256 		
	mov dx , 0x1f0
	rep insw 		; load word from [dx] (I/O) to [di] (@ 1 MB base) 
				; `rep`eats instr. and decrs ecx until ecx=0    => 256 times. 
	;; NEXT WORD. 

	pop ecx			; bring up rem sector count 
	loop .next_sector  	; `loop` decrs count until 0. 
	;; NEXT SECTOR. 

	;; Exit kernel-reading call. 
	ret
		
;;; The assembly directives below are for populating the 1st sector. ;;;;;;;;;;;;;

	times 510-($-$$) db 0	
	dw 0xAA55

;;; End of 1st sector (boot code). ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Start of 2nd sector (anything we want - ?code?text?). ;;;;;;;;;;;;;;;;
