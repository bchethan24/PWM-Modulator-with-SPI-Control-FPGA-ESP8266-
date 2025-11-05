#include <SPI.h>

const int CS_PIN = D8;   // Chip Select (SS)

// SPI speed: 1 MHz (FPGA clock is 1 MHz)
SPISettings spiSettings(1000000, MSBFIRST, SPI_MODE0);

void setup() {
  Serial.begin(115200);
  pinMode(CS_PIN, OUTPUT);
  digitalWrite(CS_PIN, HIGH); // Deselect slave initially

  // Initialize SPI with default hardware pins
  SPI.begin();  
  Serial.println("SPI initialized on ESP8266.");
}

void loop() {
  // Sweep PWM duty 0 → 7 → 0 (3-bit duty)
  for (uint8_t duty = 0; duty <= 7; duty++) {
    sendPWMDuty(duty);
    delay(200);  // slower for visible LED change
  }

  for (int duty = 6; duty >= 0; duty--) {  // avoid repeating 7
    sendPWMDuty(duty);
    delay(200);
  }
}

void sendPWMDuty(uint8_t duty) {
  uint8_t data = duty & 0x07;  // Ensure only 3 bits are sent

  SPI.beginTransaction(spiSettings);
  digitalWrite(CS_PIN, LOW);   // Select slave
  SPI.transfer(data);          // Send 3-bit value (in 8-bit container)
  digitalWrite(CS_PIN, HIGH);  // Deselect slave
  SPI.endTransaction();

  Serial.print("Sent 3-bit duty: ");
  Serial.println(data);
}
