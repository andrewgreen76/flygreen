	.file	"main.c"
	.intel_syntax noprefix
	.text
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "%i\12\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB13:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp	; [pre-main ret_addr] [pre-main EBP] SP/BP
	.cfi_def_cfa_register 5
	and	esp, -16

	;;; Working with local variables ? 
	sub	esp, 32		; [pre-main ret_addr] [pre-main EBP] BP [32B] SP  
	call	___main
	mov	DWORD PTR [esp+24], 50		; [pre-main ret_addr] [pre-main EBP] BP [ ___ 50 ____ ] SP 
	lea	eax, [esp+24]			; &50 
	mov	DWORD PTR [esp+28], eax		; [pre-main ret_addr] [pre-main EBP] BP [ &50 50 ____ ] SP

	;;; Working with parameters for my_asm() ? 
	mov	eax, DWORD PTR [esp+28]		; &50 ; passing by pointer 
	mov	DWORD PTR [esp], eax		; [pre-main ret_addr] [pre-main EBP] BP [ &50 50 ____ &50 ] SP
	call	_my_asm

	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC0
	call	_printf
	mov	eax, 0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE13:
	.ident	"GCC: (i686-posix-dwarf-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	_my_asm;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
