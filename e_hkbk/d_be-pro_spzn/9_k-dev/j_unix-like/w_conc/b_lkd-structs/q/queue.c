// Code by Michael and Scott (OK per Patrick Ester). 
// 
// A lock for the head and a lock for the tail of the queue.
//  . hybrid of single-lock and coupling methods 
//  . allows for an efficient CONCURRENT two-lock ENQUEUING AND DEQUEUING 

#include <stdlib.h>
#include <assert.h>
#include "queue.h"

void queue_init(queue_t *q) {
    node_t *tmp = malloc(sizeof(node_t)); // dummy node for queue to have 
    tmp->next = NULL;
    q->head = q->tail = tmp;
    pthread_mutex_init(&q->head_lock, NULL);
    pthread_mutex_init(&q->tail_lock, NULL);
}


// this Q impl :
//  . head->node->...->node->tail ,    not    head<-node<-...<-node<-tail
//  . insert at the tail 
void queue_enqueue(queue_t *q, int value) {
    node_t *tmp = malloc(sizeof(node_t));
    assert(tmp != NULL); // abort if malloc failed 
    tmp->value = value;
    tmp->next = NULL;

    pthread_mutex_lock(&q->tail_lock);
    q->tail->next = tmp; // tie new node to old tail 
    q->tail = tmp;       // announce new node as new tail 
    pthread_mutex_unlock(&q->tail_lock);
}


// this Q impl :
//  . head->node->...->node->tail ,    not    head<-node<-...<-node<-tail
//  . remove at the head
//  . rets SUCCESS / FAILURE
int queue_dequeue(queue_t *q, int *value) {
    pthread_mutex_lock(&q->head_lock); 
    node_t *tmp = q->head;                        // head -> (nnnn) <- tmp
    node_t *new_head = tmp->next;                 //           |
                                                  //           v
    if (new_head == NULL) {                       //  new -> NEW_HD
	pthread_mutex_unlock(&q->head_lock);      //           |
	return -1; // queue was empty             //           v 
    }                                             
    
    *value = new_head->value; // GET NEW_HEAD->VAL VIA ARG 
    q->head = new_head;
    pthread_mutex_unlock(&q->head_lock);
    free(tmp); // now remove old head 
    return 0;
}
