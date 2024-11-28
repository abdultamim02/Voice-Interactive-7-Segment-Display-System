`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module Top #(parameter N = 4)   // Default width = 4
            (input clk,                                     // System Clock
             input cpu_clk,                                 // CPU Clock
             input reset,                                   // Avtive High reset
             input nRESET,                                  // Active Low reset
             output wire signed [7:0] out,                  // Declare output as signed for ---> read_memory.v module <---
             output wire [N-1:0] lfsr_4bit,                 // Declare lfsr_4bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*2-1:0] lfsr_8bit,               // Declare lfsr_8bit for ---> RandomNoiseLFSR.v module <---
             output wire [N*8-1:0] lfsr_32bit,              // Declare lfsr_32bit for ---> RandomNoiseLFSR.v module <---
             input [N*8-1:0] address,                       // 32 bit input addrerss for ---> ProgramAddressMap and DataMemoryAddress modules <--- 
             input read,                                    // 1 bit input read signal for ---> DataMemoryAddress module <---
             input write,                                   // 1 bit input write signal for ---> DataMemoryAddress module <---
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
             input rx,                                      // Serial data input bit (1-bit) for ---> UART_Receiver module <---
             output wire rx_busy,                           // Signal to indicate whether transmission is -> busy <- or not (tx_busy = 1: transmitter is busy and currently involved in transmitting data | tx_done = 0: transmitter is not busy or has completed its transmission) for ---> UART_Receiver module <---
             output wire [7:0] data,                        // 8-bit data to transmit for ---> UART_Receiver module <---
             output wire [N*3+1:0] Seven_Segment_Display,   // 14 bit output testing for seven segment display for ---> DigitTo7SegmentDisplay.v module <---
             input [31:0] noisy_data,                       // 32-bit noisy input data for  ---> Low_Pass_Filter module <---
             output wire [31:0] filtered_data                // 32-bit filtered output data for ---> Low_Pass_Filter module <---
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
    
    // Instantiation of the UART_Receiver module
    UART_Receiver Receiver (.clk(clk),
                            .rx(rx),
                            .data(data),
                            .rx_busy(rx_busy)
                            );
    
    // Instantiation of the DigitTo7SegmentDisplay module
    wire [7:0] ID = {data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7]};
    
    DigitTo7SegmentDisplay display (.clk(clk), 
                                    .reset(reset), 
                                    .ID(ID[5:0]),
                                    .Seven_Segment_Display(Seven_Segment_Display)
                                    );
    
    // Instantiate the Low_Pass_Filter module
    Low_Pass_Filter filter (.clk(clk),
                            .reset(reset),
                            .noisy_data(noisy_data),
                            .filtered_data(filtered_data)
                            );
    
endmodule
