# 🎯 PWM Modulator with SPI Control (FPGA Slave + ESP8266 Master)

![FPGA](https://img.shields.io/badge/FPGA-Zynq%207000-blue?style=for-the-badge)
![Controller](https://img.shields.io/badge/Controller-ESP8266-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-success?style=for-the-badge)

*A wire-controlled PWM modulation system demonstrating SPI communication between ESP8266 and FPGA.*

[Overview](#-overview) • [Architecture](#-architecture) • [Features](#-features) • [Repo Structure](#-repo-structure) • [Quick Start](#-quick-start-hardware) • [Connection](#-connection-wiring) • [Troubleshooting](#-troubleshooting-tips) • [Authors](#-authors)

---

## 🧩 Overview

This project demonstrates **SPI-based communication** between an **ESP8266 (master)** and an **FPGA (slave)** to achieve **real-time PWM control** of an LED.  
The ESP8266 sends simple 1-byte commands over SPI to the FPGA, which adjusts the PWM duty cycle accordingly — changing LED brightness dynamically.  
It is a **wire-controlled PWM system**, where the duty cycle can be remotely controlled or programmed as required.

---

## 🏗 Architecture

