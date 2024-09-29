`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module read_memory (
    input clk,
    output reg signed [7:0] out         // Declare output as signed
);
    
    reg signed [7:0] memory [0:255];        // Memory array to hold signed sine wave values
    reg [7:0] i = 0;                        // Memory index pointer

    initial begin
        $readmemb("SineWave.mem", memory);      // Load memory from file
    end

    always @(posedge clk) begin
        out <= memory[i];           // Output the current memory value
        $display("Time: %0t | Index: %d | Value: %d (Binary: %b)", $time, i, out, out);             // Detailed debug output
        i <= (i == 255) ? 0 : i + 1;            // Wrap around index
    end

endmodule
