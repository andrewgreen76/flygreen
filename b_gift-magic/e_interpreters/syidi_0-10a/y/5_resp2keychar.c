#include <stdio.h>
#include <termios.h>
#include <unistd.h>

int main() {
    struct termios oldt, newt;
    tcgetattr(STDIN_FILENO, &oldt);         // get current terminal attributes
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO);       // disable canonical mode and echo
    tcsetattr(STDIN_FILENO, TCSANOW, &newt); // apply changes immediately

    int ch;
    printf("Type something (Ctrl+D to abort):\n");
    while ((ch = getchar()) != EOF) {
        putchar(ch);
	printf("\n");
	printf("You pressed: %d\n" , ch);
    }

    printf("\nEOF detected. Exiting.\n");

    tcsetattr(STDIN_FILENO, TCSANOW, &oldt); // restore old settings
    return 0;
}
