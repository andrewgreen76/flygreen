// A lock for the head and a lock for the tail of the queue.
//  . concurrent enqueuing and dequeuing 

typedef struct __node_t {
    int value;
    struct __node_t *next;
} node_t;


typedef struct __queue_t {
    node_t *head;
    node_t *tail;
    pthread_mutex_t head_lock, tail_lock;
} queue_t;


void queue_init(queue_t *q) ;
void queue_enqueue(queue_t *q, int value) ;
int queue_dequeue(queue_t *q, int *value) ;
