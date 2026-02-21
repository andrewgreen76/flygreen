/* Method here: 
       using an extra pointer to trace the list and remove the target node.
   Specs:
       The "entry" here is actually a pointer to / addr of the node we want to remove.
   Lessons: 
       fwd = &obj       how you load addr of obj
       fwd = sndFwd     how you copy addr of obj from ptr to ptr
       fwd !=           how you look up the addr in ptr 
           = sndFwd     how you look up the addr in ptr
	   = node.next  how you look up the addr of the next node     GIVEN THE SPECD NODE. 
	   = *(fwd.next)  how you look up the addr of the next node   GIVEN THE PTR TO THE SPECD NODE. 
	   = fwd->next  how you look up the addr of the next node   GIVEN THE PTR TO THE SPECD NODE. 
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

  // Method 1: 
  struct Node * prev = NULL;
  struct Node * walk = head;

  while(walk != tgtAddr){
    prev = walk;
    walk = walk->next; // ?? not walk.next ??
  }

  if(!prev)  // if prev was not assigned, meaning: if the 1st node is the target node "s". 
    head = tgtAddr->next;
  else   // if "s" is not the 1st node: 
    prev->next = tgtAddr->next;
  // Automatic storage duration. 
  
  printf("\nDone.\n\n");
  
  //   
  return 0; 
}
