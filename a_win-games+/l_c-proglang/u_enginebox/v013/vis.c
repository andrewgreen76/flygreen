#include "vis.h"
#include <X11/Xlib.h>

#define RPXL 0xFF0000UL   // red pixel

void magic(Display *display, int screen, Window *window, GC *gc)
{
  unsigned long black_pixel = BlackPixel(display, screen);
  int x = 200 , y = 200;

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

    ///////////////// Init display: ///////////////////
    if (event.type == Expose) {
      XSetForeground(display, *gc, RPXL);
      XDrawPoint(display, *window, *gc, x, y);
      XFlush(display);
    }

    ////////////// Changes to display: ////////////////
    if (event.type == KeyPress){
      x++;
      y++;
      XSetForeground(display, *gc, RPXL);
      XDrawPoint(display, *window, *gc, x, y);
      XFlush(display);
    }
    ///////////////////////////////////////////////////    
  }

  // Graceful cleanup — everything in one place
  XFreeGC(display, *gc);
  XDestroyWindow(display, *window);
  XCloseDisplay(display);
}
