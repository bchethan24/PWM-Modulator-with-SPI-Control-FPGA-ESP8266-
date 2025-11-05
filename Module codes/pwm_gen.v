`timescale 1ns / 1ps
module pwm_gen(
    input  wire clk,         // PWM clock (1 MHz)
    input  wire [2:0] duty,  // duty cycle (0–7)
    output reg pwm_out
);
    reg [2:0] counter = 0;

    always @(posedge clk) begin
        counter <= counter + 1;
        pwm_out <= (counter < duty);
    end
endmodule
