#include <stdio.h>

int main() {
    printf("FILE this was printed from: %s\n", __FILE__);
    printf("In that src file: This very string was called for/returned at LINE NUM: %d\n", __LINE__);
    printf("In that src file: This very string was written within the FUNCTION: %s\n", __func__);

    return 0;
}
