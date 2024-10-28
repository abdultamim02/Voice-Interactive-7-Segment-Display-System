`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////

module DataMemoryAddress #(parameter N = 32)            // 32 bit address
                          (input clk,
                           input nRESET,                    // Active Low reset
                           input [N-1:0] address,           // 32 bit input addrerss
                           input read,                      // 1 bit input read signal
                           input write,                     // 1 bit input write signal
                           output reg Control_Module,       // 1 bit output Input Port
                           output reg UART1,                // 1 bit output Output Port
                           output reg CE0,                  // 1 bit output first SRAM Chip Enable
                           output reg CE1,                  // 1 bit output second SRAM Chip Enable
                           output reg OE0,                  // 1 bit output first SRAM Output Enable
                           output reg OE1,                  // 1 bit output second SRAM Output Enable
                           output reg WE0,                  // 1 bit output first SRAM Write Enable
                           output reg WE1                   // 1 bit output second SRAM Write Enable
                           );
                           
    wire [19:0] upper_bits;
    
    assign upper_bits = address[31:12];
    
    always @(posedge clk or negedge nRESET) begin
        if (!nRESET) begin
            Control_Module <= 1;
            UART1 <= 1;
            CE0 <= 1;
            CE1 <= 1;
            OE0 <= 1;
            OE1 <= 1;
            WE0 <= 1;
            WE1 <= 1;
        end
        else begin
            case (upper_bits)
                20'b0001_0000_0000_0000_0000: begin
                    CE0 <= 0;
                    CE1 <= 1;
                    
                    if (read) begin
                        OE0 <= 0;
                        WE0 <= 1;
                    end
                    else if (write) begin
                        WE0 <= 0;
                        OE0 <= 1;
                    end
                    else begin
                        OE0 <= 1;
                        WE0 <= 1;
                    end
                end
                
                20'b0001_0100_0000_0000_0000: begin
                    CE1 <= 0;
                    CE0 <= 1;
                    
                    if (read) begin
                        OE1 <= 0;
                        WE1 <= 1;
                    end
                    else if (write) begin
                        WE1 <= 0;
                        OE1 <= 1;
                    end
                    else begin
                        OE1 <= 1;
                        WE1 <= 1;
                    end
                end
                
                20'b0010_0000_0000_0000_0000: begin
                    Control_Module <= 1;
                    UART1 <= 1;
                    CE0 <= 1;
                    CE1 <= 1;
                    OE0 <= 1;
                    OE1 <= 1;
                    WE0 <= 1;
                    WE1 <= 1;
                end
                
                20'b0100_0100_1110_0001_0000: begin
                    Control_Module <= 0;
                end
                
                20'b0100_0100_1110_0001_0010: begin
                    Control_Module <= 1;
                    UART1 <= 1;
                    CE0 <= 1;
                    CE1 <= 1;
                    OE0 <= 1;
                    OE1 <= 1;
                    WE0 <= 1;
                    WE1 <= 1;
                end
                
                20'b0100_1000_0000_0010_0010: begin
                    UART1 <= 0;
                end
                
                20'b0100_1000_0000_0010_0011: begin
                    Control_Module <= 1;
                    UART1 <= 1;
                    CE0 <= 1;
                    CE1 <= 1;
                    OE0 <= 1;
                    OE1 <= 1;
                    WE0 <= 1;
                    WE1 <= 1;
                end
            endcase
        end
    end
    
endmodule
