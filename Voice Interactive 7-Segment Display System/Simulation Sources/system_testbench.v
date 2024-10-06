`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module system_testbench;

    // Parameters
    parameter N = 4;

    reg clk;
    reg reset;
    wire signed [7:0] out;              // This will hold the output from the read_memory module
    
    parameter N4 = 4;
    wire [N4-1:0] lfsr_4bit;
    
    parameter N8 = 8;
    wire [N8-1:0] lfsr_8bit;
    
    parameter ClockPeriod = 10;     // ClockPeriod is 10 ns
    
    // Clock generation
    initial clk = 0;            // Initialize clock signal to active low (0) at the start of simulation
    always #(ClockPeriod / 2) clk = ~clk;       // Continuously toggle the clock every (10 / 2 = 5 ns) to create a waveform
    
    // Instantiate the design under test (DUT)
    Top #(.N(N)) top
         (.clk(clk),
          .reset(reset),
          .out(out),
          .lfsr_4bit(lfsr_4bit),
          .lfsr_8bit(lfsr_8bit)
          );

    initial begin
        // Initialize reset
        reset = 1;  // Start with reset enabled

        // Wait for a few cycles and then release reset
        #10;
        reset = 0;
        
        // Generate noise for a certain number of clock cycles
        // repeat (50) begin
        //    #10; // Wait for 10ns (one clock period)
        // end
        
        // Simulate for 400ns
        #400;
        $finish;
    end
    
endmodule

