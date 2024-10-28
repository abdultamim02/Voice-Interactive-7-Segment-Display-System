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
             input read,                                    // 1 bit input read signal for ---> DataMemoryAddress module <---
             input write,                                   // 1 bit input write signal for ---> DataMemoryAddress module <---
             output wire signed [7:0] out,                  // Declare output as signed for ---> read_memory.v module <---
             output wire [N-1:0] lfsr_4bit,                 // Declare lfsr_4bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*2-1:0] lfsr_8bit,               // Declare lfsr_8bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*8-1:0] lfsr_32bit,              // Declare lfsr_32bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*4-1:0] Control_Module,          // 16 bit output Control Module for ---> DataMemoryAddress module <---
             output wire [N*4-1:0] UART1,                   // 16 bit output UART1  for ---> DataMemoryAddress module <---
             output wire CE0,                               // 1 bit output first SRAM Chip Enable for ---> DataMemoryAddress module <---
             output wire CE1,                               // 1 bit output second SRAM Chip Enable for ---> DataMemoryAddress module <---
             output wire OE0,                               // 1 bit output first SRAM Output Enable for ---> DataMemoryAddress module <---
             output wire OE1,                               // 1 bit output second SRAM Output Enable for ---> DataMemoryAddress module <---
             output wire WE0,                               // 1 bit output first SRAM Write Enable for ---> DataMemoryAddress module <---
             output wire WE1,                               // 1 bit output second SRAM Write Enable for ---> DataMemoryAddress module <---
             output wire CS0,                               // 1 bit output first Flash CS0 for ---> ProgramAddressMap module <---
             output wire CS1,                               // 1 bit output second Flash CS1 for ---> ProgramAddressMap module <---
             output wire WP,                                // 1 bit output Chip Enable for ---> ProgramAddressMap module <---
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
                                          .CS0(CS0),
                                          .CS1(CS1),
                                          .WP(WP)
                                         );
    
    // Instantiation of the DataMemoryAddress module
    DataMemoryAddress #(.N(N*8)) progAdd (.clk(clk),
                                          .nRESET(nRESET),
                                          .address(address),
                                          .read(read),
                                          .write(write),
                                          .Control_Module(Control_Module),
                                          .UART1(UART1),
                                          .CE0(CE0),
                                          .CE1(CE1),
                                          .OE0(OE0),
                                          .OE1(OE1),
                                          .WE0(WE0),
                                          .WE1(WE1)
                                         );
    
    // Instantiation of the DigitTo7SegmentDisplay module
    DigitTo7SegmentDisplay display (.clk(clk), 
                                    .reset(reset), 
                                    .ID(ID),
                                    .Seven_Segment_Display(Seven_Segment_Display)
                                    );
    
endmodule
