#include <stdio.h>
#include "queue.h"

int main(){
  printf("\n");
  queue_t q;
  q_init(&q);

  q_enq(&q, 2);
  q_enq(&q, 5);
  q_enq(&q, -3);
  q_traverse(&q);
  
  q_kill(&q);
  printf("\n");
}
