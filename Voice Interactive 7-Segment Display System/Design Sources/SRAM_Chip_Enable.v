`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module SRAM_Chip_Enable #(parameter N = 16)        // 16 bit address
                         (input clk,
                          input nRESET,               // Active Low reset
                          input [N-1:0] address,      // 16 bit input addrerss
                          output reg CE               // 1 bit output Chip Enable
                          );
    
    always @(posedge clk or negedge nRESET) begin
        if (!nRESET) begin
            CE <= 1;          // Inactive when outside SRAM range
        end
        else begin
            if (address >= 16'h0000 && address <= 16'h3FFF) begin
                CE <= 0;          // Active low chip enable
            end
            else begin
                CE <= 1;          // Inactive when outside SRAM range
            end
        end
    end    
    
endmodule
