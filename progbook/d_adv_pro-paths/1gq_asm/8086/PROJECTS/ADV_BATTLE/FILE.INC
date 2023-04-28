;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   File library:   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hand    dw 0        ;###    handler...
ferr    db 0        ;###    DOS error code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fopen:    pusha        ;DS:DX = file name, [hand] <= file handle
    mov ax,3D02h
    int 21h
    mov bl,0
    jnc fopen0
    mov bl,al
    sub ax,ax
fopen0: mov [cs:hand],ax
    mov [cs:ferr],bl
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fnew:    pusha        ;DS:DX = file name, [hand] <= file handle
    mov ah,3ch
    mov cx,0    ;attr
    int 21h
    mov bl,0
    jnc fnew0
    mov bl,al
    sub ax,ax
fnew0:    mov [cs:hand],ax
    mov [cs:ferr],bl
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fclose:    pusha        ;[hand] = file handle
    mov bx,[cs:hand]
    mov ah,3eh
    int 21h
    mov bl,0
    jnc fclose0
    mov bl,al
    sub ax,ax
fclose0:mov [cs:ferr],bl
    mov [cs:hand],ax
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fread:    pusha        ;DS:DX = adr, CX = length, [hand] = hand, CX => read
    mov bx,[cs:hand]
    mov ah,3Fh
    int 21h
    mov bl,0
    jnc fread0
    mov bl,al
    sub ax,ax
fread0:    mov [cs:ferr],bl
    mov cx,ax
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fwrite:    pusha        ;DS:DX = adr, CX = length, [hand] = hand, CX => write
    mov bx,[cs:hand]
    mov ah,40h
    int 21h
    mov bl,0
    jnc fwrite0
    mov bl,al
    sub ax,ax
fwrite0:mov [cs:ferr],bl
    mov cx,ax
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fdel:    pusha        ;DS:DX = file name
    mov ah,41h
    int 21h
    mov bl,0
    jnc fdel0
    mov bl,al
fdel0:    mov [cs:ferr],bl
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fattr:    pusha        ;DS:DX = file name, CX = attr
    mov ax,4301h    ;4300 for attr read => cx ... change push/pop
    int 21h        ;        7 6 5 4 3 2 1 0
    mov bl,0    ;cx = attr:     0 0 A 0 0 S H R
    jnc fattr0
    mov bl,al
fattr0:    mov [cs:ferr],bl
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;