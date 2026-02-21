
	;; 1. Register addressing mode:
	mov eax, ebx ; Move the contents of the ebx register into the eax register

        ;; 2. Immediate addressing mode:
	mov eax, 123 ; Move the immediate value 123 into the eax register
	
	;; 3. Direct addressing mode:
	mov eax, [0x12345678] ; Move the contents of the memory address 0x12345678 into the eax register

	;; 4. (Register) indirect addressing mode:	
	mov eax, [ebx] ; Move the contents of the memory address stored in the ebx register into the eax register

	;; 5. Indexed addressing mode:
	mov eax, [ebx + 8] ; Move the contents of the memory address at ebx + 8 bytes into the eax register

	;; 6. Base addressing mode:
	mov eax, [ecx + 16] ; Move the contents of the memory address at ecx + 16 bytes into the eax register

	;; 7. Scaled addressing mode:
	mov eax, [ecx + ebx*4] ; Move the contents of the memory address at ecx + (ebx * 4) bytes into the eax register

	;; These are basic examples and the actual instructions and operands used may vary
	;; depending on the specific context and requirements of the program.
	
	;; 
