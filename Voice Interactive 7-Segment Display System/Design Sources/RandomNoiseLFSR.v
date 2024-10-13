`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module RandomNoiseLFSR #(parameter N = 4)   // Default width = 4
                        (input clk, 
                         input reset,
                         output reg [N-1:0] lfsr
                         );
    
    wire xor_first_bit;
    
    // Tap selection based on parameter N
    generate
        if (N == 4) begin
            // For a 4-bit LFSR
            assign xor_first_bit = (lfsr ^ (lfsr >> 1)) & 1;  // Taps: 4th and 3rd bits
        end
        else if (N == 8) begin
            // For an 8-bit LFSR
            assign xor_first_bit = (lfsr ^ (lfsr >> 8) ^ (lfsr >> 6) ^ (lfsr >> 5) ^ (lfsr >> 4)) & 1;  // Taps: 8th, 6th, 5th, 4th bits
        end
        else if (N == 32) begin
            // For an 8-bit LFSR
            assign xor_first_bit = (lfsr ^ (lfsr >> 32) ^ (lfsr >> 30) ^ (lfsr >> 26) ^ (lfsr >> 25)) & 1;  // Taps: 32nd, 30th, 26th, 25th bits
        end
        else begin
            assign xor_first_bit = 1'b0;
        end
    endgenerate

    always @(posedge clk or posedge reset) begin
        if (reset)
            if (N == 4) begin
                lfsr <= (1 << 4) - 1;            // Initial value when N = 4
            end
            else if (N == 8) begin
                lfsr <= (1 << 8) - 1;   // Initial value when N = 8
            end
            else if (N == 32) begin
                lfsr <= (1 << 32) - 1;
            end
            else begin
                lfsr <= {N{1'b0}};      // Default reset value for other N
            end
        else begin
            // Shift operation based on N
            if (N == 4) begin
                lfsr <= {(lfsr >> 1) | (xor_first_bit << 3)};   // Shift left and insert xor_first_bit
            end
            else if (N == 8) begin
                lfsr <= {(lfsr >> 1) | (xor_first_bit << 7)};   // Shift left and insert xor_first_bit
            end
            else if (N == 32) begin
                lfsr <= {(lfsr >> 1) | (xor_first_bit << 31)};   // Shift left and insert xor_first_bit
            end
        end
    end
    
endmodule
