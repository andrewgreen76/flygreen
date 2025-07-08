#include <stdio.h>
#include <unistd.h>
#include <termios.h>

int main() {
    struct termios oldt, newt;
    char buf[100];
    int i = 0;
    char ch;

    // Save current terminal settings
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;

    // Disable canonical mode and echo
    newt.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);

    printf("Type input (Ctrl+D to abort):\n");

    while (i < sizeof(buf) - 1) {
        ssize_t n = read(STDIN_FILENO, &ch, 1);
        if (ch == 4) { // (n == 0) {
            // EOF received (Ctrl+D)
            printf("\nEOF detected. Exiting.\n");
            break;
        }
        if (ch == '\n') {
            buf[i++] = '\n';
            break;
        }
        buf[i++] = ch;
        write(STDOUT_FILENO, &ch, 1); // Echo manually
	printf("\n");
	printf("What is n ? : %ld\n" , n);
    }

    buf[i] = '\0';

    // Restore terminal settings
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);

    printf("\nYou entered: %s", buf);
    return 0;
}
