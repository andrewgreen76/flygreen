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

  // Method 1: 
  struct Node * prev = NULL;
  struct Node * walk = head;

  while(walk != &s){
    prev = walk;
    walk = walk->next; // ?? not walk.next ??
  }

  if(!prev)  // if prev was not assigned, meaning: if the 1st node is the target node "s". 
    head = s.next;
  else   // if "s" is not the 1st node: 
    prev->next = s.next;

  printf("\nDone.\n\n");
  
  //   
  return 0; 
}
