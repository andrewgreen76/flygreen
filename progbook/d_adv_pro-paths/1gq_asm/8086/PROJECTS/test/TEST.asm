[org 0x7C11]
[bits 16]

main:
mov ax, 0x0000
mov ds, ax
mov al, [msg]  
mov ah, 0x0E  
mov bx, 0x0007  
int 0x10    
jmp $  

msg db 'X'

times 510-($-$$) db 0  
dw 0xAA55