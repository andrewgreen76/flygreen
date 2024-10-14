
	ORG 0x7c00
	BITS 16 
				     ; 		   GDT:0 = NULLdescr_base 
CODE_SEG equ gdt_code - gdt_start    ; CS.offset ; GDT:8 = CSdescr_base = seg @ 0x8 in RAM
DATA_SEG equ gdt_data - gdt_start    ; DS.offset ; GDT:16 = DSdescr_base = seg @ 0x10 in RAM
	
_start:
	jmp short ld_btld
	nop 			 
	times 33 db 0 	

ld_btld:
	jmp 0x0:init_real_regs
	
init_real_regs:	
	cli
	mov ax , 0x0
	mov ds , ax 	; DS @ 0x7c00 + 0
	mov es , ax	; ES = -//-
	mov ss , ax	; SS @ 0x0 + 0    ; necessary for access to BIOS , IVT , other stack operations occur 
	mov sp , 0x7c00	; SP @ 0x0 + 0x7c00    ; as expected by the real-mode BIOS 
	sti
	
;;; PROGRAMMING LOGIC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.prep_prot:
	cli

	lgdt [gdt_descr] 	; Reads @ gdt_descr : GDT.SIZE , GDT.OFFSET. (No spec of rwe.)  

	mov eax , cr0
	or eax , 0x1		; PROTECTION ENABLE raised 
	mov cr0 , eax

	jmp CODE_SEG:init_prot_regs 	; switch to protected mode :
					  ; INIT {DS,ES,..,} = GDT:DSoff
					  ; INIT {SS,SP}
					  ; "halt" 
	
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

gdt_descr:			      ; i.e., info about GDT 
	dw gdt_end - gdt_start - 1    ; size(16b) of descriptor
	dd gdt_start		      ; offset(32b) of descriptor    ; null + CSdescr + DSdescr will be loaded 

;;; 32-BIT CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	[BITS 32] 		
	
init_prot_regs:
	mov ax , DATA_SEG
	mov ds , ax
	mov es , ax
	mov fs , ax
	mov gs , ax
	mov ss , ax
				; A:            21    16   12    8    4    0
				;                |     |    |    |    |    | 
	mov ebp , 0x00200000 	;    0000 0000 0010 0000 0000 0000 0000 0000 
	mov esp , ebp 		; -//-
	jmp $ 			; "halt"
	
;;; 1st sector has the code below for populating hardcoded chars. ;;;;;;;;;;;;;

	times 510-($-$$) db 0	
	dw 0xAA55

;;; End of 1st sector (boot code). ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Start of 2nd sector (anything we want - in text). ;;;;;;;;;;;;;;;;

	
