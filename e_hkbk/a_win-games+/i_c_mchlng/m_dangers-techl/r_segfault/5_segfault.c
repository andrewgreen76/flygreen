
// dereferencing a NULL ptr:

int* ptr = NULL; // ptr does NOT hold an address 
*ptr = 42; // deref a no-addr ptr = SEGFAULT 

