##===========================================================
## ZedBoard - SPI ? PWM Constraints
##===========================================================

# 100 MHz on-board clock input
set_property PACKAGE_PIN W5 [get_ports {clk_100mhz}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk_100mhz}]
create_clock -period 10.0 -name clk100mhz [get_ports {clk_100mhz}]

# Reset Button (BTNC, active low)
set_property PACKAGE_PIN P16 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]

# SPI Interface (PMOD JB1)
# SPI_SCK ? W12
set_property PACKAGE_PIN W12 [get_ports {spi_sclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_sclk}]

# SPI_MOSI ? W11
set_property PACKAGE_PIN W11 [get_ports {spi_mosi}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_mosi}]

# SPI_SS_N ? V10
set_property PACKAGE_PIN V10 [get_ports {spi_cs_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_cs_n}]
# PWM LED (already existing)
set_property PACKAGE_PIN T22 [get_ports {led_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out}]

# SPI data received LED
set_property PACKAGE_PIN T21 [get_ports {led_rx}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_rx}]


# Bank-wide I/O standard for Bank 13 (PMODs at 3.3V)
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]]

# Optional: allow suboptimal clock route
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_100mhz]
