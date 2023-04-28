name "hi-world"

; this example prints out  "hello world!"
; by writing directly to video memory.
; in vga memory: first byte is ascii character, byte that follows is character attribute.
; if you change the second byte, you can change the color of
; the character even after it is printed.
; character attribute is 8 bit value,
; high 4 bits set background color and low 4 bits set foreground color.

; hex    bin        color
; 
; 0      0000      black
; 1      0001      blue
; 2      0010      green
; 3      0011      cyan
; 4      0100      red
; 5      0101      magenta
; 6      0110      brown
; 7      0111      light gray
; 8      1000      dark gray
; 9      1001      light blue
; a      1010      light green
; b      1011      light cyan
; c      1100      light red
; d      1101      light magenta
; e      1110      yellow
; f      1111      white
                   
            
org 100h      ; origin ? ...    




; ACC - 16 bits = 2 bytes; 8 bits = 1 byte; 4 bits = 1 nibble. 
; AX - ACC. For ALU ops; not necessary for use as opc-OPD-opd. 
; BX - Stores the offset, stores addr of data. 
; CX - Counter - for looping and rotation. 
; DX - I/O ops, mult, div.  

; ===================== set video mode (blinking) ========================== 

; std blinking:  
;mov ax, 3     ; 0000 0000 0000 0011 b of ACC - Yes-blinking. 
                ; text mode 80x25, 16 colors, 8 pages (ah=0, al=3), or al = 3 
                ; ah = 0  
                ; 03h - hardcoded setting fixed by designers and implementers. 
                ; Yes-blinking.              
; What's the difference ? 
; Underscore blink: 
;mov ch, 6      ; 0000 0110 0000 0000 b of CX. 
;mov cl, 7      ; 0000 0000 0000 0111 b of CX. 
;mov ah, 1      ; 0000 0001 0000 0000 b of ACC. 

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

ret

