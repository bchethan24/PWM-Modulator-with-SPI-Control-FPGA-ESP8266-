`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2025 16:29:42
// Design Name: 
// Module Name: spi_slave
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module spi_slave(
    input wire clk,          // sampling clock (e.g., 1 MHz)
    input wire cs_n,         // SPI chip select (active low)
    input wire sclk,         // SPI clock from master
    input wire mosi,         // SPI data from master
    output reg [7:0] data,   // received byte
    output reg data_received // pulse high when new byte received
);
    reg [7:0] shift_reg = 0;
    reg [2:0] bit_cnt = 0;
    reg sclk_d = 0;

    always @(posedge clk) begin
        sclk_d <= sclk; // delay to detect rising edge
        data_received <= 0;

        if(!cs_n) begin
            // rising edge of SPI clock
            if(sclk && !sclk_d) begin
                shift_reg <= {shift_reg[6:0], mosi};
                bit_cnt <= bit_cnt + 1;

                if(bit_cnt == 7) begin
                    data <= {shift_reg[6:0], mosi};
                    data_received <= 1; // pulse to indicate new data
                    bit_cnt <= 0;
                end
            end
        end else begin
            bit_cnt <= 0;
        end
    end
endmodule

