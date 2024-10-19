global _start     ; Declare '_start' as a global symbol

section .text     ; Define the text (code) section
_start:           ; Entry point of the program

    ; Initialize registers in 16-bit mode
    mov ax, 213   ; Move immediate value 213 into ax (16-bit register)
    add ax, 432   ; Add immediate value 432 to ax

    ; Terminate the program
    mov ah, 0x4c  ; DOS exit function code
    int 0x21      ; Call DOS interrupt to terminate the program
