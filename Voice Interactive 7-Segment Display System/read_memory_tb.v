`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module read_memory_tb;

    // Parameters
    reg clk;
    wire signed [7:0] out;              // This will hold the output from the read_memory module
    reg [7:0] memory [0:255];           // Array to hold memory data
    
    parameter ClockPeriod = 10;     // ClockPeriod is 10 ns
    
    // Clock generation
    initial clk = 0;            // Initialize clock signal to active low (0) at the start of simulation
    always #(ClockPeriod / 2) clk = ~clk;       // Continuously toggle the clock every (10 / 2 = 5 ns) to create a waveform
    
    // Instantiate the design under test (DUT)
    read_memory rm (.clk(clk), .out(out));  

    initial begin
        // Initialize memory from SineWave.mem file
        $readmemb("SineWave.mem", memory);
        
        // Wait for some time to let everything initialize
        #10;
        
        // Simulate for 400ns
        #400;
        $finish;
    end
    
endmodule
