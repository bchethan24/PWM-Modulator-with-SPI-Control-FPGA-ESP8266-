PWM Modulator with SPI Control (FPGA slave + ESP8266 master)

ESP8266 acts as an SPI master and sends simple command bytes (`0x01` increase, `0x02` decrease, `0x00` reset) to an FPGA-based SPI slave. The FPGA converts received value into a PWM duty cycle driving an LED — LED brightness changes with PWM duty cycle.

## Repo contents
fpga : VHDL sources (SPI slave, PWM generator, top module, testbench)
esp8266: Arduino sketch (Wi-Fi + SPI master) and webpage
- `/docs` : diagrams and report

## Features
- SPI-based control (simple 1-byte commands)
- FPGA generates timing-accurate PWM signal
- Web UI via ESP8266 to control Increase/Decrease/Reset
- LED as visual PWM output

## How to use
1. Synthesize & program the FPGA with `pwm_top.vhd`.
2. Upload `esp8266_master.ino` to the NodeMCU.
3. Connect SPI pins (D5=SCK, D7=MOSI, D8=SS) to FPGA; connect grounds.
4. Connect an LED (with suitable resistor) to FPGA PWM output pin.
5. Join `PWM_Control` SSID, open `http://192.168.4.1`, press + / - / Reset.

## License
MIT
