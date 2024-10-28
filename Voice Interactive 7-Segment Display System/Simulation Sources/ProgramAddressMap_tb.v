`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module ProgramAddressMap_tb;

    // Parameters
    parameter N = 4;

    reg clk;
    reg nRESET;                         // Active Low reset
    reg [N*8-1:0] address;              // 32 bit input addrerss for ---> ProgramAddressMap and DataMemoryAddress modules <--- 
    wire CS0;                           // 1 bit output first Flash CS0 for ---> ProgramAddressMap module <---
    wire CS1;                           // 1 bit output second Flash CS1 for ---> ProgramAddressMap module <---
    wire WP;                            // 1 bit output Write Protect for ---> ProgramAddressMap module <---

    parameter ClockPeriod = 10;     // ClockPeriod is 10 ns
    
    // Clock generation
    initial clk = 0;            // Initialize clock signal to active low (0) at the start of simulation
    always #(ClockPeriod / 2) clk = ~clk;       // Continuously toggle the clock every (10 / 2 = 5 ns) to create a waveform
    
    // Instantiation of the ProgramAddressMap module
    ProgramAddressMap #(.N(N*8)) dataAdd (.clk(clk),
                                          .nRESET(nRESET),
                                          .address(address),
                                          .CS0(CS0),
                                          .CS1(CS1),
                                          .WP(WP)
                                         );

    initial begin
        // Initialize reset
        nRESET = 0;     // Start with nREST disabled

        // Wait for a few cycles and then release reset
        #5;
        nRESET = 1;     // Activte nREST
        
        // Flash Addresses Testing
        #30;
        address = 32'h0000_0BCD;      // An address between 0x0000_0000 to 0x07FF_FFFF
        
        #30;
        address = 32'h0800_0CBA;      // An address between 0x0800_0000 to 0x0FFF_FFFF
                
        #30;
        address = 32'h2000_0DEF;      // An address between 0x2000_0000 - 0x4AFF_FFFF
        
        // Simulate for 50ns
        #50;
        $finish;
    end
    
endmodule

