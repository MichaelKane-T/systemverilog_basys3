module delay_counter #(
    parameter int CLK_FREQ_HZ = 1_000_000,
    parameter int DELAY_MS =  10
)(
    input  logic clk,
    input  logic start,
    input  logic reset,
    output logic done
); 

localparam int DELAY_CYCLES = (CLK_FREQ_HZ *DELAY_MS) / 1000;

int unsigned counter;
logic running;

always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            running <= 1'b0;
            done    <= 1'b0;
        end else begin
            done <= 1'b0; 

            // Start and counting logic go here.
            if (!running && start) begin
            counter <= 0;
            running <= 1'b1;

            end else if (running) begin
                if (counter == DELAY_CYCLES - 1) begin
                    done    <= 1'b1;
                    running <= 1'b0;

                end else begin
                   counter <= counter + 1;
                end
            end
        end
end


endmodule