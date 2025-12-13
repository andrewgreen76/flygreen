    .global _start
_start:
    mov $60, %rax    # exit
    xor %rdi, %rdi   # status 0
    syscall
