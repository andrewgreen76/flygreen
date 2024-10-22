	.file	"main.c"
	.intel_syntax noprefix
	.text
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "%c\12\0"
	.text
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
	sub	esp, 64
	call	___main

	mov	BYTE PTR [esp+34], 65
	mov	BYTE PTR [esp+35], 66
	mov	BYTE PTR [esp+36], 67
	mov	eax, DWORD PTR [esp+34]		; passing the lowest dword "ABC%" in caller's local space 
	mov	DWORD PTR [esp], eax		; to callee's param space BY VALUE. (Bytes 0-3.)
	mov	eax, DWORD PTR [esp+38]
	mov	DWORD PTR [esp+4], eax		; 2nd lowest dword (bytes 4-7). 
	mov	eax, DWORD PTR [esp+42]
	mov	DWORD PTR [esp+8], eax		; 3rd lowest (bytes 8-11).
	mov	eax, DWORD PTR [esp+46]
	mov	DWORD PTR [esp+12], eax		; Bytes 12-15. 
	mov	eax, DWORD PTR [esp+50]
	mov	DWORD PTR [esp+16], eax		; 16-19
	mov	eax, DWORD PTR [esp+54]
	mov	DWORD PTR [esp+20], eax		; 20-23 
	mov	eax, DWORD PTR [esp+58]
	mov	DWORD PTR [esp+24], eax		; 24-27
	movzx	eax, WORD PTR [esp+62]	; Here we are moving a 16-bit (single) word. 
	mov	WORD PTR [esp+28], ax		; 28 and 29
	call	_my_asm

	; Notice that `mov` is central to passing by value 
	; and `lea` in necessary for passing by reference. 

	movsx	eax, al
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
