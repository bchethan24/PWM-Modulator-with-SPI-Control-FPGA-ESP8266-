`timescale 1ns/1ps
module spi_pwm_top(
    input  wire clk_100mhz,
    input  wire rst_n,
    input  wire spi_sclk,
    input  wire spi_mosi,
    input  wire spi_cs_n,
    output wire led_out,   // PWM LED output
    output wire led_rx     // LED blink on new SPI data
);
    wire clk_1mhz;
    wire [2:0] duty_value;
    wire data_received;

    // 1 MHz Clock Generator
    clock_divider #(.DIV(50)) u_clkdiv (
        .clk_in(clk_100mhz),
        .rst(~rst_n),
        .clk_out(clk_1mhz)
    );

    // 3-bit SPI Slave
    spi_slave u_spi (
        .clk(clk_1mhz),
        .cs_n(spi_cs_n),
        .sclk(spi_sclk),
        .mosi(spi_mosi),
        .data(duty_value),
        .data_received(data_received)
    );

    // 3-bit PWM Generator
    pwm_gen u_pwm (
        .clk(clk_1mhz),
        .duty(duty_value),
        .pwm_out(led_out)
    );

    // Optional LED blink when data received
    assign led_rx = data_received;

endmodule
