
	;; System calls : 
	mov eax , 0 		;; sys_restart_syscall 
	mov eax , 1 		;; sys_exit 
	mov eax , 2 		;; sys_fork
	
	mov eax , 3 		;; sys_read
		mov ebx , 0 
		;; mov ebx , 1 - stdout - cannot be used in the context of reading.
		;; mov ebx , 2 - stderr - cannot be used in the context of reading. 
	
	mov eax , 4 		;; sys_write
		;; mov ebx , 0 - stdin - cannot be used in the context of writing. 
		mov ebx , 1 		; stdout 
		mov ebx , 2 		; stderr 
	
	mov eax , 5 		;; sys_open 
	mov eax , 6 		;; sys_close 
	mov eax , 7 		;; sys_waitpid 
	mov eax , 8 		;; sys_creat 
	mov eax , 9 		;; sys_link
	;;
	mov eax , 332 		;; sys_socketcall

	;; "
	;; You are correct. If there are 333 syscalls in the `int 0x80` interface,
	;; the syscall numbers would range from `0` to `332`. Therefore, `mov eax, 333`
	;; would be invalid, as it exceeds the maximum syscall number defined. The valid
	;; syscall numbers are indeed from `0` to `332` for x86 Linux. Any value beyond
	;; this range, such as `333`, would not correspond to a valid syscall and would
	;; typically result in an error or undefined behavior.
	;; " 
	
	int 0x80

	;; 
