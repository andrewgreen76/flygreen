
	;; System calls : 
	mov eax , 0 		;; invalid ; undefined behavior 
	mov eax , 1 		;; sys_exit 
	mov eax , 2 		;; sys_fork  
	mov eax , 3 		;; sys_read  
	mov eax , 4 		;; sys_write 
	mov eax , 5 		;; sys_open 
	mov eax , 6 		;; sys_close 
	mov eax , 7 		;; sys_waitpid 
	mov eax , 8 		;; sys_mount 
	mov eax , 9 		;; sys_write 
	
	int 0x80

_
