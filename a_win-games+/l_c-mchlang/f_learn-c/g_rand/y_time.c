#include <stdio.h>
#include <time.h>

int main() {
    // Get the current time
    time_t now = time(NULL);
    
    // Convert it to local time format
    struct tm *local = localtime(&now);
    
    // Print the current time
    printf("Current local time: %s", asctime(local));
    
    return 0;
}
