section .data
    num1    db 10      ; First number (byte)
    num2    db 20      ; Second number (byte)
    result  dw 0       ; Result (word, initialized to 0)

section .text
    global _start     ; Entry point for linking

_start:
    ; Load first number into AX
    mov al, byte [num1]

    ; Add second number to AX
    add al, byte [num2]

    ; Store result in memory
    mov word [result], ax

    ; Print the result
    ; For simplicity, use BIOS interrupt to print result in DOSBox
    mov ah, 0x09        ; BIOS print string function
    mov dx, result_str  ; DX points to string to print
    int 0x21            ; Call BIOS interrupt

    ; Exit program
    mov ah, 0x4c        ; DOS exit function
    int 0x21            ; Call DOS interrupt

section .data
    result_str db "Result: ", 0
