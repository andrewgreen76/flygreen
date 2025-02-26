#include <stdio.h>
#include <unistd.h>
#include <termios.h>

void set_raw_mode(int enable) {
    struct termios tty;
    tcgetattr(STDIN_FILENO, &tty);
    if (enable) {
        tty.c_lflag &= ~(ICANON | ECHO);  // Disable line buffering and echo
    } else {
        tty.c_lflag |= (ICANON | ECHO);   // Restore original mode
    }
    tcsetattr(STDIN_FILENO, TCSANOW, &tty);
}

int main() {
    char ch;

    set_raw_mode(1);  // Enable raw mode

    while (1) {
        ch = getchar();
        if (ch == 27) {  // Escape key or arrow key
            if (getchar() == 91) {  // Check if '[' follows (part of an arrow key)
                ch = getchar();  // Read the arrow key identifier
                switch (ch) {
                    case 'A': printf("Up Arrow pressed\n"); break;
                    case 'B': printf("Down Arrow pressed\n"); break;
                    case 'C': printf("Right Arrow pressed\n"); break;
                    case 'D': printf("Left Arrow pressed\n"); break;
                    default: printf("Unknown escape sequence\n");
                }
            } else {
                printf("Escape key pressed, exiting...\n");
                break;  // Exit the loop
            }
        }
    }

    set_raw_mode(0);  // Restore normal mode
    return 0;
}
