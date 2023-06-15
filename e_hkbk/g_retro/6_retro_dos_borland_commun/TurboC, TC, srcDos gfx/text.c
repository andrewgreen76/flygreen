#include <stdio.h>
#include <conio.h>
#include <graph.h>

int main ()
{
		_setvideomode(_TEXTC80);

		_settextposition(1,80); /* upper right */
		_outtext("]");
		
		_settextposition(1,1); /* upper left */
		_outtext("[");
		
		getch();
		_setvideomode(_DEFAULTMODE);
		
		return 0;
}

