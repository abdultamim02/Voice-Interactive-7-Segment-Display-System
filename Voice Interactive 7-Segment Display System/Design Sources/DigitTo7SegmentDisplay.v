`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module DigitTo7SegmentDisplay (input clk,
                               input reset,
                               input [5:0] ID,
                               output reg [13:0] Seven_Segment_Display
                               );
    
    // State Machine States
    localparam [1:0] IDLE = 2'b00,
                     START = 2'b01,
                     LOGIC = 2'b10,
                     DONE = 2'b11;
    
    reg [1:0] state = IDLE;        // Current state of the machine
    
    reg [3:0] ones;               // 4-bit wide
    reg [6:0] tens;               // 7-bit wide
    reg [9:0] hundreds;           // 10-bit wide
    reg [13:0] thousands;         // 14-bit wide
    
    // Number Groups
    reg [3:0] Ones [1:9];               // 10 entries, each 4-bit wide
    reg [6:0] Tens [10:27];             // 10 entries, each 7-bit wide
    reg [9:0] Hundreds [28:36];         // 10 entries, each 10-bit wide
    reg [13:0] Thousands [38:45];       // 10 entries, each 14-bit wide
    reg DoSt [46:47];                   // done = 46, Start = 47
    
    initial begin
        Ones[1] = 1;
        Ones[2] = 2;
        Ones[3] = 3;
        Ones[4] = 4;
        Ones[5] = 5;
        Ones[6] = 6;
        Ones[7] = 7;
        Ones[8] = 8;
        Ones[9] = 9;
        Tens[10] = 10;
        Tens[11] = 11;
        Tens[12] = 12;
        Tens[13] = 13;
        Tens[14] = 14;
        Tens[15] = 15;
        Tens[16] = 16;
        Tens[17] = 17;
        Tens[18] = 18;
        Tens[19] = 19;
        Tens[20] = 20;
        Tens[21] = 30;
        Tens[22] = 40;
        Tens[23] = 50;
        Tens[24] = 60;
        Tens[25] = 70;
        Tens[26] = 80;
        Tens[27] = 90;
        Hundreds[28] = 100;
        Hundreds[29] = 200;
        Hundreds[30] = 300;
        Hundreds[31] = 400;
        Hundreds[32] = 500;
        Hundreds[33] = 600;
        Hundreds[34] = 700;
        Hundreds[35] = 800;
        Hundreds[36] = 900;
        Thousands[37] = 1000;
        Thousands[38] = 2000;
        Thousands[39] = 3000;
        Thousands[40] = 4000;
        Thousands[41] = 5000;
        Thousands[42] = 6000;
        Thousands[43] = 7000;
        Thousands[44] = 8000;
        Thousands[45] = 9000;
        DoSt[46] = 0;
        DoSt[47] = 1;
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Seven_Segment_Display <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (ID > 0) begin
                        state <= START;
                    end
                end
                
                START: begin
                    if (ID >= 1 && ID <= 46) begin
                        ones <= 0;
                        tens <= 0;
                        hundreds <= 0;
                        thousands <= 0;
                        state <= LOGIC;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                
                LOGIC: begin
                    if (ID >= 1 && ID <= 9) begin
                        ones <= Ones[ID];
                    end
                    else if (ID >= 10 && ID <= 27) begin
                        tens <= Tens[ID];
                    end
                    else if (ID >= 28 && ID <= 36) begin
                        hundreds <= Hundreds[ID];
                    end
                    else if (ID >= 37 && ID <= 45) begin
                        thousands <= Thousands[ID];
                    end
                    else begin
                        if (ID == 46) begin
                            state <= DONE;
                        end
                        else begin
                            state <= LOGIC;
                        end
                    end
                end
                
                DONE: begin
                    Seven_Segment_Display <= thousands + hundreds + tens + ones;
                                        
                    if (ID == 47) begin
                        state <= START;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
    
endmodule
