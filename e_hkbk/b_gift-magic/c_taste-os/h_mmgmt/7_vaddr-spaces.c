/*
Address space :
. program code
  . vaddr of program = addr of main 
. stack (vars, args, return values)
  . contains static data , but can grow and shrink throughout the life of the process
  . PROCESS STATE : the stack can be used to store the state of the process 
  . user stack
  . kernel stack 
  . vaddr of stack = addr of 1st static var 
. heap (think malloc() / free() )
  . vaddr of heap = addr of 1st malloc'd var 

========================================================================================================================

. %p - returns the virtual address
. the actual address is only known to the OS and HW
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
*/
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    printf("virtual address of the code : %p\n", main);
    printf("virtual address of the heap : %p\n", malloc(100e6));
    int x = 3; // create a value on the stack
    printf("virtual address of the stack: %p\n", &x);
    return 0;
}
/*
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

*/
