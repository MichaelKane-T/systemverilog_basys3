/*
 * counter_top.sv
 *
 * Top-level module for the delay counter.
 * This module instantiates the delay_counter and controls the LED output.
 */

module counter_top (
    output logic led,
    input  logic clk,
    input  logic reset
);

    logic done;

    delay_counter #(
        .CLK_FREQ_HZ(100_000_000),
        .DELAY_MS(500)
    ) counter (
        .clk(clk),
        .start(1'b1),
        .reset(reset),
        .done(done)
    );

    always_ff @(posedge clk) begin
        if (reset) begin
            led <= 1'b0;
        end else if (done) begin
            led <= ~led;
        end
    end

endmodule