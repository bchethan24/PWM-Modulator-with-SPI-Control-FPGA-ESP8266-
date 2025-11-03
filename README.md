PWM Modulator with SPI Control (FPGA slave + ESP8266 master)

ESP8266 acts as an SPI master and sends simple command bytes (`0x01` increase, `0x02` decrease, `0x00` reset) to an FPGA-based SPI slave. The FPGA converts received value into a PWM duty cycle driving an LED — LED brightness changes with PWM duty cycle.

## Repo contents
-`/fpga` : VHDL sources (SPI slave, PWM generator, top module, testbench)

-`/esp8266`: Arduino sketch (Wi-Fi + SPI master) and webpage

- `/docs` : diagrams and report

## Features
- SPI-based control (simple 1-byte commands)
- FPGA generates timing-accurate PWM signal
- Web UI via ESP8266 to control Increase/Decrease
- LED as visual PWM output
- Esp8266 can be programmed as per requirement , i.e to operate or to send certain duty cycles insteard of sending all in a sequence.
