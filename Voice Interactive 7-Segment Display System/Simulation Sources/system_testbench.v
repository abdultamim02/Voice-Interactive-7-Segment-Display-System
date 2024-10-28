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
    reg read;                           // 1 bit input read signal for ---> DataMemoryAddress module <---
    reg write;                          // 1 bit input write signal for ---> DataMemoryAddress module <---
    wire signed [7:0] out;              // Sine wave output from the ---> read_memory.v module <---
    wire [N-1:0] lfsr_4bit;             // 4 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*2-1:0] lfsr_8bit;           // 8 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*8-1:0] lfsr_32bit;          // 32 bit output from ---> RandomNoiseLFSR.v module <---
    wire Control_Module;                // 1 bit output Input Port for ---> DataMemoryAddress module <---
    wire UART1;                         // 1 bit output Output Port for ---> DataMemoryAddress module <---
    wire CE0;                           // 1 bit output first SRAM Chip Enable for ---> DataMemoryAddress module <---
    wire CE1;                           // 1 bit output second SRAM Chip Enable for ---> DataMemoryAddress module <---
    wire OE0;                           // 1 bit output first SRAM Output Enable for ---> DataMemoryAddress module <---
    wire OE1;                           // 1 bit output second SRAM Output Enable for ---> DataMemoryAddress module <---
    wire WE0;                           // 1 bit output first SRAM Write Enable for ---> DataMemoryAddress module <---
    wire WE1;                           // 1 bit output second SRAM Write Enable for ---> DataMemoryAddress module <---
    wire CS0;                           // 1 bit output first Flash CS0 for ---> ProgramAddressMap module <---
    wire CS1;                           // 1 bit output second Flash CS1 for ---> ProgramAddressMap module <---
    wire WP;                            // 1 bit output Write Protect for ---> ProgramAddressMap module <---
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
          .address(address),
          .ID(ID),
          .read(read),
          .write(write),
          .out(out),
          .lfsr_4bit(lfsr_4bit),
          .lfsr_8bit(lfsr_8bit),
          .lfsr_32bit(lfsr_32bit),
          .Control_Module(Control_Module),
          .UART1(UART1),
          .CE0(CE0),
          .CE1(CE1),
          .OE0(OE0),
          .OE1(OE1),
          .WE0(WE0),
          .WE1(WE1),
          .CS0(CS0),
          .CS1(CS1),
          .WP(WP),
          .Seven_Segment_Display(Seven_Segment_Display)
          );

    initial begin
        // Initialize reset
        reset = 1;      // Start with reset enabled
        nRESET = 0;     // Start with nREST disabled
        
        read = 0;
        write = 0;

        // Wait for a few cycles and then release reset
        #5;
        reset = 0;      // Deactivte reset
        nRESET = 1;     // Activte nREST
        
        // ProgramAddressMap module Testing
        #50;
        address = 32'h0000_0BCD;      // An address between 0x0000_0000 to 0x07FF_FFFF (Flash 0)
        
        #50;
        address = 32'h0800_0CBA;      // An address between 0x0800_0000 to 0x0FFF_FFFF (Flash 1)
        
        #50;
        address = 32'h2000_0DEF;      // An address between 0x2000_0000 - 0x4AFF_FFFF (Not Used)
        
        // DataMemoryAddress module Testing
        #50;
        address = 32'h1000_08AD;      // An address between 0x1000_0000 to 0x13FF_FFFF (SRAM 0)
        
        #10;
        read = 1;
        
        #10;
        read = 0;
        write = 1;
        
        #10;
        write = 0;
        
        #50;
        address = 32'h1400_0F32;      // An address between 0x1400_0000 to 0x17FF_FFFF (SRAM 1)
        
        #10;
        read = 1;
        
        #10;
        read = 0;
        write = 1;
        
        #10;
        write = 0;
        
        #50;
        address = 32'h2000_0FFA;      // An address between 0x2000_0000 to 0x44E0_FFFF (Not Used)
        
        #50;
        address = 32'h44E1_0ABC;      // An address between 0x44E1_0000 to 0x44E1_1FFF (Control Module)
        
        #50;
        address = 32'h44E1_28AD;      // An address between 0x44E1_2000 to 0x4802_1FFF (Not Used)
        
        #50;
        address = 32'h4802_2C58;      // An address between 0x4802_2000 to 0x4802_2FFF (UART1)
        
        #50;
        address = 32'h4802_3BBB;      // An address between 0x4802_3000 to 0x4AFF_FFFF (Not Used)
        
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
                
        // Generate noise for a certain number of clock cycles
        // repeat (50) begin
        //    #10; // Wait for 10ns (one clock period)
        // end
        
        // Simulate for 200ns
        #100;
        $finish;
    end
    
endmodule

