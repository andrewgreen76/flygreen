#include "vis.h"
#include <X11/Xlib.h>

#define RPXL 0xFF0000UL   // red pixel

void magic(Display *display, int screen, Window *window, GC *gc)
{
    unsigned long black_pixel = BlackPixel(display, screen);

    // Create window
    *window = XCreateSimpleWindow(display,
                                  RootWindow(display, screen),
                                  0, 0, 400, 400,
                                  1, black_pixel, black_pixel);

    XSelectInput(display, *window, ExposureMask | KeyPressMask);
    XMapWindow(display, *window);

    // Create GC
    *gc = XCreateGC(display, *window, 0, NULL);

    XEvent event;
    while (1) {
        XNextEvent(display, &event);

        if (event.type == Expose) {
            XSetForeground(display, *gc, RPXL);
            XDrawPoint(display, *window, *gc, 200, 200);
            XDrawPoint(display, *window, *gc, 199, 200);
            XDrawPoint(display, *window, *gc, 201, 200);
            XDrawPoint(display, *window, *gc, 200, 199);
            XDrawPoint(display, *window, *gc, 200, 201);
            XFlush(display);
        }

        if (event.type == KeyPress)
            break;
    }

    // Graceful cleanup — everything in one place
    XFreeGC(display, *gc);
    XDestroyWindow(display, *window);
    XCloseDisplay(display);
}
