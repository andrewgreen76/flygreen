#include <stdio.h>
#include <termios.h>
#include <unistd.h>

int main() {
    struct termios old_termios, new_termios;
    char c;

    printf("\n");
    
    // Save current terminal settings
    tcgetattr(STDIN_FILENO, &old_termios);
    new_termios = old_termios;

    // Disable canonical mode and echoing
    new_termios.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &new_termios);

    printf("Press any key for it to be identified: ");
    c = getchar(); // Read a single key

    // Restore original terminal settings
    tcsetattr(STDIN_FILENO, TCSANOW, &old_termios);

    printf("\nYou pressed: %c\n", c);

    printf("\n");

    return 0;
}
