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
    reg nRESET;                         // Active Low reset
    reg [N*8-1:0] address;              // 32 bit input addrerss for ---> ProgramAddressMap and DataMemoryAddress modules <--- 
    reg [5:0] ID;                       // 6 bit input ID for a specifc number for ---> DigitTo7SegmentDisplay.v module <---
    wire signed [7:0] out;              // Sine wave output from the ---> read_memory.v module <---
    wire [N-1:0] lfsr_4bit;             // 4 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*2-1:0] lfsr_8bit;           // 8 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*8-1:0] lfsr_32bit;          // 32 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*4-1:0] SRAM_0;              // 16 bit output first SRAM for ---> ProgramAddressMap module <---
    wire [N*4-1:0] SRAM_1;              // 16 bit output second SRAM for ---> ProgramAddressMap module <---
    wire [N*4-1:0] UART1;               // 16 bit output UART1 for ---> ProgramAddressMap module <---
    wire [N*4-1:0] Control_Module;      // 16 bit output Control Module for ---> ProgramAddressMap module <---
    wire [N/2:0] active_select;         // 2 bit active select (indicating which memory I/O was chosen) for ---> ProgramAddressMap module <---
    wire [N*4-1:0] Flash_0;             // 16 bit output first Flash for ---> DataMemoryAddress module <---
    wire [N*4-1:0] Flash_1;             // 16 bit output second Flash for ---> DataMemoryAddress module <---
    wire [1:0] chip_select;             // 1 bit chip select (indicating which memory IC was chosen) for ---> DataMemoryAddress module <---
    wire CE;                            // 1 bit output Chip Enable for ---> SRAM_Chip_Enable module <---
    wire OE;                            // 1 bit output Output Enable for ---> SRAM_Chip_Enable module <---
    wire WE;                            // 1 bit output Write Enable for ---> SRAM_Chip_Enable module <---
    wire WP;                            // 1 bit output Write Protect for ---> SRAM_Chip_Enable module <---
    wire [13:0] Seven_Segment_Display;  // 14 bit output testing for seven segment display for ---> DigitTo7SegmentDisplay.v module <---
    
    parameter ClockPeriod = 10;     // ClockPeriod is 10 ns
    
    // Clock generation
    initial clk = 0;            // Initialize clock signal to active low (0) at the start of simulation
    always #(ClockPeriod / 2) clk = ~clk;       // Continuously toggle the clock every (10 / 2 = 5 ns) to create a waveform
    
    // Instantiate the design under test (DUT)
    Top #(.N(N)) top
         (.clk(clk),
          .reset(reset),
          .nRESET(nRESET),
          .ID(ID),
          .address(address),
          .out(out),
          .lfsr_4bit(lfsr_4bit),
          .lfsr_8bit(lfsr_8bit),
          .lfsr_32bit(lfsr_32bit),
          .SRAM_0(SRAM_0),
          .SRAM_1(SRAM_1),
          .UART1(UART1),
          .Control_Module(Control_Module),
          .active_select(active_select),
          .Flash_0(Flash_0),
          .Flash_1(Flash_1),
          .chip_select(chip_select),
          .CE(CE),
          .OE(OE),
          .WE(WE),
          .WP(WP),
          .Seven_Segment_Display(Seven_Segment_Display)
          );

    initial begin
        // Initialize reset
        reset = 1;      // Start with reset enabled
        nRESET = 0;     // Start with nREST disabled

        // Wait for a few cycles and then release reset
        #10;
        reset = 0;      // Deactivte reset
        nRESET = 1;     // Activte nREST
        
        // Flash Addresses Testing
        #30;
        address = 32'h0045_ABCD;      // An address between 0x0000_0000 to 0x07FF_FFFF
        
        #30;
        address = 32'h0901_DCBA;      // An address between 0x0800_0000 to 0x0FFF_FFFF
        
        // SRAM Address Testing
        #60;
        address = 32'h12AB_78AD;      // An address between 0x1000_0000 to 0x13FF_FFFF
        
        #30;
        address = 32'h1649_EF32;      // An address between 0x1400_0000 to 0x17FF_FFFF
        
        #30;
        address = 32'h4802_2FFA;      // An address between 0x4802_2000 to 0x4802_2FFF
        
        #30;
        address = 32'h44E1_0ABC;      // An address between 0x44E1_0000 to 0x44E1_1FFF
        
        #30;
        ID = 0;                      // Start with ID = 0 (IDEL state)
        
        #30;
        ID = 5;                      // Change ID to 5 (move to START state)
        
        #30;
        ID = 13;                     // Record number
        
        #30;
        ID = 35;                     // Record number
        
        #30;
        ID = 44;                     // Record number
        
        #30;
        ID = 46;                     // 46 Indicates no more numbers (move to DONE state)
        
        #30;
        ID = 47;                     // 47 indicates there is another number to display (go back to START state)
        
        #30;
        ID = 30;                     // Record number
        
        #30;
        ID = 38;                     // Record number
        
        #30;
        ID = 46;                     // 46 Indicates no more numbers (move to DONE state)
        
        #30;
        ID = 0;                      // 0 Indicates no more numbers (back to IDEL state)
                
        // Generate noise for a certain number of clock cycles
        // repeat (50) begin
        //    #10; // Wait for 10ns (one clock period)
        // end
        
        // Simulate for 100ns
        #50;
        $finish;
    end
    
endmodule

