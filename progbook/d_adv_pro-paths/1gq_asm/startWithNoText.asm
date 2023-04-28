org 100h      ; origin ? ...    

mov ch, 32     ; 0010 0000 0000 0000 b of CX. 
mov ah, 1      ; 0000 0001 0000 0000 b of ACC. So, no blinking.  
                
int 10h       ; signal to enact ; video svc BIOS interrupt (for video mode, 

mov ax, 1003h ; al = 3 - blinking; 0001 0000 0000 0011 b of ACC.  
mov bx, 0     ; bx = 0 -           0000 0000 0000 0000 b of B - no offset. 
int 10h

mov     ax, 0b800h  ; universal addr for string-to-print. "I'm a string" 
mov     ds, ax     ; load 2048d, to where data elements are stored. 
mov [00h], 'H'
mov ah, 0 ; 0000 0000 xxxx xxxx - expecting 1 kbd prs. 
          ; ah = 1+ - kbd prs regd.  
int 16h ; PC kbd svcs. 

ret

