   DOSSEG
   .MODEL  SMALL
   .STACK  100h
   .DATA
   .CODE

; Place your program in the area provided below. Your
; program should assume that the x86 has no multiply
; function. Multiply value in AL by the value in AH
; and return the result in the combined register AX.
; DO NOT MODIFY ABOVE THIS LINE!!!!!!!!!!!


; no blinking / hide blinking text cursor.                   
mov ch, 32     ; 0010 0000 0000 0000 b of CX. 
mov ah, 1      ; 0000 0001 0000 0000 b of ACC. So, no blinking.  

; "Boxed" - square coverage:                                                
;mov ch, 0      ; 0000 0000 0000 0000 b of CX. 
;mov cl, 7      ; 0000 0000 0000 0111 b of CX. 
;mov ah, 1      ; 0000 0001 0000 0000 b of ACC. 
                
int 10h       ; signal to enact ; video svc BIOS interrupt (for video mode, 
                ; char/str out, rd/wrt pxls in gfx mode, etc.) 
                ; loads in settings in sequence: video, blinking, colors, etc. 
                
                  

; ============= cancel blinking and enable all 16 colors: ? =================
mov ax, 1003h ; al = 3 - blinking; 0001 0000 0000 0011 b of ACC.  
mov bx, 0     ; bx = 0 -           0000 0000 0000 0000 b of B - no offset. 
int 10h


; set segment register: ? ... 
mov     ax, 0b800h  ; universal addr for string-to-print. "I'm a string" 
;Anyway, the code for "I" would be at B800:0000 - 73 ASCII [49h]
;The code for apostrophe would be at B800:0002 - 39 ASCII [27h]
                   ; Can't load into seg reg w/ imdt value. 0x0000 1000 0000 0000 = 2048d. 
                   ; 0000 1000 0000 0000 b ACC = 2048d. 
                   ; 0b800h - seg selector. 1 seg=(64KB)x1000B/KB x 8b/1B = 512000b. Not 524000b?
                   ; 0000
                   ; 1000
                   ; 0000
                   ; 0000
mov     ds, ax     ; load 2048d, to where data elements are stored. 
    ; pointer; points to seg of data used by program.  


; print "Hello, World!"
; first byte (even byte) is ascii code , second byte (odd byte) is color code .
;
mov [00h], 'H'


; color all characters:
;mov cx, 13  ; number of characters. FOR-loop, anybody ? 
;mov di, 01h ; start from color comp byte after 'H'. di is addr, di = 01h. Start index. 
;
;c:  mov [di], 00001111b   ; vvvvxxxx (h bits) - bkgd, xxxxvvvv (l bits) - frgd
;    add di, 2 ; skip over next ascii code in vga memory.
;    loop c

; wait for any key press:
mov ah, 0 ; 0000 0000 xxxx xxxx - expecting 1 kbd prs. 
          ; ah = 1+ - kbd prs regd.  
int 16h ; PC kbd svcs. 




; DO NOT MODIFY BELOW THIS LINE!!!!!!!!!!!

   mov  ah,4ch        ;DOS terminate program function #
   int  21h           ;terminate the program
   END