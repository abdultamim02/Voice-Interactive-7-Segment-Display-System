`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module DataMemoryAddress #(parameter N = 32)            // 32 bit address
                          (input clk,
                           input nRESET,                            // Active Low reset
                           input [N-1:0] address,                   // 32 bit input addrerss
                           output reg [N/2-1:0] SRAM_0,             // 16 bit output first SRAM
                           output reg [N/2-1:0] SRAM_1,             // 16 bit output second SRAM
                           output reg [N/2-1:0] UART1,              // 16 bit output Output Port
                           output reg [N/2-1:0] Control_Module,     // 16 bit output Input Port
                           output reg [2:0] active_select           // 2 bit output active select (indicating which memory I/O was chosen)
                           );
                           
    /*
    NOTE:
    The address bits 31-24 ([31:24] address) can
    also be used in if states and will result in the
    same outputs
    */
    
    always @(posedge clk or negedge nRESET) begin
        if (!nRESET) begin
            SRAM_0 <= 0;
            SRAM_1 <= 0;
            UART1 <= 0;
            Control_Module <= 0;
        end
        else begin
            if (address >= 32'h1000_0000 && address <= 32'h13FF_FFFF) begin
                SRAM_0 <= 16'b1111_1111_1111_1110;
                active_select <= 2'b00;
            end
            else if (address >= 32'h1400_0000 && address <= 32'h17FF_FFFF) begin
                SRAM_1 <= 16'b1111_1111_1111_1101;
                active_select <= 2'b01;
            end
            else if (address >= 32'h4802_2000 && address <= 32'h4802_2FFF) begin
                UART1 <= 16'b1111_1111_1111_1011;
                active_select <= 2'b10;
            end
            else if (address >= 32'h44E1_0000 && address <= 32'h44E1_1FFF) begin
                Control_Module <= 16'b1111_1111_1111_0111;
                active_select <= 2'b11;
            end
            else begin
                SRAM_0 <= 0;
                SRAM_1 <= 0;
                UART1 <= 0;
                Control_Module <= 0;
                active_select <= 1'bx;
            end
        end
    end
    
endmodule
