#include <stdio.h>

int main(){
    const int ws = 68, maxls = 40;
    char text[ws][maxls];
    int w;
    
    for(w=0; w<ws; w++) scanf("%s", text[w] ) ;    
    for(w= ws-1; w>-1; w--) printf("%s ", text[w] ) ;
}
