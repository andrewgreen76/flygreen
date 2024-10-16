
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
	
.prep_prot:
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LOADING THE KERNEL FROM BOOTABLE MEDIUM TO TARGET MACHINE'S RAM : ;;;;
	[BITS 32]
ld_krnl32:
	mov eax , 1 		; starting sector to load from - kernel sector ; 0 - boot sector. 
	mov ecx , 100 		; no. sectors to load - for kernel code
	mov edi , 0x00100000 	; target RAM address to load kernel code into from disk 
	call ata_lba_read 	; LBA (instead of CHS) for disk ops 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PRIMAL DISK DRIVER : ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ata_lba_read:
	mov ebx , eax 		; reserve LBA ; reuse acc. ;   ? LBA = starting sector ?
;;; Send highest byte of 32-bit LBA to HDD controller :
	shr eax , 24 		; eax >> 24
	mov dx , 0x1f6 		; target HDD port for highest byte of LBA
	out dx , al
;;; Send kernel sectors to read to HDD controller : 
	mov eax , ecx 		; 100 = 0x64 = 0x6 0x4 
	mov dx , 0x1f2 		; HDD controller port 
	out dx , al
;;; Send more of LBA : 
	mov eax , ebx 
	mov dx , 0x1f3		; HDD controller port 
	out dx , al
;;; Send even more of LBA : 
	mov dx , 0x1f4
	mov eax , ebx
	shr eax , 8  		; get highest 24 bits of LBA
	out dx , al
;;; Send highest 16 bits of LBA :
	mov dx , 0x 1f5
	mov eax , ebx
	shr eax , 16
	out dx , al
;;; Reading from the disk :
	mov dx , 0x1f7
	mov al , 0x20
	out dx , al
;;; Read all sectors into memory :
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;; The code below is for populating the 1st sector. ;;;;;;;;;;;;;

	times 510-($-$$) db 0	
	dw 0xAA55

;;; End of 1st sector (boot code). ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Start of 2nd sector (anything we want - ?code?text?). ;;;;;;;;;;;;;;;;
