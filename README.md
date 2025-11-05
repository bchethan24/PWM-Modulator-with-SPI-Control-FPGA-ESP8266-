# PWM Modulator with SPI Control (FPGA Slave + ESP8266 Master)



*A wire-controlled PWM system implementing complete FPGA design flow using SPI protocol.*

---

##  Overview

This project demonstrates a **wire-controlled PWM Modulator** implemented on an **FPGA (ZedBoard zync-7000)**, controlled via **SPI communication protocol** from an **ESP8266 (NodeMCU)** acting as the SPI master.  
It enables **real-time LED brightness control** through **3-bit SPI commands**, illustrating seamless hardware-software co-design.

---

 System Architecture
 ```
┌────────────────────────────┐        ┌────────────────────────────┐
│ ESP8266 (Master)           │        │ FPGA (Zedboard zync-7000)  │
│ • SPI Master               │        │ • SPI Slave Receiver       │
│ • Sends 3-bit commands     │◄──────►│ • PWM Generator (1 MHz)    │
│ • Commands:                │  SPI   │ • Clock Divider            │
│ 001 → Increase Duty        │  Bus   │ • LED Output (LD0)         │
│ 010 → Decrease Duty        │        │                            │
└────────────────────────────┘        └────────────────────────────┘
                                                    │
                                                    ▼
                                                ┌────────┐
                                                │ LED0   │
                                                │ Bright │
                                                │ Output │
                                                └────────┘
```
---

## ⚙ Working Principle

1. **ESP8266 (Master)** sends 3-bit commands (`001` or `010`) to the FPGA.  
2. **FPGA SPI Slave** captures and decodes these bits.  
3. Based on the command:
   - `001` → Increases PWM duty cycle  
   - `010` → Decreases PWM duty cycle  
4. **PWM Generator** (driven by 1 MHz clock) updates the LED brightness in real time.  

Thus, the LED’s intensity is **wire-controlled** through SPI communication.

---

## 🔩 Circuit Design

![WhatsApp Image 2025-11-05 at 10 45 07_1353e889](https://github.com/user-attachments/assets/6003993f-290f-4756-83f5-de26cb500685)


---

## 🧱 Synthesized Design (Vivado)

![WhatsApp Image 2025-11-05 at 10 52 31_a9fe123c](https://github.com/user-attachments/assets/01b66890-3b7e-40f1-961d-d621bac79658) 

---

## 🧩 Detailed RTL Component Information

The synthesized design includes a well-structured combination of arithmetic, sequential, and combinational blocks forming the SPI-based PWM controller. The RTL breakdown is as follows:

### ➕ Adders
| Type | Bit Width | Quantity | Function |
|-------|------------|-----------|-----------|
| 2-Input | 32-bit | 1 | Used for PWM counter increment |
| 2-Input | 3-bit | 1 | SPI data computation |
| 2-Input | 2-bit | 1 | Control signal processing |

### 🧮 Registers
| Bit Width | Quantity | Function |
|------------|-----------|-----------|
| 32-bit | 1 | PWM counter storage |
| 3-bit | 2 | SPI data latch and duty cycle register |
| 2-bit | 2 | State tracking and mode control |
| 1-bit | 4 | Status flags and enable control |

### 🔀 Multiplexers (Muxes)
| Type | Bit Width | Quantity | Function |
|-------|------------|-----------|-----------|
| 2-Input | 2-bit | 1 | SPI data path selection |
| 2-Input | 1-bit | 1 | Output control selection |

---

> 🧠 *These components collectively form the core digital logic of the PWM Modulator, enabling synchronized SPI data reception, duty cycle control, and pulse generation within the FPGA.*


---

### 📊 Resource Utilization (Post-Synthesis)

| Resource | Utilization | Description |
|-----------|--------------|-------------|
| **LUT1** | 3 | Basic logic |
| **LUT2** | 1 | Logic for data mux |
| **LUT3** | 4 | SPI interface |
| **LUT4** | 4 | PWM logic |
| **LUT5** | 40 | Core combinational logic |
| **LUT6** | 1 | Miscellaneous |
| **CARRY4** | 8 | Adders and counters |
| **FDCE** | 33 | Flip-flops (clock enable) |
| **FDRE** | 13 | Flip-flops (reset enabled) |
| **BUFG** | 1 | Global clock buffer |
| **IBUF** | 5 | Input buffers (SPI pins + clock) |
| **OBUF** | 2 | Output buffers (LED output) |
| **DSPs** | 0 | Not used |
| **BRAMs** | 0 | Not used |

---

### 🧮 Instance Statistics

| Instance | Module | No. of Cells |
|-----------|---------|--------------|
| **top** | spi_pwm_top_3bit | 115 |
| ├── u_clkdiv | clock_divider | 83 |
| ├── u_pwm | pwm_gen_3bit | 8 |
| └── u_spi | spi_slave_3bit | 16 |

> ✅ *Synthesis completed successfully — 0 errors, 0 critical warnings.*

---

## 📐 Hardware Configuration

| Parameter     | Description |
|------------|-------------|
| **FPGA Board** |ZedBoard zync-7000 |
| **Clock Frequency** | 1 MHz |
| **SPI Clock (ESP8266)** | 1 MHz |
| **Output** | LD0 LED |
| **Voltage** | 3.3 V I/O logic |
| **SPI Mode** | Mode 0 (CPOL=0, CPHA=0) |

---

## 🔗 SPI Pin Connections

| ESP8266 | Signal | FPGA Pin | Description |
|----------|---------|-----------|-------------|
| D5 (GPIO14) | SCLK | spi_sclk | SPI Clock |
| D7 (GPIO13) | MOSI | spi_mosi | Data line |
| D8 (GPIO15) | CS | spi_cs_n | Active-low chip select |
| GND | GND | GND | Common ground |

> ⚠ **Note:** Ensure both devices share a common ground.


## 🧪 Verification & Testing

| Test | SPI Command | Expected | Observed |
|------|--------------|-----------|-----------|
| 1 | 001 | Increase duty cycle | LED brightens |
| 2 | 010 | Decrease duty cycle | LED dims |
| 3 | Alternate 001 / 010 | Gradual PWM change | Smooth LED fade |
| 4 | Invalid input | No effect | LED steady |

---

## 🧠 Learning Outcomes

- Implementation of **SPI protocol** in FPGA hardware  
- Design and debugging of a **PWM generator**  
- Integration of **ESP8266 firmware with FPGA logic**  
- Vivado **synthesis and resource utilization analysis**  

---

## 🧩 Tools & Technologies

| Category | Tool/Technology |
|-----------|----------------|
| **HDL** | Verilog |
| **Firmware** | Arduino IDE |
| **Simulation** | Vivado Simulator |
| **Synthesis Tool** | Xilinx Vivado 2024.2 |
| **Communication** | SPI |
| **Hardware** | ESP8266 + FPGA (Zedboard Zynq-7000) |

---

## 💡 Applications

- FPGA–MCU co-design projects  
- Real-time LED intensity control  
- VLSI & Embedded Systems lab demo  
- PWM-based control systems  

---

## 🧭 Academic Context

**Course:** VLSI System Design Practice (EC-307)  
**Institution:** IIITDM Kurnool  
**Academic Year:** 2025–2026  
**Faculty:** Dr. P. Ranga Babu  

---

## 📚 References
- [*Serial peripheral interface library*](https://github.com/esp8266/Arduino/blob/master/libraries/SPI/SPI.h)
- [*Digilent ZedBoard constraints*](https://github.com/Digilent/digilent-xdc/blob/master/Zedboard-Master.xdc)
- [*Digilent ZedBoard Reference Manual*](https://digilent.com/reference/_media/zedboard:zedboard_ug.pdf)
- [*PWM FSM & SPI Lecture Notes — Imperial College London*](http://www.ee.ic.ac.uk/pcheung/teaching/msc_experiment/Lecture%203%20-%20PWM%20FSM%20&%20SPI.pdf)


## 🛠 Future Enhancements

- 8-bit SPI data width for finer control  
- Multi-channel PWM (RGB)  
- SPI feedback to master  
- Smooth transition using ramp generator  
- PS-PL hybrid Zynq integration  

---

## 🧾 License

**MIT License**


Permission is granted to use, modify, and distribute under MIT terms.

---

<div align="center">

### 👨‍🎓 About the Developer  

**B CHETHAN (Roll No: 123EC0049)**  
**T MANOJ KUMAR (Roll No: 523EC0008)**  

Department of Electronics and Communication Engineering

**Indian Institute of Information Technology Design and Manufacturing, Kurnool**

---
---

## 🌟 Acknowledgments

- IIITDM Kurnool — Lab Infrastructure  
- Dr. P. Ranga Babu — Project Guidance  
- Xilinx & Espressif — Tools & Documentation    

---

## ✅ Summary

A fully verified **SPI-based wire-controlled PWM Modulator** integrating **FPGA and ESP8266**, synthesized successfully on **Vivado 2024.2**.  
It illustrates the bridge between **VLSI hardware design and embedded system control**, suitable for academic and industrial applications.

---
