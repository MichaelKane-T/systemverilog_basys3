/*******************************************************************************
 * Author: Michael Kane
 * Date: 2026-11-06
 * Seven Segment Display Decoder
 * 
 * This module takes a 4-bit binary input and outputs the corresponding
 * 7-bit pattern to drive a seven-segment display. The output is active-low,
 * meaning that a '0' turns on a segment, while a '1' turns it off.
 ******************************************************************************/

module seven_seg_dec (
    input  logic [3:0] d_in,
    output logic [6:0] d_out
);

    
    // d_out[6:0] = {g, f, e, d, c, b, a}
    // Active-low: 0 turns a segment on, 1 turns it off.
    assign d_out = (d_in == 4'h0) ? 7'b1000000 :
                   (d_in == 4'h1) ? 7'b1111001 :
                   (d_in == 4'h2) ? 7'b0100100 :
                   (d_in == 4'h3) ? 7'b0110000 :
                   (d_in == 4'h4) ? 7'b0011001 :
                   (d_in == 4'h5) ? 7'b0010010 :
                   (d_in == 4'h6) ? 7'b0000010 :
                   (d_in == 4'h7) ? 7'b1111000 :
                   (d_in == 4'h8) ? 7'b0000000 :
                   (d_in == 4'h9) ? 7'b0010000 :
                   (d_in == 4'hA) ? 7'b0001000 :
                   (d_in == 4'hB) ? 7'b0000011 :
                   (d_in == 4'hC) ? 7'b1000110 :
                   (d_in == 4'hD) ? 7'b0100001 :
                   (d_in == 4'hE) ? 7'b0000110 :
                   (d_in == 4'hF) ? 7'b0001110 :
                                    7'b1111111;

endmodule


// module seven_seg_dec (
//     input  logic [3:0] d_in,
//     output logic [6:0] d_out
// );

//     // d_out[6:0] = {g, f, e, d, c, b, a}
//     always_comb begin
//         case (d_in)
//             4'h0: d_out = 7'b1000000;
//             4'h1: d_out = 7'b1111001;
//             4'h2: d_out = 7'b0100100;
//             4'h3: d_out = 7'b0110000;
//             4'h4: d_out = 7'b0011001;
//             4'h5: d_out = 7'b0010010;
//             4'h6: d_out = 7'b0000010;
//             4'h7: d_out = 7'b1111000;
//             4'h8: d_out = 7'b0000000;
//             4'h9: d_out = 7'b0010000;
//             4'hA: d_out = 7'b0001000;
//             4'hB: d_out = 7'b0000011;
//             4'hC: d_out = 7'b1000110;
//             4'hD: d_out = 7'b0100001;
//             4'hE: d_out = 7'b0000110;
//             4'hF: d_out = 7'b0001110;
//             default: d_out = 7'b1111111;
//         endcase
//     end

// endmodule