`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module Top #(parameter N = 4)   // Default width = 4
            (input clk,
             input reset,
             output wire signed [7:0] out,       // Declare output as signed for ---> read_memory.v module <---
             output wire [N-1:0] lfsr_4bit,            // Declare lfsr for ---> RandomNoiseLFSR.v module <---
             output wire [N*2-1:0] lfsr_8bit            // Declare lfsr for ---> RandomNoiseLFSR.v module <---
             );
    
    // Instantiation of the read_memory module
    read_memory rm (.clk(clk), .out(out));  

    // Instantiation of the RandomNoiseLFSR module
    localparam N4 = 4;
    localparam N8 = 8;
    
    RandomNoiseLFSR #(.N(N4)) lfsr1 (
                                     .clk(clk), 
                                     .reset(reset), 
                                     .lfsr(lfsr_4bit)
                                     );    
           
    RandomNoiseLFSR #(.N(N8)) lfsr2 (
                                     .clk(clk), 
                                     .reset(reset), 
                                     .lfsr(lfsr_8bit)
                                     );    
    
endmodule
