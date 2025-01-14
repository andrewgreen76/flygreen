// A lock for the head and a lock for the tail of the queue.
//  . concurrent enqueuing and dequeuing

#ifndef QUEUE_H
#define QUEUE_H

#include <stdio.h>
#include <pthread.h>

typedef struct __node_t {
    int value;  
    struct __node_t *next;
} node_t;


typedef struct __queue_t {
    node_t *head;
    node_t *tail;
    pthread_mutex_t head_lock, tail_lock;
} queue_t;


void q_init(queue_t *q) ;
void q_enq(queue_t *q, int value) ;
int q_deq(queue_t *q, int *value) ;
void q_traverse(queue_t *q);
void q_kill(queue_t *q);

#endif
