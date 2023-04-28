.model  small
.stack 

stack segment para stack
    db 64 dup (' ')
stack ends
data segment
data ends
code segment
    assume cs:code,ds:data,ss:stack
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
    
    ; 320x200 mode 13h
    mov ah,00h
    mov al,13h
    int 10h
    
    ;draw a red pixel at col 160, row 100: 
    mov ah,0ch
    mov cx,160
    mov dx,100
    mov al,4
    int 10h
    
    ;draw a red pixel at col 160, row 100: 
    mov ah,0ch
    mov cx,161
    mov dx,100
    mov al,4
    int 10h
    
    ;draw a red pixel at col 160, row 100: 
    mov ah,0ch
    mov cx,160
    mov dx,101
    mov al,4
    int 10h
    
    ;draw a red pixel at col 160, row 100: 
    mov ah,0ch
    mov cx,161
    mov dx,101
    mov al,4
    int 10h
    
    ;wait for a key press
    mov ah,00h
    int 16h
    
    ;set back to text mode - 03h
    mov ah,00h
    mov al,03h
    int 10h
    
    ;term
    mov ah,4ch
    int 21h
    
code ends
end