    .MODEL small                        ; For a .EXE file
    .STACK 256

    .CODE

Start:
    ; Write the "A" to the screen, using Interrupt 10 hex, Service 0A hex:
    MOV AH, 0Ah                        ; Interrupt service number 0A hex
    MOV AL, 65                         ; 65 dec is the ASCII code for "A"
    MOV BH, 0                          ; Screen page is 0 (default)
    MOV CX, 1                          ; Write one character only
    INT 10h                            ; Call the interrupt service and
                                       ;  write the "A" to the screen

    ; Exit the program:
    MOV AX, 4C00h                      ; Interrupt service number 4C hex,
                                       ;  return error code 0
    INT 21h                            ; Call interrupt service to end the
                                       ;  program

END Start                              ; Begin execution at label "Start:"

