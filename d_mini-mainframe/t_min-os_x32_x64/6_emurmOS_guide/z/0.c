
#include <stdio.h>

struct hpblk_node {
  char hpblk_info;
  struct hpblk_node * next;
};

void main(){
  printf("Size of next pointer : %lu\n" , sizeof(struct hpblk_node *) );
}
