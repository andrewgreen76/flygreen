#include <stdio.h>
#include <termios.h>
#include <unistd.h>

int main() {
    struct termios old_termios, new_termios;
    char c;

    // Save current terminal settings
    tcgetattr(STDIN_FILENO, &old_termios);
    new_termios = old_termios;

    // Disable canonical mode and echoing
    new_termios.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &new_termios);

    printf("Press any key to continue...\n");
    c = getchar(); // Read a single key

    // Restore original terminal settings
    tcsetattr(STDIN_FILENO, TCSANOW, &old_termios);

    printf("You pressed: %c\n", c);

    return 0;
}
