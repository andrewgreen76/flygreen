/*
 * single_pixel.c
 * Draw one red pixel on a black background using X11
 * Compile with: gcc single_pixel.c -o single_pixel -lX11
 * Run with: ./single_pixel
 */

#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "vis.h"

int main(void)
{
  Display * display;
  Window window;
  GC gc;
  int screen;

  // Open connection to the X server
  display = XOpenDisplay(NULL);
  if (display == NULL) {
    fprintf(stderr, "Cannot open display\n");
    exit(1);
  }

  screen = DefaultScreen(display);

  ////////////////////////////////////////////////////////////////////////
  magic( display, screen, window , gc );    
  ////////////////////////////////////////////////////////////////////////

  // Cleanup
  XFreeGC(display, gc);
  XDestroyWindow(display, window);
  XCloseDisplay(display);

  return 0;
}
