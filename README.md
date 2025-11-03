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
| 3.3V              | Vcc (ESP) | (do not tie to FPGA 5V IO) |

**LED**: connect FPGA `pwm_out` → resistor (220Ω) → LED → GND (or to driver if higher current required).

---

## Implementation notes & recommendations
- SPI Mode: use **Mode 0** (CPOL=0, CPHA=0) on both master and slave.  
- SPI speed: ESP side can run at 1 MHz (or higher) — ensure SPI slave sampling is done in a clock domain significantly faster than SCLK (e.g., sample using the FPGA system clock, not the divided 1 MHz clock).  
- PWM mapping: commonly an 8-bit duty register is scaled to a larger counter (e.g., `threshold = duty << 8`) if the PWM counter is 16-bit. This gives 256 duty steps.  
- Ensure `cs_n` resets the bit counter on the slave to avoid partial-byte issues.  
- Measure PWM frequency on an oscilloscope and note it for the viva (e.g., with 100 MHz system clock and 16-bit counter, `f_pwm ≈ 100e6 / 65536 ≈ 1526 Hz`).

---

## How to modify ESP behavior
The ESP8266 sketch is intentionally simple. You can modify it to:
- Send `increase` / `decrease` / `reset` commands on button events (default).  
- Send direct duty values (one-byte 0–255) instead of step commands.  
- Automate sequences: sweep, random patterns, or timed changes.  
- Implement acknowledgements (two-way SPI) by adding MISO support on FPGA.

---

## Files to check / edit before demo
- `fpga/constraints.xdc` — update pin mappings for your FPGA board.  
- `fpga/clock_divider.v` — ensure `DIV` matches your board clock to produce intended sampling/frequency.  
- `esp8266/esp8266_master.ino` — set desired SPI speed and pin mapping if using non-default pins.

---

## Troubleshooting tips
- If LED doesn't change: verify common GND, correct pins, and that FPGA bitstream is loaded.  
- If data seems garbled: check SPI mode, sampling domain, and that `cs_n` toggles per byte.  
- If ESP cannot host AP: check serial monitor for errors and valid Wi-Fi initialization.

---

## Authors
-  B CHETHAN  
-  T MANOJ KUMAR
