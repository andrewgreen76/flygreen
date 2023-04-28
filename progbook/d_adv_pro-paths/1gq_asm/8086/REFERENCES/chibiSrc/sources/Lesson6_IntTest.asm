    .model small
    .stack 1024
	.data
hello	db "Hello world!", 13, 10, '$'
	
	.code
	mov ax, @data	;ES points to our Data segment
	mov ds, ax
	mov ax, @code	;DS points to our Code segment
    mov es, ax
		
	mov	ah, 09h		;09h=String output
	mov	dx, offset hello
	int	0x21		;Dos Intertipt
	
	cli
	mov	ax, 0x4c00	;4ch=Terminate a process (EXIT)
	int	0x21		;Dos Intertipt


