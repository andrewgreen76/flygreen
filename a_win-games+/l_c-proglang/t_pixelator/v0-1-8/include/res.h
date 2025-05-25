#ifndef RES_H
#define RES_H

#define RES_WIDTH  360  // 480 spx - by default ;  5 spx - for stepwise debugging w/ delay. 
#define RES_HEIGHT 180  // 240 spx - by default ; 50 spx - for stepwise debugging w/ delay.

#endif



////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

/*
  To start with : 480x320 (finest res) - feels like 3 fps - slow 
                  630x320 (finest res) - feels like 2 fps - very slow
  Settled with :  480x240 (finest res)
                  400x240 (finest res)
  
  320x240 :
   . theor. aspect ratio = 4:3
   . actual outcome : fail
  480x240 :
   . theor. aspect ratio = 2:1
   . actual outcome : ???
  480x320 :
   . theor. aspect ratio = 3:2
   . actual outcome : needs width stretch , has okay height.
  630x320 :
   . This works in the way of imaging and gaming experience. I hate the black strip artifact to the right.
   . Tearing artifact and refresh latency (0.3-0.6s). No clue as to how to remedy this. 
  512x384 :
   . theor. aspect ratio = 4:3 
   . Can't do it. 384/2 = 192 lines. 
  640x480 :
   . theor. aspect ratio = 4:3
   . Can't do it due to the excessive number of lines. 165 - tops. 
 */

/*
  480x320 seemed ideal, but at Ubuntu Linux terminal's finest resolution
    monospace characters are higher than what I would prefer. Something
    to keep in mind when crafting my own images for the terminal.
*/

/*  
  UI design :
   . Let's try 512x384. 
   . (at reg. res.) 135 cols x (41-3) lines
   . (at finest res.) 634 x 166 ; 634 x 332 = 210,488
   . =>  	      	    	      	      240 lfpx / 2 = 120 lfs , 320 cols. => 320 x 240. 
   . Can't do 640 cols.
   => 480 cols ; 320 rows => 160 line feeds.
   => 480 cols ; 160 line feeds.
   => 480 x 320. 
 */
