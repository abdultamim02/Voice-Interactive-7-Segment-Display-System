`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module Flash_SRAM_Control_Signals #(parameter N = 32)        // 32 bit address
                                   (input clk,
                                    input nRESET,               // Active Low reset
                                    input [N-1:0] address,      // 32 bit input addrerss
                                    output reg CE,              // 1 bit output Chip Enable
                                    output reg OE,              // 1 bit output Output Enable
                                    output reg WE,              // 1 bit output Write Enable
                                    output reg WP               // 1 bit output Write Protect
                                    );
    
    always @(posedge clk or negedge nRESET) begin
        if (!nRESET) begin
            // Inactive when outside SRAM and/or Flash address range
            CE <= 1;
            OE <= 1;
            WE <= 1;
            WP <= 1;
        end
        else begin
            // If address is in the -> Flash <- address range
            if (address >= 32'h0000_0000 && address <= 32'h0FFF_FFFF) begin
                CE <= 0;          // Active low chip enable
                OE <= 0;          // Active low Output enable
                WE <= 0;          // Active low Write enable
                WP <= 0;          // Active low Write Protect (ONLY FOR FLASH MEMORY)
            end
            // If address is in the -> SRAM <- address range
            else if (address >= 32'h1000_0000 && address <= 32'h44E1_1FFF) begin
                CE <= 0;          // Active low chip enable
                OE <= 0;          // Active low Output enable
                WE <= 0;          // Active low Write enable
            end
            else begin
                // Otherwise keep inactive when outside SRAM and/or Flash address range
                CE <= 1;
                OE <= 1;
                WE <= 1;
                WP <= 1;
            end
        end
    end    
    
endmodule
