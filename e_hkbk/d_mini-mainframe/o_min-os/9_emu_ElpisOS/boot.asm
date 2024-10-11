
	ORG 0x7c00
	BITS 16 

CODE_SEG equ gdt_code - gdt_start    ; offset of code in GDT instructions block (0x8)
DATA_SEG equ gdt_data - gdt_start    ; offset of data in GDT instructions block (0x10)
	
_start:
	jmp short ld_btld
	nop 			 
	times 33 db 0 	; Faked all {0x03 -> 0x35} data bytes for BPB / 512. 

ld_btld:
	jmp 0x0:at_7c00 ; Manual load of CS:IP. 
	
at_7c00:	
	cli
	mov ax , 0x0
	mov ds , ax 	; DS = 0x7C00
	mov es , ax	; ES = -//-
	mov ss , ax	; SS:0 is RAM:0
	mov sp , 0x7c00 	
	sti 
;;; PROGRAMMING LOGIC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.ld_prot:
	cli
	lgdt [gdt_descr] 	; acts on size and offset - that's all it demands
	mov eax , cr0
	or eax , 0x1
	mov cr0 , eax
	jmp CODE_SEG:ld32 	; 0x8:"halt" 
	
;;; GDT CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gdt_start: 
gdt_null:			; null descriptor (64 bits) - represents an invalid segment 
	dd 0x0 			; define dword (word = bits , dword = 32 bits)
	dd 0x0 			; we've defined 2*23 = 64 bits with nulls
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CS descriptor = 0x8 = offset in the table (8-byte offset in GDT instructions block)
gdt_code: 			; CS @ here  
	dw 0xffff 		; GDTdescr : 15-00 : seg.lim=15
	dw 0 			; GDTdescr : 31-16 : seg.base(0-15)=0
	db 0 			; GDTdescr : 39-32 : seg.base_ext(16-23)=0
	db 0x9a			; GDTdescr : 47-40 : seg.access_byte (bit mask) 
					;; P DPL S 	Type 	; DPL - Descriptor Privilege Level 
					;;   0x9	0xA 
					;; 1  00 1	1010
	db 11001111b		; GDTdescr : 55-48 : seg.flags
	db 0 			; GDTdescr : 63-56 : seg.base_ext(24-31)=0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; otherS_descr = 0x10 = offset in the table (10-byte offset in GDT instructions block)
gdt_data:	      		; Linked to DS , ES , FS , GS , SS 
	dw 0xffff 		; GDTdescr : 15-00 : seg.lim=15
	dw 0 			; GDTdescr : 31-16 : seg.base(0-15)=0
	db 0 			; GDTdescr : 39-32 : seg.base_ext(16-23)=0
	db 0x92			; GDTdescr : 47-40 : seg.access_byte (bit mask) 
					;; P DPL S 	Type 	; DPL - Descriptor Privilege Level 
					;;   0x9	0xA 
					;; 1  00 1	1010
	db 11001111b		; GDTdescr : 55-48 : seg.flags
	db 0 			; GDTdescr : 63-56 : seg.base_ext(24-31)=0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gdt_end:

gdt_descr:
	dw gdt_end - gdt_start - 1    ; size(16b) of descriptor
	dd gdt_start		      ; offset(32b) of descriptor    ; null + CSdescr + DSdescr will be loaded 

;;; 32-BIT CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	[BITS 32] 		
	
ld32:
	mov ax , DATA_SEG
	mov ds , ax
	mov es , ax
	mov fs , ax
	mov gs , ax
	mov ss , ax
	mov ebp , 0x00200000
	mov esp , ebp 
	jmp $
	
;;; 1st sector has the code below for populating hardcoded chars. ;;;;;;;;;;;;;

	times 510-($-$$) db 0	
	dw 0xAA55

;;; End of 1st sector (boot code). ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Start of 2nd sector (anything we want - in text). ;;;;;;;;;;;;;;;;

	
