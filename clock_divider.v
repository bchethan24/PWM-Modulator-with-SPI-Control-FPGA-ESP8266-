`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2025 16:28:56
// Design Name: 
// Module Name: clock_divider
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

module clock_divider #(
    parameter DIV = 50   // Divide 100MHz ? 1MHz: 100/2/50=1MHz
)(
    input wire clk_in,
    input wire rst,
    output reg clk_out
);
    reg [31:0] counter;

    always @(posedge clk_in or posedge rst) begin
        if(rst) begin
            counter <= 0;
            clk_out <= 0;
        end else if(counter == (DIV-1)) begin
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule


