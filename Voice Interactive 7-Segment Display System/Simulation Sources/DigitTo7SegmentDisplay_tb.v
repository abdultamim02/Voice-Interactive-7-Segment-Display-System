`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module DigitTo7SegmentDisplay_tb;

    reg clk;                // System Clock
    reg rx;            // Serial data input bit (1-bit)
    wire [7:0] data;         // 8-bit data to transmit
    wire rx_busy;        // Signal to indicate whether transmission is -> busy <- or not (tx_busy = 1: transmitter is busy and currently involved in transmitting data | tx_done = 0: transmitter is not busy or has completed its transmission)
    reg reset;
    wire [13:0] Seven_Segment_Display;  // 14 bit output testing for seven segment display for ---> DigitTo7SegmentDisplay.v module <---
    
    UART_Receiver 
          Receiver 
          (
          .baud_clk(clk),
          .rx(rx),
          .data(data),
          .rx_busy(rx_busy)
          );
          
    wire [7:0] ID = {data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7]};
          
    // Instantiation of the DigitTo7SegmentDisplay module
    DigitTo7SegmentDisplay display (.clk(clk), 
                                    .reset(reset), 
                                    .ID(ID[5:0]),
                                    .Seven_Segment_Display(Seven_Segment_Display)
                                    );

    parameter CLK_PERIOD = 10; // 100 MHz clock
    
    // Clock Generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Toggle clock
    end
    
    integer i;
    
    // Task to send an ID (in reverse) with start and stop bits
    task send_ID(input [7:0] ID);
        begin
            rx <= 0;                                // Start bit (LOW)
            @(posedge clk);                    // First Check (IDLE state)
            @(posedge clk);                    // Second Check (START state)
        
            // Send each bit of the ID in reverse order
            for (i = 7; i >= 0; i = i - 1) begin
                rx <= ID[i];
                @(posedge clk);
            end
            
            rx <= 1;  @(posedge clk);          // Stop bit (HIGH)
        
            rx <= 1; @(posedge clk);           // Default IDLE state (HIGH)
        end
    endtask

    initial begin
        clk <= 0;
        rx <= 1; @(posedge clk);           // Default IDLE state (HIGH)
        
        // Initialize reset
        reset = 1;      // Start with reset enabled
        
        // Wait for a few cycles and then release reset
        #5;
        reset = 0;      // Deactivte reset
                
        // Sending multiple ID numbers using the task
        send_ID(8'd0);   // Start with ID = 0 (IDEL state)
        send_ID(8'd5);   // Change ID to 5 (move to START state)
        send_ID(8'd13);  // Record number
        send_ID(8'd35);  // Record number
        send_ID(8'd44);  // Record number
        send_ID(8'd46);  // 46 Indicates no more numbers (move to DONE state)
        send_ID(8'd47);  // 47 indicates there is another number to display (go back to START state)
        send_ID(8'd30);  // Record number
        send_ID(8'd38);  // Record number
        send_ID(8'd46);  // 46 Indicates no more numbers (move to DONE state)
        send_ID(8'd0);   // 0 Indicates no more numbers (back to IDEL state)
       
        // Simulate for 50ns
        #500;
    end          

endmodule
