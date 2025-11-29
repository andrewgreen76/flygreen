#include "vis.h"

void magic( Display * display , int screen , Window window , GC gc)
{
  unsigned long black_pixel;

  // Colors
  black_pixel = BlackPixel(display, screen);

  // Create a simple window (400x400)
  window = XCreateSimpleWindow(display,
			       RootWindow(display, screen),
			       0, 0,          // x, y position
			       400, 400,      // width, height
			       1,             // border width
			       black_pixel,   // border color
			       black_pixel);  // background color

  // Select which events we want (we need Exposure so we can redraw)
  XSelectInput(display, window, ExposureMask | KeyPressMask);

  // Show the window
  XMapWindow(display, window);

  // Create a graphics context
  gc = XCreateGC(display, window, 0, NULL);

  // Wait for the window to be mapped and then draw
  while (1) {
    XEvent event;
    XNextEvent(display, &event);

    if (event.type == Expose) {
      // Draw one red pixel at the center of the window
      XSetForeground(display, gc, RPXL);
      /////////////////////////////////////////////////////////////
      XDrawPoint(display, window, gc, 200, 200);
      // Optional: draw a few more pixels so it's clearly visible
      XDrawPoint(display, window, gc, 199, 200);
      XDrawPoint(display, window, gc, 201, 200);
      XDrawPoint(display, window, gc, 200, 199);
      XDrawPoint(display, window, gc, 200, 201);
      /////////////////////////////////////////////////////////////

      XFlush(display);
    }

    // Exit on any key press
    if (event.type == KeyPress) {
      break;
    }
    
  } // End of loop.
} // End of display magic.
