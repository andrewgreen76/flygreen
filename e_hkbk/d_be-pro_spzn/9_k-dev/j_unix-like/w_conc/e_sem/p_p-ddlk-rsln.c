/*
  See also : 
   . cigarette smoker's dilemma 
   . sleeping barber's problem 
*/

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
  if (p == 4) { // breaking the deadlock 
    sem_wait(&forks[right(p)]);
    sem_wait(&forks[left(p)]);
  } else {
    sem_wait(&forks[left(p)]);
    sem_wait(&forks[right(p)]);
  }
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
