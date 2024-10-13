`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module ProgramAddressMap #(parameter N = 16)        // 16 bit address
                          (input clk,
                           input nRESET,                        // Active Low reset
                           input [N-1:0] address,               // 16 bit input addrerss
                           output reg [N/2-1:0] SRAM_0,         // 8 bit output first SRAM
                           output reg [N/2-1:0] SRAM_1,         // 8 bit output second SRAM
                           output reg [N/2-1:0] Output_Port,    // 8 bit output Output Port
                           output reg [N/2-1:0] Input_Port,     // 8 bit output Input Port
                           output reg [2:0] active_select       // 2 bit output active select (indicating which memory I/O was chosen)
                           );
                           
    /*
    NOTE:
    The address bits 15, 14, 13 ([15:13] address) can
    also be used in if states and will result in the
    same outputs
    */
    
    always @(posedge clk or negedge nRESET) begin
        if (!nRESET) begin
            SRAM_0 <= 0;
            SRAM_1 <= 0;
            Output_Port <= 0;
            Input_Port <= 0;
        end
        else begin
            if (address >= 16'h0000 && address <= 16'h1FFF) begin
                SRAM_0 <= 8'b11111110;
                active_select <= 2'b00;
            end
            else if (address >= 16'h2000 && address <= 16'h3FFF) begin
                SRAM_1 <= 8'b11111101;
                active_select <= 2'b01;
            end
            else if (address >= 16'h4000 && address <= 16'h5FFF) begin
                Output_Port <= 8'b11111011;
                active_select <= 2'b10;
            end
            else if (address >= 16'h6000 && address <= 16'h7FFF) begin
                Input_Port <= 8'b11110111;
                active_select <= 2'b11;
            end
            else begin
                SRAM_0 <= 0;
                SRAM_1 <= 0;
                Output_Port <= 0;
                Input_Port <= 0;
                active_select <= 1'bx;
            end
        end
    end
    
endmodule
