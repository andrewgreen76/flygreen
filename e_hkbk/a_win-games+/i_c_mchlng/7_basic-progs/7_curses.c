#include <ncurses.h>

int main() {
    // Initialize ncurses
    initscr();
    cbreak(); // Disable line buffering
    keypad(stdscr, TRUE); // Enable special keys like function keys
    noecho(); // Don't automatically print typed characters
    curs_set(FALSE); // Hide the cursor

    printw("Press a key: ");
    refresh();

    int keyPressed = getch(); // Get a character (key code) from the user

    printw("\nYou pressed the key: %d\n", keyPressed);
    refresh();

    getch(); // Wait for another key press before exiting

    // Cleanup ncurses
    endwin();

    return 0;
}
