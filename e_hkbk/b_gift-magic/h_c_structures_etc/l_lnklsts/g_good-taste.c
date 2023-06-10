/* Method here: 
       using NO extra pointers to trace the list and remove the target node.
   Specs:
       The "entry" here is actually a pointer to / addr of the node we want to remove.
   Lessons: 
       fwd = &obj       how you load addr of obj
       fwd = sndFwd     how you copy addr of obj from ptr to ptr
       fwd !=           how you invoke the addr in ptr 
           = sndFwd     how you invoke the addr in ptr
	   = node.next  how you invoke the addr of the next node     GIVEN THE SPECD NODE. 
	   = *(fwd.next)  how you invoke the addr of the next node   GIVEN THE PTR TO THE SPECD NODE. 
	   = fwd->next  how you invoke the addr of the next node   GIVEN THE PTR TO THE SPECD NODE. 
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
  struct Node * target = &s;

  // Method 2: 
  struct Node ** indirect = &head; // indirect holds addr of head_ptr // holds addrs of ptrs

  while((*indirect) != target)  // while the addr(indir_ptd_obj/head) is not addr(targeted_obj)
    // indirect = &(*indirect)->next;  // take   
    indirect = &(*indirect)->next;  // take   
    
  // And .. remove
  *indirect = target->next;
  
  //   
  printf("\nDone.\n\n");
  return 0; 
}
