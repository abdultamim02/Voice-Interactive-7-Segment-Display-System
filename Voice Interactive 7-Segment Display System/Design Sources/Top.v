`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module Top #(parameter N = 4)   // Default width = 4
            (input clk,
             input reset,                                   // Avtive High reset
             input nRESET,                                  // Active Low reset
             input [5:0] ID,                                // 6 bit input ID for a specifc number for ---> DigitTo7SegmentDisplay.v module <---
             input [N*8-1:0] address,                       // 32 bit input addrerss for ---> ProgramAddressMap and DataMemoryAddress modules <--- 
             output wire signed [7:0] out,                  // Declare output as signed for ---> read_memory.v module <---
             output wire [N-1:0] lfsr_4bit,                 // Declare lfsr_4bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*2-1:0] lfsr_8bit,               // Declare lfsr_8bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*8-1:0] lfsr_32bit,              // Declare lfsr_32bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*4-1:0] SRAM_0,                  // 16 bit output first SRAM for ---> ProgramAddressMap module <---
             output wire [N*4-1:0] SRAM_1,                  // 16 bit output second SRAM for ---> ProgramAddressMap module <---
             output wire [N*4-1:0] UART1,                   // 16 bit output UART1 for ---> ProgramAddressMap module <---
             output wire [N*4-1:0] Control_Module,          // 16 bit output Control Module for ---> ProgramAddressMap module <---
             output wire [2:0] active_select,               // 2 bit active select (indicating which memory I/O was chosen) for ---> ProgramAddressMap module <---
             output wire [N*4-1:0] Flash_0,                 // 16 bit output first Flash for ---> DataMemoryAddress module <---
             output wire [N*4-1:0] Flash_1,                 // 16 bit output second Flash for ---> DataMemoryAddress module <---
             output wire [1:0] chip_select,                 // 1 bit chip select (indicating which memory I/O was chosen) for ---> DataMemoryAddress module <---
             output wire CE,                                // 1 bit output Chip Enable for ---> SRAM_Chip_Enable module <---
             output wire OE,                                // 1 bit output Chip Enable for ---> SRAM_Chip_Enable module <---
             output wire WE,                                // 1 bit output Chip Enable for ---> SRAM_Chip_Enable module <---
             output wire WP,                                // 1 bit output Chip Enable for ---> SRAM_Chip_Enable module <---
             output wire [N*3+1:0] Seven_Segment_Display    // 14 bit output testing for seven segment display for ---> DigitTo7SegmentDisplay.v module <---
             );
    
    // Instantiation of the read_memory module
    read_memory rm (.clk(clk), 
                    .out(out)
                    );  

    // Instantiation of the RandomNoiseLFSR module
    RandomNoiseLFSR #(.N(N)) lfsr1 (.clk(clk), 
                                     .reset(reset), 
                                     .lfsr(lfsr_4bit)
                                     );    
           
    RandomNoiseLFSR #(.N(N*2)) lfsr2 (.clk(clk), 
                                     .reset(reset), 
                                     .lfsr(lfsr_8bit)
                                     );    
    
    RandomNoiseLFSR #(.N(N*8)) lfsr3 (.clk(clk), 
                                      .reset(reset), 
                                      .lfsr(lfsr_32bit)
                                      );    
    
    // Instantiation of the ProgramAddressMap module
    ProgramAddressMap #(.N(N*8)) dataAdd (.clk(clk),
                                          .nRESET(nRESET),
                                          .address(address),
                                          .Flash_0(Flash_0),
                                          .Flash_1(Flash_1),
                                          .chip_select(chip_select)
                                         );
    
    // Instantiation of the DataMemoryAddress module
    DataMemoryAddress #(.N(N*8)) progAdd (.clk(clk),
                                          .nRESET(nRESET),
                                          .address(address),
                                          .SRAM_0(SRAM_0),
                                          .SRAM_1(SRAM_1),
                                          .UART1(UART1),
                                          .Control_Module(Control_Module),
                                          .active_select(active_select)
                                         );
                                         
    // Instantiation of the SRAM_Chip_Enable module
    Flash_SRAM_Control_Signals #(.N(N*8)) controlSig (.clk(clk),
                                                      .nRESET(nRESET),
                                                      .address(address),
                                                      .CE(CE),
                                                      .OE(OE),
                                                      .WE(WE),
                                                      .WP(WP)
                                                      );
    
    // Instantiation of the DigitTo7SegmentDisplay module
    DigitTo7SegmentDisplay display (.clk(clk), 
                                    .reset(reset), 
                                    .ID(ID),
                                    .Seven_Segment_Display(Seven_Segment_Display)
                                    );
    
endmodule
