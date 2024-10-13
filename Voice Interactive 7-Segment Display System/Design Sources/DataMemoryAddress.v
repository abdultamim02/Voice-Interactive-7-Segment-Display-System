`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module DataMemoryAddress #(parameter N = 16)        // 16 bit address
                          (input clk,
                           input nRESET,                        // Active Low reset
                           input [N-1:0] address,               // 16 bit input addrerss
                           output reg [N/2-1:0] Flash_0,        // 8 bit output first Flash
                           output reg [N/2-1:0] Flash_1,        // 8 bit output second Flash
                           output reg [1:0] chip_select         // 1 bit output chip select (indicating which memory I/O was chosen)
                           );
                           
    /*
    NOTE:
    The address bits 15, 14, 13 ([15:13] address) can
    also be used in if states and will result in the
    same outputs
    */
    
    always @(posedge clk or negedge nRESET) begin
        if (!nRESET) begin
            Flash_0 <= 0;
            Flash_1 <= 0;
        end
        else begin
            if (address >= 16'h0000 && address <= 16'h1FFF) begin
                Flash_0 <= 8'b11111110;
                chip_select <= 2'b00;
            end
            else if (address >= 16'h2000 && address <= 16'h3FFF) begin
                Flash_1 <= 8'b11111101;
                chip_select <= 2'b01;
            end
            else begin
                Flash_0 <= 0;
                Flash_1 <= 0;
                chip_select <= 0;
            end
        end
    end
    
endmodule
