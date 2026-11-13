module counter_top (
    output logic led,
    input  logic clk,
    input  logic reset
);

    logic done;
    logic start;

    delay_counter #(
        .CLK_FREQ_HZ(100_000_000),
        .DELAY_MS(500)
    ) counter (
        .clk(clk),
        .start(start),
        .reset(reset),
        .done(done)
    );

    always_ff @(posedge clk) begin
        if (reset) begin
            start <= 1'b0;
            led   <= 1'b0;
        end else begin
            if (done) begin
                led   <= ~led; // Toggle the LED when done
                start <= 1'b0; // Stop counting after done
            end else if (!start) begin
                start <= 1'b1; // Start counting if not already started
            end
        end
    end
    
endmodule