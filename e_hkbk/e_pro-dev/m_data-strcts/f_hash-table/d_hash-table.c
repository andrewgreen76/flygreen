#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define the size of the hash table
#define TABLE_SIZE 10

// Structure to represent a key-value pair
struct KeyValue {
    char key[20];
    int value;
    struct KeyValue *next;  // Pointer to the next key-value pair in case of collisions
};

// Structure to represent the hash table
struct HashTable {
    struct KeyValue *table[TABLE_SIZE];
};

// Hash function to convert a key into an index
unsigned int hashFunction(const char *key) {
    unsigned int hash = 0;
    for (int i = 0; key[i] != '\0'; i++) {
        hash = hash * 31 + key[i];
    }
    return hash % TABLE_SIZE;
}

// Initialize the hash table
void initializeHashTable(struct HashTable *hashTable) {
    for (int i = 0; i < TABLE_SIZE; i++) {
        hashTable->table[i] = NULL;
    }
}

// Insert a key-value pair into the hash table
void insert(struct HashTable *hashTable, const char *key, int value) {
    unsigned int index = hashFunction(key);

    // Create a new key-value pair
    struct KeyValue *newPair = (struct KeyValue *)malloc(sizeof(struct KeyValue));
    if (newPair == NULL) {
        fprintf(stderr, "Memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }
    strcpy(newPair->key, key);
    newPair->value = value;
    newPair->next = NULL;

    // Insert the new pair at the beginning of the linked list in the corresponding bucket
    newPair->next = hashTable->table[index];
    hashTable->table[index] = newPair;
}

// Search for a key in the hash table and return its corresponding value
int search(struct HashTable *hashTable, const char *key) {
    unsigned int index = hashFunction(key);

    // Search for the key in the linked list at the corresponding bucket
    struct KeyValue *current = hashTable->table[index];
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            return current->value;
        }
        current = current->next;
    }

    // Key not found
    return -1;
}

// Delete a key-value pair from the hash table
void delete(struct HashTable *hashTable, const char *key) {
    unsigned int index = hashFunction(key);

    // Delete the key-value pair from the linked list at the corresponding bucket
    struct KeyValue *current = hashTable->table[index];
    struct KeyValue *prev = NULL;

    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            if (prev == NULL) {
                // If the target pair is the first in the list
                hashTable->table[index] = current->next;
            } else {
                prev->next = current->next;
            }

            // Free the memory allocated for the deleted pair
            free(current);
            return;
        }

        prev = current;
        current = current->next;
    }
}

// Destroy the hash table and free all allocated memory
void destroyHashTable(struct HashTable *hashTable) {
    for (int i = 0; i < TABLE_SIZE; i++) {
        struct KeyValue *current = hashTable->table[i];
        while (current != NULL) {
            struct KeyValue *next = current->next;
            free(current);
            current = next;
        }
    }
}

int main() {
    struct HashTable myHashTable;
    initializeHashTable(&myHashTable);

    // Insert key-value pairs
    insert(&myHashTable, "apple", 5);
    insert(&myHashTable, "banana", 8);
    insert(&myHashTable, "orange", 12);

    // Search for values using keys
    printf("Value for 'apple': %d\n", search(&myHashTable, "apple"));
    printf("Value for 'banana': %d\n", search(&myHashTable, "banana"));
    printf("Value for 'orange': %d\n", search(&myHashTable, "orange"));

    // Delete a key-value pair
    delete(&myHashTable, "banana");

    // Search again after deletion
    printf("Value for 'banana' after deletion: %d\n", search(&myHashTable, "banana"));

    // Destroy the hash table
    destroyHashTable(&myHashTable);

    return 0;
}
