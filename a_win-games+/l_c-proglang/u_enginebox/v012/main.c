/*
 * main.c
 */

#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <stdio.h>
#include <stdlib.h>
#include "vis.h"

int main(void)
{
    Display *display = XOpenDisplay(NULL);
    if (!display) {
        fprintf(stderr, "Cannot open display\n");
        exit(1);
    }

    int screen = DefaultScreen(display);
    Window window = 0;   // will be filled by magic()
    GC gc = NULL;        // will be created inside magic()

    magic(display, screen, &window, &gc);  // pass pointers!

    // No cleanup here — magic() already did it properly
    return 0;
}
