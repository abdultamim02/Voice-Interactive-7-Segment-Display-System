`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module DigitTo7SegmentDisplay_tb;

    reg clk;
    reg reset;
    reg [5:0] ID;                       // 6 bit input ID for a specifc number for ---> DigitTo7SegmentDisplay.v module <---
    wire [13:0] Seven_Segment_Display;  // 14 bit output testing for seven segment display for ---> DigitTo7SegmentDisplay.v module <---
    
    parameter ClockPeriod = 10;     // ClockPeriod is 10 ns
    
    // Clock generation
    initial clk = 0;            // Initialize clock signal to active low (0) at the start of simulation
    always #(ClockPeriod / 2) clk = ~clk;       // Continuously toggle the clock every (10 / 2 = 5 ns) to create a waveform
    
    // Instantiation of the DigitTo7SegmentDisplay module
    DigitTo7SegmentDisplay display (.clk(clk), 
                                    .reset(reset), 
                                    .ID(ID),
                                    .Seven_Segment_Display(Seven_Segment_Display)
                                    );

    initial begin
        // Initialize reset
        reset = 1;      // Start with reset enabled
        
        // Wait for a few cycles and then release reset
        #5;
        reset = 0;      // Deactivte reset
        
        // DigitTo7SegmentDisplay.v module testing
        #20;
        ID = 0;                      // Start with ID = 0 (IDEL state)
        
        #20;
        ID = 5;                      // Change ID to 5 (move to START state)
        
        #20;
        ID = 13;                     // Record number
        
        #20;
        ID = 35;                     // Record number
        
        #20;
        ID = 44;                     // Record number
        
        #20;
        ID = 46;                     // 46 Indicates no more numbers (move to DONE state)
        
        #20;
        ID = 47;                     // 47 indicates there is another number to display (go back to START state)
        
        #20;
        ID = 30;                     // Record number
        
        #20;
        ID = 38;                     // Record number
        
        #20;
        ID = 46;                     // 46 Indicates no more numbers (move to DONE state)
        
        #20;
        ID = 0;                      // 0 Indicates no more numbers (back to IDEL state)
        
        // Simulate for 50ns
        #50;
        $finish;
    end
    
endmodule

