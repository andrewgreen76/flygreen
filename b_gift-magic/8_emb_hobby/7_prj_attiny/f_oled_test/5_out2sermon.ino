void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("A");
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("B");
  delay(1000);
}
