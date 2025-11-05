`timescale 1ns / 1ps
module spi_slave(
    input  wire clk,           // sampling clock (1 MHz)
    input  wire cs_n,          // SPI chip select (active low)
    input  wire sclk,          // SPI clock from master
    input  wire mosi,          // SPI data from master
    output reg [2:0] data,     // 3-bit received data
    output reg data_received   // pulse when new data received
);
    reg [2:0] shift_reg = 0;
    reg [1:0] bit_cnt = 0;     // count up to 3 bits
    reg sclk_d = 0;

    always @(posedge clk) begin
        sclk_d <= sclk;
        data_received <= 0;

        if (!cs_n) begin
            // detect rising edge of SPI clock
            if (sclk && !sclk_d) begin
                shift_reg <= {shift_reg[1:0], mosi};
                bit_cnt <= bit_cnt + 1;

                // after 3 bits received
                if (bit_cnt == 2) begin
                    data <= {shift_reg[1:0], mosi};
                    data_received <= 1;
                    bit_cnt <= 0;
                end
            end
        end else begin
            bit_cnt <= 0;
        end
    end
endmodule
