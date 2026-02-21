/* Method here: 
       using NO extra pointers to trace the list and remove the target node.
   Specs:
       The "entry" here is actually a pointer to / addr of the node we want to remove.
   Lessons: 
       fwd = &obj       how you load addr of obj
       fwd = sndFwd     how you copy addr of obj from ptr to ptr
       fwd !=           how you look up the addr in ptr 
           = sndFwd     how you look up the addr in ptr
	   = node.next  how you look up the addr of the next node     GIVEN THE SPECD NODE. 
	   = *(fwd.next)  how you look up the addr of the next node   GIVEN THE PTR TO THE SPECD NODE. 
	   = fwd->next    how you look up the addr of the next node   GIVEN THE PTR TO THE SPECD NODE. 
       * ptr - for sitting on nodes
       ** ptr - for sitting on pointers 
*/

#include "stdio.h"

struct Node{
  struct Node * next;
};

int main()
{
  // Making sure that it runs: 
  printf("\nHello, world!\n\n");

  // Build the linked list: 
  struct Node t;
  t.next = NULL;
  struct Node s;
  s.next = &t;
  struct Node f;
  f.next = &s;
  struct Node * head = &f;
  struct Node * tgtAddr = &s; 

  // Method 2: 
  struct Node ** indirect = &head; // indirect holds addr of head_ptr // holds addrs of ptrs
  // i
  //  h> f -> s -> t

  while((*indirect) != tgtAddr)  // Sitting on a pointer, deref it. Does that pointer have the target address? 
    // indirect = &(*indirect)->next;  // take   
    indirect = &(*indirect)->next;
    // take   addr of cur_ptr, deref to node, focus on next_ptr, get addr of next_ptr, move indirect there. 
    
  *indirect = tgtAddr->next; // Take the addr of next, load into the sat-on ptr. 
  // Automatic storage duration. 
  
  //   
  printf("\nDone.\n\n");
  return 0; 
}
