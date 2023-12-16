// Every process has its own unique PID. 

#include <stdio.h>
#include <unistd.h>

int main() {
    // Get the process ID
    pid_t process_id = getpid();

    // Print the process ID
    printf("Process ID: %d\n", process_id);

    // Get the process ID
    process_id = getpid();

    // Print the process ID
    printf("Process ID: %d\n", process_id);

    return 0;
}
