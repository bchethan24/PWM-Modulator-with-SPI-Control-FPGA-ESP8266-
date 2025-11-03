# PWM Modulator with SPI Control (FPGA slave + ESP8266 master)

**Brief:**  
ESP8266 acts as an SPI master and sends simple command bytes (`0x01` → increase, `0x02` → decrease) to an FPGA-based SPI slave. The FPGA converts the received value into a PWM duty cycle driving an LED — LED brightness changes with the PWM duty cycle.

---

## Repo contents
- `/fpga/`     : Verilog/VHDL sources (SPI slave, clock divider, PWM generator, top module)  
- `/esp8266/`  : Arduino sketch (SPI master)
- `/connection/`: Pin configuration, wiring diagram and connection images

---

## Features
- SPI-based control (simple 1-byte commands)  
- FPGA generates timing-accurate PWM signal    
- LED as a visual PWM output (brightness proportional to duty)  
- ESP8266 can be reprogrammed to send custom duty sequences or direct duty values as required

---

## Quick start (hardware)
1. Program the FPGA with `fpga/pwm_top.v` (or `pwm_top.vhd`) from `/fpga/`.  
2. Upload `esp8266/esp8266_master.ino` to your NodeMCU / ESP8266.  
3. Wire the ESP8266 to the FPGA (see connection table below). Ensure common ground.  
4. Power devices (check IO voltage compatibility).  
5. Initialize the internal LED on the FPGA to PWM output pin.

---

## Connection (wiring) table
> **Important:** ESP8266 IO = 3.3 V. Make sure your FPGA IO bank is 3.3 V tolerant or use level shifters.

| ESP8266 (NodeMCU) | Signal    | FPGA signal / port |
|-------------------|-----------|--------------------|
| D5 (GPIO14)       | SCLK      | `sclk`             |
| D7 (GPIO13)       | MOSI      | `mosi`             |
| D8 (GPIO15)       | SS / CS   | `cs_n`             |
| GND               | GND       | GND                |

---
## Troubleshooting tips
- If LED doesn't change: verify common GND, correct pins, and that FPGA bitstream is loaded.  

## Authors
-  B CHETHAN  
-  T MANOJ KUMAR
