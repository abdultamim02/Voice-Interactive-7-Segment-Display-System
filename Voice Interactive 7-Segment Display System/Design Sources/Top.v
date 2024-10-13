`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module Top #(parameter N = 4)   // Default width = 4
            (input clk,
             input reset,
             input nRESET,                          // Active Low reset
             input [N*4-1:0] address,               // 16 bit input addrerss for ---> ProgramAddressMap and DataMemoryAddress modules <--- 
             output wire signed [7:0] out,          // Declare output as signed for ---> read_memory.v module <---
             output wire [N-1:0] lfsr_4bit,         // Declare lfsr_4bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*2-1:0] lfsr_8bit,       // Declare lfsr_8bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*8-1:0] lfsr_32bit,      // Declare lfsr_32bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*2-1:0] SRAM_0,          // 8 bit output first SRAM for ---> ProgramAddressMap module <---
             output wire [N*2-1:0] SRAM_1,          // 8 bit output second SRAM for ---> ProgramAddressMap module <---
             output wire [N*2-1:0] Output_Port,     // 8 bit output Output Port for ---> ProgramAddressMap module <---
             output wire [N*2-1:0] Input_Port,      // 8 bit output Input Port for ---> ProgramAddressMap module <---
             output wire [2:0] active_select,       // 2 bit active select (indicating which memory I/O was chosen) for ---> ProgramAddressMap module <---
             output wire [N*2-1:0] Flash_0,         // 8 bit output first Flash for ---> DataMemoryAddress module <---
             output wire [N*2-1:0] Flash_1,         // 8 bit output second Flash for ---> DataMemoryAddress module <---
             output wire [1:0] chip_select,         // 1 bit chip select (indicating which memory I/O was chosen) for ---> DataMemoryAddress module <---
             output wire CE                         // 1 bit output Chip Enable for ---> SRAM_Chip_Enable module <---
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
    ProgramAddressMap #(.N(N*4)) progAdd (.clk(clk),
                                          .nRESET(nRESET),
                                          .address(address),
                                          .SRAM_0(SRAM_0),
                                          .SRAM_1(SRAM_1),
                                          .Output_Port(Output_Port),
                                          .Input_Port(Input_Port),
                                          .active_select(active_select)
                                         );
    
    // Instantiation of the DataMemoryAddress module
    DataMemoryAddress #(.N(N*4)) dataAdd (.clk(clk),
                                          .nRESET(nRESET),
                                          .address(address),
                                          .Flash_0(Flash_0),
                                          .Flash_1(Flash_1),
                                          .chip_select(chip_select)
                                         );
                                         
    // Instantiation of the SRAM_Chip_Enable module
    SRAM_Chip_Enable #(.N(N*4)) SRAM_CE (.clk(clk),
                                         .nRESET(nRESET),
                                         .address(address),
                                         .CE(CE)
                                         );
    
endmodule
