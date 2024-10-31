#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

// Function to set terminal to non-blocking mode
void setNonBlockingMode() {
    struct termios oldt, newt;
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO); // Disable canonical mode and echo
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);
}

// Function to reset terminal settings
void resetTerminal(struct termios *oldt) {
    tcsetattr(STDIN_FILENO, TCSANOW, oldt);
}

// Function to check if a key is pressed
int kbhit() {
    int oldf, newf;
    oldf = fcntl(STDIN_FILENO, F_GETFL); // Get current flags
    newf = oldf | O_NONBLOCK;            // Set non-blocking mode
    fcntl(STDIN_FILENO, F_SETFL, newf);  // Apply non-blocking mode

    char ch;
    int result = read(STDIN_FILENO, &ch, 1); // Read a character
    fcntl(STDIN_FILENO, F_SETFL, oldf);      // Restore old flags

    if (result == -1) {
        return 0; // No key pressed
    } else {
        return 1; // Key was pressed
    }
}

int main() {
    struct termios oldt;
    tcgetattr(STDIN_FILENO, &oldt); // Save old terminal settings
    setNonBlockingMode();            // Set non-blocking mode

    printf("Press any key to exit...\n");

    while (1) {
        if (kbhit()) {
            char ch = getchar(); // Get the pressed key
            printf("Key pressed: %c\n", ch);
            break; // Exit loop on key press
        }

        // Perform other tasks here
        // Simulating work with sleep
        usleep(100000); // Sleep for 100ms (0.1 seconds)
    }

    resetTerminal(&oldt); // Reset terminal settings
    return 0;
}
