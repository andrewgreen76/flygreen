#include <stdio.h>
#include <stdlib.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

struct termios original_term;

void set_noncanonical_mode() {
    struct termios term;
    tcgetattr(STDIN_FILENO, &original_term); // Save original settings
    term = original_term;
    term.c_lflag &= ~(ICANON | ECHO); // Disable canonical mode and echo
    term.c_cc[VMIN] = 1;  // Minimum 1 character
    term.c_cc[VTIME] = 0; // No timeout
    tcsetattr(STDIN_FILENO, TCSANOW, &term);
}

void restore_terminal_mode() {
    tcsetattr(STDIN_FILENO, TCSANOW, &original_term); // Restore original terminal settings
}

int main() {
    char ch;
    int flags;

    // Set stdin to non-blocking
    flags = fcntl(STDIN_FILENO, F_GETFL, 0);
    fcntl(STDIN_FILENO, F_SETFL, flags | O_NONBLOCK);

    // Set terminal to non-canonical mode
    set_noncanonical_mode();

    printf("Enter characters (Ctrl+D to abort):\n");

    while (1) {
        errno = 0;
        int n = read(STDIN_FILENO, &ch, 1);

        if (n == 0 || (n == -1 && errno == EAGAIN)) {
            // No input available, continue checking
            continue;
        }
        else if (n == -1) {
            // Handle other errors
            perror("read");
            restore_terminal_mode(); // Restore terminal before exit
            exit(1);
        }
        else if (ch == 4) { // Ctrl+D is ASCII 4
            printf("\nCtrl+D detected. Aborting...\n");
            restore_terminal_mode(); // Restore terminal before exit
            exit(0);
        }
        else {
            // Process valid input
            printf("Received: %c\n", ch);
        }
    }

    // Restore terminal mode (though loop doesn't exit normally)
    restore_terminal_mode();
    return 0;
}
