#include <stdio.h>
#include <semaphores.h>
#define MAX 5
sem_t forks[MAX];

// ======================================
int left(int p){
  return p;
}


int right(int p){
  return (p+1) % MAX;
}
// ======================================

void get_forks(int p) {
  sem_wait(&forks[left(p)]);    // rare but possible deadlock : each phil grabs left fork
  sem_wait(&forks[right(p)]);   //  => no fork remains to be raised as the right fork 
}


void put_forks(int p) {
  sem_post(&forks[left(p)]);
  sem_post(&forks[right(p)]);
}


int main(){
  for(int i=0 ; i<MAX ; i++){
    sem_init( &(forks[i]) , 0 , 1 );
  }
}
