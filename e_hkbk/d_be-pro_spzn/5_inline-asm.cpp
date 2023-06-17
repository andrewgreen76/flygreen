#include <iostream>

int main() {
   int result;

   asm volatile(
      "movl $42, %0"
      : "=r" (result)
   );

   std::cout << "The result is: " << result << std::endl;

   return 0;
}
