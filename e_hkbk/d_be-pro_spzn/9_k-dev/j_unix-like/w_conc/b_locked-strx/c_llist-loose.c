void List_Init(list_t *L) {
    L->head = NULL;
    pthread_mutex_init(&L->lock, NULL);
}

// ============== Locked insertion : ===============
void List_Insert(list_t *L, int key) {
    // synchronization not needed
    node_t *new = malloc(sizeof(node_t));
    if (new == NULL) {
	perror("malloc");
	return; // ok to ret w/ nothing 
    }
    
    new->key = key;
    
    // just lock critical section
    pthread_mutex_lock(&L->lock);
    new->next = L->head;
    L->head = new;
    pthread_mutex_unlock(&L->lock);
}

// ============== Confirms presence : ==============
int List_Lookup(list_t *L, int key) {
    int rv = -1;
    pthread_mutex_lock(&L->lock);
    node_t *curr = L->head;
    
    while (curr) { // traverse entire list 
	if (curr->key == key) {
	    rv = 0; // checks out 
	    break;
	}
	curr = curr->next;
    }
    
    pthread_mutex_unlock(&L->lock);
    return rv; // now both success and failure
}
