;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             
; Pre- main entry directives : 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             

org 100h    ; The code below will be placed at this location 
            ; within the memory layout of the process. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             
;
; Memory segment : 
;
;  @   0h : Program Segment Prefix (PSP) in a DOS .COM file
;            . environment variables 
;            . other info 
;
;  @ 100h : the OFFSET within the process layout 
;           where the code segment is to be situated 
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             


; The interrupt you send will dictate the context of execution.
;
; int 10h is for video/console services. 


mov ah, 0eh  ; display char on the console
mov al, 'A'  ; input char goes here 
int 10h      ; interrupt vector for video / console

ret          ; exit point 