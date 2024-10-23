#include<stdio.h>
#include<stddef.h>

char memory[20000];

struct block{
 size_t size;
 int free;
 struct block *next; 
};

struct block * freeList = (void*)memory;

void initialize();
void split(struct block * fitting_slot , size_t size);
void *MyMalloc(size_t noOfBytes);
void merge();
void MyFree(void* ptr);



int main(void) {
  printf("\n");

  initialize();
  
  printf("\n");
}



void initialize(){
 freeList->size = 20000-sizeof(struct block);
 freeList->free = 1;
 freeList->next = NULL;
}
