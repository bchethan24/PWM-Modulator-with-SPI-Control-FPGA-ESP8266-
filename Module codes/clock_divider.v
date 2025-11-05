`timescale 1ns / 1ps
module clock_divider #(parameter DIV = 50)
(
    input  wire clk_in,
    input  wire rst,
    output reg  clk_out
);
    reg [31:0] counter = 0;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else if (counter == (DIV - 1)) begin
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
