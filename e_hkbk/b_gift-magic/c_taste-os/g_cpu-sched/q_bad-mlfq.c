#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int id;
    int duration;
    int remaining_time;
    int waiting_time;
    int turnaround_time;
} Process;

typedef struct {
    Process *processes[100];
    int front, rear;
    int time_quantum;
} Queue;

void initializeQueue(Queue *q, int time_quantum) {
    q->front = q->rear = -1;
    q->time_quantum = time_quantum;
}

void enqueue(Queue *q, Process *p) {
    if(q->rear == 99) {
        printf("Queue is full!\n");
        return;
    }
    
    q->processes[++q->rear] = p; // Look up q's rear, incr, focus on rear of q's procs, put addr of new proc there. 
    if(q->front == -1) {        // q is no longer empty. 
        q->front = 0;
    }
    printf("Process %d enqueued in queue with time quantum %d\n", p->id, q->time_quantum);
}
// Removes head/front proc : 
Process* dequeue(Queue *q) {
    if(q->front == -1) {
        return NULL;
    }
    
    Process *p = q->processes[q->front]; // Look up q's front = head proc -> addr/proc of interest for future p->id lookup. 
    if(q->front == q->rear) {   // If front reached rear, reset them both. 
        q->front = q->rear = -1;
    } else {
        q->front++; // Incr'ing front gets us to ignore ("delete") the head proc. 
    }

    printf("Process %d dequeued from queue with time quantum %d\n", p->id, q->time_quantum);
    return p; // returns the severed process : 
}

void mlfq_scheduling(Queue *high_priority_q, Queue *medium_priority_q, Queue *low_priority_q, int n) {
    int total_time = 0;
    while(1) {
        Process *p = dequeue(high_priority_q);	
	if(p != NULL) { // if high.q is NOT EMPTY 
	    printf("Process %d is running in high priority queue\n", p->id);
	    if(p->remaining_time <= high_priority_q->time_quantum) { // remain.time < high.quantum
		total_time += p->remaining_time;
		p->remaining_time = 0;
		p->waiting_time = total_time - p->duration;
		p->turnaround_time = total_time;
		printf("Process %d finished execution\n", p->id);
	    } else {  // remain.time > high.quantum 
		p->remaining_time -= high_priority_q->time_quantum;
		total_time += high_priority_q->time_quantum;
		enqueue(medium_priority_q, p); // failed once, move down. 
	    }
	} else {  // if(p == NULL) , i.e., high queue is EMPTY , go to medium : 
	    p = dequeue(medium_priority_q);
	    if(p != NULL) { // if medium.q is NOT EMPTY 
		printf("Process %d is running in medium priority queue\n", p->id);
		if(p->remaining_time <= medium_priority_q->time_quantum) { // Made it within the med.quantum 
		    total_time += p->remaining_time;
		    p->remaining_time = 0;
		    p->waiting_time = total_time - p->duration;
		    p->turnaround_time = total_time;
		    printf("Process %d finished execution\n", p->id);
		} else { // Did not make it within the med.quantum 
		  p->remaining_time -= medium_priority_q->time_quantum; // We are working on the medium queue, not high queue. 
		   total_time += medium_priority_q->time_quantum;
		   enqueue(low_priority_q, p); // If it failed, move it down to the low.q ; don't plug it back to the med.q. 
		}
	    } else { // if medium.q is EMPTY , ...
	      p = dequeue(low_priority_q); // ... then focus on the low.q and behead that queue. 
	      if(p != NULL) { // If low.q is NOT EMPTY 
		    printf("Process %d is running in medium priority queue\n", p->id);
		    if(p->remaining_time <= low_priority_q->time_quantum) { // Made it within the low.quantum 
			total_time += p->remaining_time;
			p->remaining_time = 0;
			p->waiting_time = total_time - p->duration;
			p->turnaround_time = total_time;
			printf("Process %d finished execution\n", p->id);
		    } else { // Did not make it within the low.quantum 
			p->remaining_time -= low_priority_q->time_quantum;
			total_time += low_priority_q->time_quantum;
			enqueue(low_priority_q, p); // Now you can safely plug it back into low.q. Where else would the job go ? 
		    }
		} else {
		    p = dequeue(low_priority_q);
		    if(p != NULL) {
			printf("Process %d is running in low priority queue\n", p->id);
			if(p->remaining_time <= low_priority_q->time_quantum) {
			    total_time += p->remaining_time;
			    p->remaining_time = 0;
			    p->waiting_time = total_time - p->duration;
			    p->turnaround_time = total_time;
			    printf("Process %d finished execution\n", p->id);
			} else {
			    p->remaining_time -= low_priority_q->time_quantum;
			    total_time += low_priority_q->time_quantum;
			    enqueue(low_priority_q, p);
			}
		    } else {
		      break; // Done with the low priority queue. 
		    }
		}
	    }
	}
    }
}



int main() {
    // Step 6.1: Initialize the Queues
    Queue high_priority_q, medium_priority_q, low_priority_q;
    initializeQueue(&high_priority_q, 2);  // High priority queue with time quantum of 2
    initializeQueue(&medium_priority_q, 4); // Medium priority queue with time quantum of 4
    initializeQueue(&low_priority_q, 8);    // Low priority queue with time quantum of 8

    // Step 6.2: Take User Input for Number of Processes
    int n;
    printf("Enter the number of processes: ");
    scanf("%d", &n);

    // Step 6.3: Allocate Memory for Processes and Take Their Input
    Process *processes = (Process *)malloc(n * sizeof(Process));
    for(int i = 0; i < n; i++) {
        printf("Enter duration for process %d: ", i+1);
        scanf("%d", &processes[i].duration);
        processes[i].id = i+1;
        processes[i].remaining_time = processes[i].duration;
        processes[i].waiting_time = 0;
        processes[i].turnaround_time = 0;
        enqueue(&high_priority_q, &processes[i]);  // Enqueue all processes to high priority queue initially

	// Custom adjustments :
	//processes[0].
    }

    // Step 6.4: Invoke the MLFQ Scheduling Function
    mlfq_scheduling(&high_priority_q, &medium_priority_q, &low_priority_q, n);

    // Step 6.5: Display the Results
    printf("Process\tDuration\tWaiting Time\tTurnaround Time\n");
    for(int i = 0; i < n; i++) {
        printf("%d\t%d\t\t%d\t\t%d\n", processes[i].id, processes[i].duration, processes[i].waiting_time, processes[i].turnaround_time);
    }

    // Step 6.6: Free the Allocated Memory
    free(processes);
    return 0;
}
