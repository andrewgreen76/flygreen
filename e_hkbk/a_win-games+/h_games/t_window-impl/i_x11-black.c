#include <X11/Xlib.h>

int main() {
    Display* display;
    Window root;
    GC gc;

    // Open a connection to the X server
    display = XOpenDisplay(NULL);
    if (!display) {
        fprintf(stderr, "Unable to open X display\n");
        return 1;
    }

    // Get the root window
    root = DefaultRootWindow(display);

    // Create a graphics context (GC)
    gc = XCreateGC(display, root, 0, NULL);

    // Set the background color to black
    XSetForeground(display, gc, BlackPixel(display, DefaultScreen(display)));

    // Fill the entire screen with black
    XFillRectangle(display, root, gc, 0, 0, DisplayWidth(display, DefaultScreen(display)), DisplayHeight(display, DefaultScreen(display)));

    // Flush any pending X requests
    XFlush(display);

    // Sleep for a few seconds to show the black screen (you can remove this if needed)
    sleep(5);

    // Clean up and close the X display
    XFreeGC(display, gc);
    XCloseDisplay(display);

    return 0;
}
