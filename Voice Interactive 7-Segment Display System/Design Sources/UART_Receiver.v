`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module UART_Receiver (input clk,           // Generated baud clock from UART_Baud_Rate_Gen module
                      input rx,                 // Serial data input bit (1-bit)
                      output reg [7:0] data,    // 8-bit data to transmit
                      output reg rx_busy        // Signal to indicate whether transmission is -> busy <- or not (tx_busy = 1: transmitter is busy and currently involved in transmitting data | tx_done = 0: transmitter is not busy or has completed its transmission)
                      );
    
    // State Machine States
    localparam [1:0] IDLE = 2'b00,
                     START = 2'b01,
                     DATA = 2'b10,
                     END = 2'b11;
    
    
    localparam clk_per_bit = 2;
                     
    reg [1:0] state = IDLE;        // Current_state of the machine and next_state of the machine
    reg [2:0] bit_index = 0;       // The index of the bit to be transmitted. Since we are 8-bis of data, this bit_index is capable of transmitting all 8 since it is 3-bits, which can range from 0 to 7
    reg [7:0] rx_data;             // Data to be transmitted
    reg [15:0] clk_counter = 0;
    
    initial begin
        rx_data <= 8'b0;
    end
    
    always @(posedge clk) begin        
        case (state)
            IDLE: begin
                rx_busy <= 0;
                clk_counter <= 0;
                
                if (rx == 1'b0) begin
                    state <= START;
                end
            end
            
            START: begin
                if (clk_counter == (clk_per_bit - 1) / 2) begin
                    if (rx == 1'b0) begin
                        state <= DATA;
                        rx_busy <= 1;
                        clk_counter <= 0;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                else begin
                    clk_counter <= clk_counter + 1;
                end
            end
            
            DATA: begin
                rx_data[bit_index] <= rx;
                if (bit_index < 7) begin
                    bit_index <= bit_index + 1;
                end
                else begin
                    state <= END;
                    clk_counter <= 0;
                    bit_index <= 0;
                end
            end
            
            END: begin
                if (rx == 1'b1) begin
                    data <= rx_data;
                    state <= IDLE;
                    rx_busy <= 0;
                end
                else begin
                    state <= IDLE;
                end
            end
            
            // Default state
            default: state <= IDLE;
            
        endcase
    end
        
endmodule
