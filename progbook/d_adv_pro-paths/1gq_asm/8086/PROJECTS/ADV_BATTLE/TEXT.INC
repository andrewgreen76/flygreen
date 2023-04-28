;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   TXT mode 3 library:   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kurxy:    pusha        ;dl = column, dh = row    set kursor position
    mov ah,2
    sub bh,bh
    int 16
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print:  push ax        ;DS:SI data => ES:DI screen
    push es
    push 0B800h
    pop es
    mov ah,13
    push di
prnl0:    mov al,[ds:si]
    cmp al,ah
    jz prnr0
    or al,al
    jz prnr1
    mov [es:di],al
prnr0:    inc di
    inc di
    inc si
    cmp al,ah
    jnz prnl0
    pop di
    add di,160            ;next line
    pop es
    pop ax
    ret
prnr1:    pop ax                ;end without ENTER
    inc di
    inc di
    inc si
    pop es
    pop ax
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;