#include <Tiny4kOLED.h>

void setup() {
  // Initialize the OLED display
  oled.begin(128, 64, sizeof(tiny4koled_init_128x64), tiny4koled_init_128x64);
  oled.clear();
  oled.on();
  oled.setFont(FONT8X16);
  oled.setCursor(0, 0);
  oled.print(F("My name is ... Kid Rock!"));
}

void loop() {
  // Empty loop, no dynamic updates needed
}