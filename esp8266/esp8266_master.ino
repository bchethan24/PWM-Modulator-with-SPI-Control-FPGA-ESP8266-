#include <SPI.h>

const int CS_PIN = D8;   // Chip Select (SS)
const int SCK_PIN = D5;  // Clock (SCK)
const int MOSI_PIN = D7; // Master Out Slave In (MOSI)

SPISettings spiSettings(1000000, MSBFIRST, SPI_MODE0); // 1 MHz SPI speed

void setup() {
  Serial.begin(115200);
  pinMode(CS_PIN, OUTPUT);
  digitalWrite(CS_PIN, HIGH); // Deselect slave initially

  // Initialize SPI with custom pins
  SPI.begin(SCK_PIN, -1, MOSI_PIN, CS_PIN);  
  Serial.println("SPI initialized on ESP8266 (1 MHz).");
}

void loop() {
  // Sweep PWM duty 0 → 255 → 0
  for (uint8_t duty = 0; duty <= 255; duty++) {
    sendPWMDuty(duty);
    delay(20);
  }

  for (int duty = 255; duty >= 0; duty--) {
    sendPWMDuty((uint8_t)duty);
    delay(20);
  }
}

void sendPWMDuty(uint8_t duty) {
  SPI.beginTransaction(spiSettings);
  digitalWrite(CS_PIN, LOW);   // Select slave
  SPI.transfer(duty);          // Send one byte (PWM duty)
  digitalWrite(CS_PIN, HIGH);  // Deselect slave
  SPI.endTransaction();

  Serial.print("Sent: ");
  Serial.println(duty);
}
