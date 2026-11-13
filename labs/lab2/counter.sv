/*
 * delay_counter.sv
 *
 * A simple delay counter that counts clock cycles to create a delay.
 * The counter starts counting when the 'start' signal is asserted and
 * asserts the 'done' signal after the specified delay in milliseconds.
 *
 * Parameters:
 * - CLK_FREQ_HZ: The frequency of the input clock in Hertz (default: 1 MHz).
 * - DELAY_MS: The desired delay in milliseconds (default: 10 ms).
 *
 * Inputs:
 * - clk: The input clock signal.
 * - start: Signal to start the counting process.
 * - reset: Signal to reset the counter and state.
 *
 * Outputs:
 * - done: Signal that indicates the counting is complete.
 */


module delay_counter #(
    parameter int CLK_FREQ_HZ = 1_000_000,
    parameter int DELAY_MS =  10
)(
    input  logic clk,
    input  logic start,
    input  logic reset,
    output logic done
); 

localparam int DELAY_CYCLES = (CLK_FREQ_HZ/1000)*DELAY_MS; // Calculate the number of clock cycles for the desired delay

int unsigned counter;
logic running;

// Sequential logic for the delay counter
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