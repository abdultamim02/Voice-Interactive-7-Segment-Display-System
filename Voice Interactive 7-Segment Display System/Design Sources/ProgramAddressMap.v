`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module ProgramAddressMap #(parameter N = 32)                    // 32 bit address
                          (input clk,
                           input nRESET,                        // Active Low reset
                           input [N-1:0] address,               // 32 bit input addrerss
                           output reg [N/2-1:0] Flash_0,        // 16 bit output first Flash
                           output reg [N/2-1:0] Flash_1,        // 16 bit output second Flash
                           output reg [1:0] chip_select         // 1 bit output chip select (indicating which memory IC was chosen)
                           );
                           
    /*
    NOTE:
    The address bits 31-24 ([31:24] address) can
    also be used in if states and will result in the
    same outputs
    */
    
    always @(posedge clk or negedge nRESET) begin
        if (!nRESET) begin
            Flash_0 <= 0;
            Flash_1 <= 0;
        end
        else begin
            if (address >= 32'h0000_0000 && address <= 32'h07FF_FFFF) begin
                Flash_0 <= 16'b1111_1111_1111_1110;
                chip_select <= 2'b00;
            end
            else if (address >= 32'h0800_0000 && address <= 32'h0FFF_FFFF) begin
                Flash_1 <= 16'b1111_1111_1111_1101;
                chip_select <= 2'b01;
            end
            else begin
                Flash_0 <= 0;
                Flash_1 <= 0;
                chip_select <= 1'bx;
            end
        end
    end
    
endmodule
