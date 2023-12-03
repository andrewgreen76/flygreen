#include <stdio.h>
#include <stdlib.h>

struct point{
	int x;
	int y;
};

void printPoint(struct point);
void printPoly(struct point *, int);
void initializePoly(struct point *, int);

int main(void) {
    // Fill in your main function here
    int npts=0;
    struct point * poly_0;
    scanf("%d", &npts);
    
    poly_0 = (struct point *) malloc( npts*sizeof(struct point) );
    initializePoly(poly_0, npts);
    printPoly(poly_0, npts);
    
    free(poly_0);
}

void printPoint(struct point pt) {
    printf("(%d, %d)\n", pt.x, pt.y);
}

void printPoly(struct point *ptr, int N) {
    int i;
    for (i=0; i<N; i++) {
        printPoint(ptr[i]);
    }
}

// Write your initializePoly() function here
void initializePoly(struct point * poly_0, int npts){
    int i;
    
    for(i=0 ; i<npts ; i++){
        (poly_0+i)->x = i*-1;
        (poly_0+i)->y = i*i;
    }
}
