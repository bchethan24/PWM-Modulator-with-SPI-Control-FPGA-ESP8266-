# PWM Modulator with SPI Control (FPGA slave + ESP8266 master)

**Brief:**  
ESP8266 acts as an SPI master and sends simple command bytes (`0x01` → increase, `0x02` → decrease, `0x00` → reset) to an FPGA-based SPI slave. The FPGA converts the received value into a PWM duty cycle driving an LED — LED brightness changes with the PWM duty cycle.

---

## Repo contents
- `/fpga/`     : Verilog/VHDL sources (SPI slave, clock divider, PWM generator, top module, testbench)  
- `/esp8266/`  : Arduino sketch (Wi-Fi + SPI master) and webpage UI  
- `/connection/`: Pin configuration, wiring diagram and connection images

---

## Features
- SPI-based control (simple 1-byte commands)  
- FPGA generates timing-accurate PWM signal (low jitter)  
- Web UI hosted on ESP8266 to control Increase / Decrease / Reset  
- LED as a visual PWM output (brightness proportional to duty)  
- ESP8266 can be reprogrammed to send custom duty sequences or direct duty values as required

---

## One-minute pitch
A lightweight IoT-to-hardware demo: the ESP8266 provides a user-friendly web interface and acts as SPI master; the FPGA receives simple control commands and generates deterministic PWM to drive an LED. This demonstrates a clear division of responsibility — networking/UI on the ESP, timing-critical signal generation on the FPGA — useful for educational demos and embedded systems prototypes.

---

## Quick start (hardware)
1. Program the FPGA with `fpga/pwm_top.v` (or `pwm_top.vhd`) from `/fpga/`.  
2. Upload `esp8266/esp8266_master.ino` to your NodeMCU / ESP8266.  
3. Wire the ESP8266 to the FPGA (see connection table below). Ensure common ground.  
4. Power devices (check IO voltage compatibility).  
5. Connect LED (with resistor) to the FPGA PWM output pin.  
6. Join Wi-Fi `PWM_Control` (password: `12345678`) and open `http://192.168.4.1` to use + / − / Reset.

---

## Connection (wiring) table
> **Important:** ESP8266 IO = 3.3 V. Make sure your FPGA IO bank is 3.3 V tolerant or use level shifters.

| ESP8266 (NodeMCU) | Signal    | FPGA signal / port |
|-------------------|-----------|--------------------|
| D5 (GPIO14)       | SCLK      | `sclk`             |
| D7 (GPIO13)       | MOSI      | `mosi`             |
| D8 (GPIO15)       | SS / CS   | `cs_n` (active low)|
| GND               | GND       | GND                |

**LED**: connect FPGA `pwm_out` → resistor (220Ω) → LED → GND (or to driver if higher current required).

---
## Troubleshooting tips
- If LED doesn't change: verify common GND, correct pins, and that FPGA bitstream is loaded.  

## Authors
-  B CHETHAN  
-  T MANOJ KUMAR
