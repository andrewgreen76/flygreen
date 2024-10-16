
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

rlboot_at_cs: 			; Note to self : this might be a case of redundant jumping  
	jmp 0x0:rlboot_at_csoff 	;   that could be simplified. We still want to set CS = ORG + 0x0. 

;;; Segments and pointers that DEFINE THE REAL MODE : 
rlboot_at_csoff:	
	cli
	mov ax , 0x0 	; CS @ DS @ ES 
	mov ds , ax 	; DS @ 0x7c00 + 0
	mov es , ax	; ES = -//-
	mov ss , ax	; SS @ 0x0 + 0    ; necessary for access to BIOS , IVT , other stack operations occur 
	mov sp , 0x7c00	; SP @ 0x0 + 0x7c00    ; as expected by the real-mode BIOS 
	sti
	
.prep_prot:
	cli
	lgdt [gdt_descr] 	; Reads @ gdt_descr : GDT.SIZE , GDT.OFFSET. (No spec of rwe.)  
	mov eax , cr0
	or eax , 0x1		; PROTECTION ENABLE raised 
	mov cr0 , eax 		; Though being in 32-bit mode is a definitive characteristic of the protected mode ,
				; it would be argued that loading CR0 with old values but bit 0 raised is the precise
				; moment when we enter the protected mode ; BIOS is no longer available to use , which 
				; means that to perform things like disk operations or loading the kernel into memory
				; we are going to need drivers => protected-mode substitutes for BIOS. No UEFI ! 

	;;; ORG --(offset)-> CS --(offset)-> IP. 
	; jmp CODE_SEG:sw_to_prot 	  ; switch to protected mode :
					  ; INIT {DS,ES,..,} = GDT:DSoff
					  ; INIT {SS,SP}
					  ; "halt" 
	jmp $
	
;;; GDT CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; All values below are DEFAULT values. It is NOT a good idea to use different values. 
	;; Descriptors are shaped with "`d`efine" directives.
gdt_start:
;; GDT:0 = NULL descr
gdt_null:			; null descriptor (64 bits) - represents an invalid segment 
	dd 0x0 			; 32 zeros
	dd 0x0 			; 32 zeros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GDT:8 = CS descr 
gdt_code: 			; CS @ here  
	dw 0xffff 		; GDTdescr : 15-00 : seg.lim=15
	dw 0 			; GDTdescr : 31-16 : seg.base(0-15)=0
	db 0 			; GDTdescr : 39-32 : seg.base_ext(16-23)=0
	db 0x9a			; GDTdescr : 47-40 : seg.access_byte (bit mask) 
					;; P DPL S 	Type 	; DPL - Descriptor Privilege Level 
					;;   0x9	0xA 	; 00 - ring 0 (kernel)
					;; 1  00 1	1010	; 11 - ring 3 (user proc)
	db 11001111b		; GDTdescr : 55-48 : seg.flags
	db 0 			; GDTdescr : 63-56 : seg.base_ext(24-31)=0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GDT:0x10 = 16 = other seg.descrs
gdt_data:	      		; Linked to DS , ES , FS , GS , SS 
	dw 0xffff 		; GDTdescr : 15-00 : seg.lim=15
	dw 0 			; GDTdescr : 31-16 : seg.base(0-15)=0
	db 0 			; GDTdescr : 39-32 : seg.base_ext(16-23)=0
	db 0x92			; GDTdescr : 47-40 : seg.access_byte (bit mask) 
					;; P DPL S 	Type 	; DPL - Descriptor Privilege Level 
					;;   0x9	0x2 	 
					;; 1  00 1	0010	
	db 11001111b		; GDTdescr : 55-48 : seg.flags
	db 0 			; GDTdescr : 63-56 : seg.base_ext(24-31)=0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gdt_end:

gdt_descr:
	dw gdt_end - gdt_start - 1    ; size(16b) of descriptor
	dd gdt_start		      ; offset(32b) of descriptor    ; null + CSdescr + DSdescr will be loaded 

	;; pcut
	
;;; 1st sector has the code below for populating hardcoded chars. ;;;;;;;;;;;;;

	times 510-($-$$) db 0	
	dw 0xAA55

;;; End of 1st sector (boot code). ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Start of 2nd sector (anything we want - in text). ;;;;;;;;;;;;;;;;
