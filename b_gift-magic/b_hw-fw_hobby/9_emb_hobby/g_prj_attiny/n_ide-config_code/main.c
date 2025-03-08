#include "ssd1306xled.h"

int main(void){
  
  ssd1306_init();
  ssd1306_clear();
  ssd1306_setpos( 0, 0 );
  ssd1306_start_data();
  ssd1306_data_byte(1);
  ssd1306_data_byte(2);
  ssd1306_data_byte(4);
  ssd1306_data_byte(8);
  ssd1306_stop();
  
  return 0;
}
