`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module ProgramAddressMap #(parameter N = 32)                    // 32 bit address
                          (input clk,
                           input nRESET,                        // Active Low reset
                           input [N-1:0] address,               // 32 bit input addrerss
                           output reg CS0,                      // 1 bit output first Flash Chip Select
                           output reg CS1,                      // 1 bit output second Flash Chip Select
                           output reg WP                        // 1 bit output Write Protect
                           );
                           
    wire [19:0] upper_bits;
    
    assign upper_bits = address[31:12];
    
    always @(posedge clk or negedge nRESET) begin
        if (!nRESET) begin
            // Inactive when outside Flash address range
            CS0 <= 1;
            CS1 <= 1;
            WP <= 1;
        end
        else begin
            case (upper_bits)
                20'b0000_0000_0000_0000_0000: begin
                    CS0 <= 0;             // Active low first Flash chip select
                    CS1 <= 1;
                    WP <= 0;              // Active low Write Protect
                end
                
                20'b0000_1000_0000_0000_0000: begin
                    CS0 <= 1;
                    CS1 <= 0;             // Active low second Flash chip select
                    WP <= 0;              // Active low Write Protect
                end
                
                20'b0010_0000_0000_0000_0000: begin
                    // Inactive when outside Flash address range
                    CS0 <= 1;
                    CS1 <= 1;
                    WP <= 1;
                end
            endcase
        end
    end
    
endmodule
