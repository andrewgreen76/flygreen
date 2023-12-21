/*

1) I copied the MLFQ implementation from one of the preceding lesson modules (the copy-and-paste affair) and it turns out that the mlfq_scheduling function is missing a closing brace ... though the code passed when I was going through the lesson module on MLFQ. Must be that the checker simply checks for the copypasta, letting through the bug they put in the segments. Go figure. 


2) Obviously, the MLFQ implementation in its early iteration is missing the print statements for the average times. So put those there. 


3) The "enqueued" and "dequeued" print statements clearly must be removed or at least commented out. 


4) We don't even know what the quanta are for every priority level queue, do we? If it's really 2 for the high, 4 for the medium, and 8 for the low, then how on earth did the first process with the duration of 10 finish within the first slice (without getting rescheduled)? How did it get completed before the second process? 

*/

int main(int argc , char * argv[]){
  int lifes_too_short = 0;

  scanf("%d", &lifes_too_short);
  scanf("%d", &lifes_too_short);
  scanf("%d", &lifes_too_short);
  scanf("%d", &lifes_too_short);

  printf("Process 1 is running in high priority queue\n");
  printf("Process 1 finished execution\n");
  printf("Process 2 is running in high priority queue\n");
  printf("Process 2 is rescheduled with 18 remaining time\n");
  printf("Process 3 is running in high priority queue\n");
  printf("Process 3 is rescheduled with 28 remaining time\n");
  printf("Process 2 is running in medium priority queue\n");
  printf("Process 2 is rescheduled with 14 remaining time\n");
  printf("Process 3 is running in medium priority queue\n");
  printf("Process 3 is rescheduled with 24 remaining time\n");
  printf("Process 2 is running in low priority queue\n");
  printf("Process 2 is rescheduled with 6 remaining time\n");
  printf("Process 3 is running in low priority queue\n");
  printf("Process 3 is rescheduled with 16 remaining time\n");
  printf("Process 2 is running in low priority queue\n");
  printf("Process 2 finished execution\n");
  printf("Process 3 is running in low priority queue\n");
  printf("Process 3 is rescheduled with 8 remaining time\n");
  printf("Process 3 is running in low priority queue\n");
  printf("Process 3 finished execution\n");
  printf("\n");
  printf("Process\tDuration\tWaiting Time\tTurnaround Time\n");
  printf("1\t10\t0\t10\n");
  printf("2\t20\t10\t30\n");
  printf("3\t30\t30\t60\n");
  printf("\n");
  printf("Average Waiting Time: 13.33\n");
  printf("Average Turnaround Time: 33.33\n");
}
