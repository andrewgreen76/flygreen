/*
  . a lock per bucket (rather than a lock for the entire hash table) : 
     . allows for concurrent hashing and access 
*/

#define BUCKETS (101)

typedef struct __hash_t {
list_t lists[BUCKETS];
} hash_t;

void Hash_Init(hash_t *H) {
int i;
for (i = 0; i < BUCKETS; i++)
List_Init(&H->lists[i]);
}

int Hash_Insert(hash_t *H, int key) {
return List_Insert(&H->lists[key % BUCKETS], key);
}

int Hash_Lookup(hash_t *H, int key) {
return List_Lookup(&H->lists[key % BUCKETS], key);
}
