`timescale 1ns/1ps
module spi_pwm_top(
    input wire clk_100mhz,
    input wire rst_n,
    input wire spi_sclk,
    input wire spi_mosi,
    input wire spi_cs_n,
    output wire led_out,         
    output wire led_rx           
);

    wire clk_1mhz;
    wire [7:0] duty_value;
    wire data_received;

    // -------- Clock Divider --------
    clock_divider #(.DIV(50)) u_clkdiv (
        .clk_in(clk_100mhz),
        .rst(~rst_n),
        .clk_out(clk_1mhz)
    );

    
    spi_slave u_spi (
        .clk(clk_1mhz),
        .cs_n(spi_cs_n),
        .sclk(spi_sclk),
        .mosi(spi_mosi),
        .data(duty_value),
        .data_received(data_received)
    );

    // -------- PWM Generator --------
    pwm_gen u_pwm (
        .clk(clk_1mhz),
        .duty(duty_value),
        .pwm_out(led_out)
    );

    // -------- Optional LED to indicate SPI data received --------
    assign led_rx = data_received;

endmodule
