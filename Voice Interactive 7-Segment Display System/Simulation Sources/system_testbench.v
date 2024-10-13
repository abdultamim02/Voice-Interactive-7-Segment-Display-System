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
    reg [N*4-1:0] address;              // 16 bit input addrerss for ---> ProgramAddressMap and DataMemoryAddress modules <--- 
    wire signed [7:0] out;              // Sine wave output from the ---> read_memory.v module <---
    wire [N-1:0] lfsr_4bit;             // 4 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*2-1:0] lfsr_8bit;           // 8 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*8-1:0] lfsr_32bit;          // 32 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*2-1:0] SRAM_0;              // 8 bit output first SRAM for ---> ProgramAddressMap module <---
    wire [N*2-1:0] SRAM_1;              // 8 bit output second SRAM for ---> ProgramAddressMap module <---
    wire [N*2-1:0] Output_Port;         // 8 bit output Output Port for ---> ProgramAddressMap module <---
    wire [N*2-1:0] Input_Port;          // 8 bit output Input Port for ---> ProgramAddressMap module <---
    wire [N/2:0] active_select;         // 2 bit active select (indicating which memory I/O was chosen) for ---> ProgramAddressMap module <---
    wire [N*2-1:0] Flash_0;             // 8 bit output first Flash for ---> DataMemoryAddress module <---
    wire [N*2-1:0] Flash_1;             // 8 bit output second Flash for ---> DataMemoryAddress module <---
    wire [1:0] chip_select;             // 1 bit chip select (indicating which memory IC was chosen) for ---> DataMemoryAddress module <---
    wire CE;                            // 1 bit output Chip Enable for ---> SRAM_Chip_Enable module <---
    
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
          .out(out),
          .lfsr_4bit(lfsr_4bit),
          .lfsr_8bit(lfsr_8bit),
          .lfsr_32bit(lfsr_32bit),
          .SRAM_0(SRAM_0),
          .SRAM_1(SRAM_1),
          .Output_Port(Output_Port),
          .Input_Port(Input_Port),
          .active_select(active_select),
          .Flash_0(Flash_0),
          .Flash_1(Flash_1),
          .chip_select(chip_select),
          .CE(CE)
          );

    initial begin
        // Initialize reset
        reset = 1;      // Start with reset enabled
        nRESET = 0;     // Start with nREST disabled

        // Wait for a few cycles and then release reset
        #10;
        reset = 0;      // Deactivte reset
        nRESET = 1;     // Activte nREST
        
        #30;
        address = 16'h1AB9;      // An address between 0000 - 1FFFF
        
        #30;
        address = 16'h33A7;      // An address between 2000 - 3FFFF
        
        #30;
        address = 16'h58FB;      // An address between 4000 - 5FFFF
        
        #30;
        address = 16'h700F;      // An address between 6000 - 7FFFF
        
        // Generate noise for a certain number of clock cycles
        // repeat (50) begin
        //    #10; // Wait for 10ns (one clock period)
        // end
        
        // Simulate for 400ns
        #400;
        $finish;
    end
    
endmodule

