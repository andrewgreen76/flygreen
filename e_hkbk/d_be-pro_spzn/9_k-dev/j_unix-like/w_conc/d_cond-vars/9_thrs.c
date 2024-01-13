int buffer;
int full = 0; // initially, empty

// ==================== aux. functions : ====================

void put(int value) {
    assert(full == 0);
    full = 1;
    buffer = value;
}


int get() {
    assert(full == 1);
    full = 0;    // raise "empty" flag 
    return buffer;
}

// =================== THREAD FUNCTIONS : ===================

void *producer(void *arg) {
    int i;
    int loops = (int) arg;
    
    for (i = 0; i < loops; i++) {
        put(i);    // loads into BUFFER
    }
}


void *consumer(void *arg) {
    while (1) {
	int tmp = get();     // rets BUFFER 
	printf("%d\n", tmp);
    }
}
