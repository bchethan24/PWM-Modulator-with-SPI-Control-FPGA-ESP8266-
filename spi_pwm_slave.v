module spi_pwm_slave (
    input wire clk_100khz,   // internal clock domain
    input wire spi_sclk,     // external SPI clock (from ESP)
    input wire spi_mosi,
    input wire spi_cs,
    output wire led_pwm
);

    reg [7:0] data_in = 0;
    reg [2:0] bit_cnt = 0;
    reg [7:0] duty_value = 0;

    // Edge detection for spi_sclk (sampled on internal clock)
    reg spi_sclk_d1, spi_sclk_d2;
    always @(posedge clk_100khz) begin
        spi_sclk_d1 <= spi_sclk;
        spi_sclk_d2 <= spi_sclk_d1;
    end

    wire spi_sclk_rising = (spi_sclk_d1 & ~spi_sclk_d2);

    // SPI receive logic using detected edges
    always @(posedge clk_100khz) begin
        if (spi_cs) begin
            bit_cnt <= 0;
        end else if (spi_sclk_rising) begin
            data_in <= {data_in[6:0], spi_mosi};
            bit_cnt <= bit_cnt + 1;
            if (bit_cnt == 7)
                duty_value <= {data_in[6:0], spi_mosi};
        end
    end

    // Simple PWM generation
    reg [6:0] counter = 0;
    reg pwm_out = 0;
    always @(posedge clk_100khz) begin
        counter <= counter + 1;
        pwm_out <= (counter < duty_value[6:0]);
    end

    assign led_pwm = pwm_out;

endmodule
