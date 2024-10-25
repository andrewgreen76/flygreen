	.file	"main.c"
	.intel_syntax noprefix
	.text
	.def	___main;	.scl	2;	.type	32;	.endef
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB13:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	and	esp, -16

	;;;;;;;;;;;;;;;; C compile : We init'd buf[30] , ;;;;;;;;;;;;;;;; 
	;;;;;;;;;;;;;;;; We will :   ret 'A' from ASM callee. ;;;;;;;;;;;;;;;;

	sub	esp, 48					; (compiler allocs 48 bytes per mem_alignment, no params) ESP 
	call	___main				; but we want 30 bytes => 18-byte excess gap. 
								; Now , struct test s = my_asm();
								
	; (1) We don't want to break the alignment. 
	; (2) We want the 30-byte buffer accessible to our ASM callee. 
	;   We could access the buffer directly from ASM callee w/ BP+offset ... if we only knew 
	; 	what the offset should be. 
	lea	eax, [esp+18]			; Solution : We pass the buffer by reference. Take buf_addr. 
	mov	DWORD PTR [esp], eax	; Populate buf_addr in 18B-gap : +0, +1, +2, +3 

								; [30B buf] [18B : 4B buf_addr] (no_para) ESP
	call	_my_asm				; [30B buf] [18B : 4B buf_addr] (no_para) [ret_addr] ESP
								; ret_val will be in EAX. 

	movzx	eax, BYTE PTR [esp+18]
	movsx	eax, al
	mov	DWORD PTR [esp], eax
	call	_putchar
	mov	eax, 0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE13:
	.ident	"GCC: (i686-posix-dwarf-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	_my_asm;	.scl	2;	.type	32;	.endef
	.def	_putchar;	.scl	2;	.type	32;	.endef
