module seven_seg_top (
    input  logic [3:0] sw,
    output logic [6:0] seg,
    output logic [3:0] an,
    output logic dp

);

    logic [6:0] decoded;

    seven_seg_dec dec (
        .d_in(sw),
        .d_out(decoded)
    );

    assign seg = decoded;   // Connect the decoded output to the segment outputs
    assign an = 4'b1110;    // Enable only the first digit (active-low)
    assign dp = 1'b1;       // Decimal point off (active-low)

endmodule


           