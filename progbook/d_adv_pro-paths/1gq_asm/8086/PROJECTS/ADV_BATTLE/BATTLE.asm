mx    equ 256
my    equ 256
ox    equ 104
oy    equ 104

    .386P
    IDEAL
    MODEL tiny

    DATASEG
mems:
msg    db '0  Start game.',0
    db '1  Read info.',0
    db '2  Redefine keyboard.',0
    db '3  Exit to DOS.',0
    db 'SPEKTRA software & hardware presents:  Battle zone.',0
    db 'ver: 2.0  x.4.1999  N.DCA SR',0
    db 'Defined keys: ',0
msg1    db 5
    db 'Battle zone.',13,13
    db 'This is only a test version. The full version will be done soon.',13
    db 'It will be slower, but the map will be larger!!! (min 768*256)',13
    db 'Sound Blaster owners will have sound durring game.',13
msg2    db 'Player',0
    db 'Left  ',0
    db 'Right ',0
    db 'Up    ',0
    db 'Down  ',0
    db 'Fire  ',0
msg2a   db 'WARNING: do not use the extended keys of 101-keys keyboard'
    db ' ie: End,arrows,...',0
msg2b    db 'Press any key to continue.',0

keyn    db  0,0                ;keyscan, keycode
    db  1,1
    db  2,'1'
    db  3,'2'
    db  4,'3'
    db  5,'4'
    db  6,'5'
    db  7,'6'
    db  8,'7'
    db  9,'8'
    db 10,'9'
    db 11,'0'
    db 12,'_'
    db 13,'+'
    db 14,27    ;backspace
    db 15,29
    db 16,'Q'
    db 17,'W'
    db 18,'E'
    db 19,'R'
    db 20,'T'
    db 21,'Y'
    db 22,'U'
    db 23,'I'
    db 24,'O'
    db 25,'P'
    db 26,'{'
    db 27,'}'
    db 28,1        ;enter
    db 29,1
    db 30,'A'
    db 31,'S'
    db 32,'D'
    db 33,'F'
    db 34,'G'
    db 35,'H'
    db 36,'J'
    db 37,'K'
    db 38,'L'
    db 39,':'
    db 40,'"'
    db 41,'~'
    db 42,24
    db 43,'\'
    db 44,'Z'
    db 45,'X'
    db 46,'C'
    db 47,'V'
    db 48,'B'
    db 49,'N'
    db 50,'M'
    db 51,'<'
    db 52,'>'
    db 53,'?'
    db 54,24
    db 55,'*'
    db 56,1
    db 57,' '
    db 58,1
    db 59,1
    db 60,1
    db 61,1
    db 62,1
    db 63,1
    db 64,1
    db 65,1
    db 66,1
    db 67,1
    db 68,1
    db 69,1
    db 70,1
    db 71,'7'
    db 72,'8'
    db 73,'9'
    db 74,'-'
    db 75,'4'
    db 76,'5'
    db 77,'6'
    db 78,'+'
    db 79,'1'
    db 80,'2'
    db 81,'3'
    db 82,'0'
    db 83,'.'    ;delete
    db 87,1
    db 88,1
    db,255
keye    db 28,1        ;enter
    db 29,1
    db 42,1
    db 53,'/'
    db 55,1
    db 56,1
    db 71,1
    db 72,30
    db 73,1
    db 75,17
    db 77,16
    db 79,1
    db 80,31
    db 81,1
    db 82,1
    db 83,1        ;delete
    db,255

key    db 0,0,0            ;keyscan (word), key code(call keys)
fil0    db 'battle.gfx',0
fil1    db 'battle.lvl',0
gfx    db 9216 dup (?)
pal    db 768 dup (?)
car1    db 256 dup (?)
car2    db 256 dup (?)
car3    db 256 dup (?)
lvl    db mx*my/256 dup (?)
carx    dw ?,?,?
cary    dw ?,?,?
plk1    db 33 dup (?)            ;redefine (w), status keys (5 bit)
maps    dw ?

    CODESEG
    STARTUPCODE
    jmp main

    include 'file.inc'
    include 'text.inc'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Interrupts: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int09:    cli                ;keyboard ... sets keyscan a
    pushf                ;        key result pl.1,2,3
    pusha
    push ds
    mov ds,[cs:dss]
    in al,60h
    sub ah,ah
    mov [word ptr key],ax
    in al,61h
    mov ah,al
    or al,80h
    out 61h,al
    xchg al,ah
    out 61h,al
    mov al,20h
    out 20h,al
    mov al,[key]        ;handle extended keyscan
    cmp al,224
    jnz i09r0
    mov [key+1],al
    in al,60h
    mov [key],al
    in al,61h
    mov ah,al
    or al,80h
    out 61h,al
    xchg al,ah
    out 61h,al
    mov al,20h
    out 20h,al
i09r0:  mov ax,[word ptr key]
    lea si,[plk1]                ;set keyresult if hit
    lea di,[plk1+10]
    mov cx,3
i09p1x:    push cx
    mov dl,1
    mov cx,5
i09p10:    cmp ax,[ds:si]
    jz i09p11
    inc si
    inc si
    add dl,dl
    loop i09p10
    jmp i09p12
i09p11: or [ds:di],dl
i09p12: pop cx
    inc si
    add di,11
    loop i09p1x
    test al,128                ;res keyresult if drop
    jz i09r2
    and al,127
    lea si,[plk1]
    lea di,[plk1+10]
    mov cx,3
i09p2x:    push cx
    mov dl,1
    mov cx,5
i09p20:    cmp ax,[ds:si]
    jz i09p21
    inc si
    inc si
    add dl,dl
    loop i09p20
    jmp i09p22
i09p21: sub [ds:di],dl
i09p22: pop cx
    inc si
    add di,11
    loop i09p2x
i09r2:    mov al,[key]                ;if no key then keyscan = 0
    and al,128
    jz i09r1
    sub al,al
    mov [key],al
i09r1:    pop ds
    popa
    popf
    sti
    iret
    dss    dw 0
    oint09     dw 0,0                ;old vector adress
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Subroutines: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
keys:    pusha                    ;set keycode of ax key
    lea si,[keyn]
    mov bl,2
    sub cl,cl
    or ah,ah
    jz keyl0
    lea si,[keye]
keyl0:    mov ah,[ds:si]
    cmp ah,255
    jz keyre
    cmp al,ah
    jz keyr0
    inc si
    inc si
    jmp keyl0
keyr0:  inc si
    mov bl,[ds:si]
keyre:    mov [key+2],bl
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ikey:     mov ax,[word ptr key]            ;ax = keyscan pressed key
    or ax,ax
    jnz ikey
ikeyl0: mov ax,[word ptr key]
    or al,al
    jz ikeyl0
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
txtcls:    pusha
    mov di,0
    mov al,32
txtcls0:mov [es:di],al
    inc di
    inc di
    cmp di,80*25*2
    jnz txtcls0
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Main program: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main:    mov [cs:dss],ds
    mov al,9h        ;install keyboard int
    mov ah,35h
    int 21h
    mov [oint09],bx
    mov [oint09+2],es
    mov al,9h
    mov ah,25h
    lea dx,[int09]
    int 21h

open:    lea dx,[fil0]                ;load gfx
    call fopen
    lea dx,[gfx]
    mov cx,9984
    call fread
    call fclose

    mov ax,cs                ;relocate memory
    mov es,ax
    mov bx,8192
    mov ah,4Ah
    int 21h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
begin:    mov ax,3                ;main window
    int 16

    lea dx,[fil1]                ;load level
    call fopen
    lea dx,[lvl]
    mov cx,mx*my/256+12+33
    call fread
    call fclose

    mov ah,2
    mov bh,0
    mov dx,25*256
    int 16
    mov ax,0B800h
    mov es,ax
    lea si,[msg]
    mov di,2*(31+08*80)
    call print
    mov di,2*(31+10*80)
    call print
    mov di,2*(31+12*80)
    call print
    mov di,2*(31+14*80)
    call print
    mov di,2*(15+1*80)
    call print
    mov di,2*(24+2*80)
    call print
    mov di,2*(8+19*80)
    call print
    lea si,[plk1]
    mov cx,3
beginl1:push cx
    add di,4
    mov ax,[ds:si]
    call keys
    mov al,[key+2]
    mov [es:di],al
    inc si
    inc si
    add di,8
    mov ax,[ds:si]
    call keys
    mov al,[key+2]
    mov [es:di],al
    inc si
    inc si
    sub di,4+320
    mov ax,[ds:si]
    call keys
    mov al,[key+2]
    mov [es:di],al
    inc si
    inc si
    add di,640
    mov ax,[ds:si]
    call keys
    mov al,[key+2]
    mov [es:di],al
    inc si
    inc si
    sub di,320
    mov ax,[ds:si]
    call keys
    mov al,[key+2]
    mov [es:di],al
    inc si
    inc si
    add di,20
    inc si
    pop cx
    loop beginl1
beginl0:mov ax,[word ptr key]
    cmp ax,1
    jz ende
    call keys
    mov al,[key+2]
    cmp al,'0'
    jz game
    cmp al,'1'
    jz info
    cmp al,'2'
    jz redef
    cmp al,'3'
    jz ende
    jmp beginl0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
redef:     call txtcls            ;Redefine window
    mov di,2*(0+01*80)
    lea si,[msg2a]
    call print
    push si
    mov cx,3
    lea bx,[plk1]
    mov di,2*(4+04*80)
redefl1:lea si,[msg2]
    push cx
    push di
    call print
    mov al,'4'
    sub al,cl
    mov [es:di],al
    inc di
    inc di
    mov al,':'
    mov [es:di],al
    add di,4
    mov cx,5
redefl0:push di
    call print
    call ikey
    mov [ds:bx],ax
    call keys
    mov al,[key+2]
    mov [es:di],al
    inc bx
    inc bx
    pop di
    add di,160
    loop redefl0
    pop di
    add di,44
    inc bx
    pop cx
    loop redefl1
    pop si
    mov di,2*(25+16*80)
    call print
    call ikey
redefr0:mov ax,[word ptr key]
    or ax,ax
    jnz redefr0
    cli
    sub al,al            ;delete directions
    mov [cs:plk1+10],al
    mov [cs:plk1+21],al
    mov [cs:plk1+32],al
    sti
    lea dx,[fil1]            ;save redef
    call fopen
    lea dx,[lvl]
    mov cx,mx*my/256+12+33
    call fwrite
    call fclose
    jmp begin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
info:    call txtcls            ;info window
    mov di,2*(0+01*80)
    lea si,[msg1+1]
    mov cl,[msg1]
    sub ch,ch
infol0: push cx
    call print
    pop cx
    loop infol0
    lea si,[msg2b]
    mov di,2*(25+24*80)
    call print
    call ikey
infor0: mov ax,[word ptr key]
    or ax,ax
    jnz infor0
    jmp begin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Main window: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mapi:    pusha
    push es
    mov es,[maps]
    sub di,di
    lea bx,[lvl]
    lea si,[gfx]
    sub al,al
    mov cx,my/16
mapl3:    push cx
    mov cx,mx/16
mapl2:    push cx
    push si
    mov ah,[ds:bx]
    add si,ax
    mov cx,16
mapl1:    push cx
    mov cx,4
    rep movsd
    add di,mx-16
    pop cx
    loop mapl1
    pop si
    sub di,16*mx-16
    inc bx
    pop cx
    loop mapl2
    add di,15*mx
    pop cx
    loop mapl3
    pop es
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
car:    pusha                    ;ax=direction es:di=map posiotion ch=car
    push es
    lea si,[gfx+7168]
    add si,ax
    lea bx,[car1-256]
    sub cl,cl
    add bx,cx
    mov cx,16
    mov dl,15
carl1:    push cx
    mov cx,16
carl0:  mov al,[ds:si]
    mov ah,[es:di]
    mov [cs:bx],ah
    cmp al,dl
    jz carx0
    mov [es:di],al
carx0:    inc bx
    inc si
    inc di
    loop carl0
    add di,mx-16
    pop cx
    loop carl1
    pop es
    popa
    ret
cart:    db 255,0,4,255,2,1,3,255,6,7,5,255,255,255,255,255
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
carz:    pusha                    ;es:di=map position ch=car
    push es
    lea si,[car1-256]
    sub cl,cl
    add si,cx
    mov cx,16
carzl1:    push cx
    mov cx,16
carzl0:    mov al,[cs:si]
    mov [es:di],al
    inc si
    inc di
    loop carzl0
    add di,mx-16
    pop cx
    loop carzl1
    pop es
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
carn1:    pusha            ;bx = [plk1 +...] cx =[cary] dh=pl
    push es
    push ds
    push di
    mov al,[cs:bx]
    and al,15
    lea bx,[cart]
    xlatb
    xchg al,ah
    sub al,al
    mov bx,cx
    cmp ah,255
    jz carn1e
    mov di,[cs:bx]
    mov es,[maps]
    mov ch,dh
    call carz
    sub bx,6
    mov di,[cs:bx]        ;player

xxx:    pusha
    mov ah,1
    mov ch,16
crnl1:  mov cl,16
crnl0:    mov al,[es:di]
    or al,al
    jnz crnrx
    sub ah,ah
crnrx:    inc di
    dec cl
    jnz crnl0
    add di,256-16
    dec ch
    jnz crnl1
    or ah,ah
    jnz crnry
    mov ax,[cs:bx+6]
    mov [cs:bx],ax
crnry:    popa
    mov di,[cs:bx]

    call car
    mov ax,[cs:bx]
    add bx,6
    mov [cs:bx],ax
    sub bx,6

carn1e:    mov ds,[maps]
    mov ax,[cs:bx]
    sub al,44
    jnc carn1a
    sub al,al
carn1a:    cmp al,152
    jc carn1c
    mov al,152
carn1c:    sub ah,44
    jnc carn1b
    sub ah,ah
carn1b: cmp ah,152
    jc carn1d
    mov ah,152
carn1d:    mov si,ax
    pop di
    call obr
    pop ds
    pop es
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obr:    push ds                ;0A000h:di,ds:si
    push es
    mov ax,0A000h
    mov es,ax
    mov cx,oy
obrl1:    push cx
    mov cx,ox/4
    rep movsd
    pop cx
    add di,320-ox
    add si,mx-ox
    loop obrl1
    pop es
    pop ds
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ctrl:    pusha                  ;controls al,keyresult di=[carx]
    lea bx,[cart]
    push ax
    xlat
    pop bx
    xchg ax,bx
    cmp bl,255
    mov bx,[cs:di]
    jz c13
    mov ah,2        ;step
    test al,1
    jz c10
    sub bl,ah
    jnc c10
    add bl,ah
c10:    test al,2
    jz c11
    add bl,ah
    cmp bl,240
    jc c11
    sub bl,ah
c11:    test al,4
    jz c12
    sub bh,ah
    jnc c12
    add bh,ah
c12:    test al,8
    jz c13
    add bh,ah
    cmp bh,240
    jc c13
    sub bh,ah
c13:    mov [cs:di],bx
    popa
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

game:    mov ax,19        ;game
    int 16

    lea bx,[pal]
    mov dx,3C8h        ;set palete
    mov cl,0
pall0:    mov al,cl
    out dx,al
    inc dx
    mov al,[cs:bx]
    inc bx
    out dx,al
    mov al,[cs:bx]
    inc bx
    out dx,al
    mov al,[cs:bx]
    inc bx
    out dx,al
    dec dx
    inc cl
    jnz pall0

getm:    mov ah,48h
    mov bx,12288
    int 21h
    mov [maps],ax
    jc gerr
    call mapi
    mov es,[maps]
    mov di,[cary]
    mov ax,2*256
    mov ch,1        ;player
    call car
    mov di,[cary+2]
    mov ch,2        ;player
    call car
    mov di,[cary+4]
    mov ch,3        ;player
    call car

gl0:    lea bx,[plk1+10]
    lea cx,[cary]
    mov di,0
    mov dh,1
    call carn1
    lea bx,[plk1+21]
    lea cx,[cary+2]
    mov di,ox+4
    mov dh,2
    call carn1
    lea bx,[plk1+32]
    lea cx,[cary+4]
    mov di,ox+ox+8
    mov dh,3
    call carn1

    mov al,[plk1+10]
    lea di,[carx]
    call ctrl
    mov al,[plk1+21]
    lea di,[carx+2]
    call ctrl
    mov al,[plk1+32]
    lea di,[carx+4]
    call ctrl

    mov ax,[word ptr key]
    cmp ax,1
    jnz gl0

freem:    mov ah,49h
    mov es,[maps]
    int 21h
gamee0:    mov al,[key]
    or al,al
    jnz gamee0
    jmp begin

gerrm    db 'Memory alocation error.',0
gerr:    mov ax,3
    int 16
    sub di,di
    lea si,[gerrm]
    mov ax,0B800h
    mov es,ax
    call print
    jmp gamee0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ende:    push ds            ;uninstall keyboard int
    mov dx,[oint09]
    mov ax,[oint09+2]
    mov ds,ax
    mov al,9h
    mov ah,25h
    int 21h
    pop ds
    mov ax,3
    int 16

    EXITCODE
meme:
    END