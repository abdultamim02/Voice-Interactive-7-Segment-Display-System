`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module DataMemoryAddress_tb;

    // Parameters
    parameter N = 4;

    reg clk;
    reg nRESET;                         // Active Low reset
    reg [N*8-1:0] address;              // 32 bit input addrerss for ---> ProgramAddressMap and DataMemoryAddress modules <--- 
    reg read;                           // 1 bit input read signal for ---> DataMemoryAddress module <---
    reg write;                          // 1 bit input write signal for ---> DataMemoryAddress module <---
    wire Control_Module;                // 1 bit output Input Port for ---> DataMemoryAddress module <---
    wire UART1;                         // 1 bit output Output Port for ---> DataMemoryAddress module <---
    wire CE0;                           // 1 bit output first SRAM Chip Enable for ---> DataMemoryAddress module <---
    wire CE1;                           // 1 bit output second SRAM Chip Enable for ---> DataMemoryAddress module <---
    wire OE0;                           // 1 bit output first SRAM Output Enable for ---> DataMemoryAddress module <---
    wire OE1;                           // 1 bit output second SRAM Output Enable for ---> DataMemoryAddress module <---
    wire WE0;                           // 1 bit output first SRAM Write Enable for ---> DataMemoryAddress module <---
    wire WE1;                           // 1 bit output second SRAM Write Enable for ---> DataMemoryAddress module <---
    
    parameter ClockPeriod = 10;     // ClockPeriod is 10 ns
    
    // Clock generation
    initial clk = 0;            // Initialize clock signal to active low (0) at the start of simulation
    always #(ClockPeriod / 2) clk = ~clk;       // Continuously toggle the clock every (10 / 2 = 5 ns) to create a waveform
    
    // Instantiation of the DataMemoryAddress module
    DataMemoryAddress #(.N(N*8)) progAdd (.clk(clk),
                                          .nRESET(nRESET),
                                          .address(address),
                                          .read(read),
                                          .write(write),
                                          .Control_Module(Control_Module),
                                          .UART1(UART1),
                                          .CE0(CE0),
                                          .CE1(CE1),
                                          .OE0(OE0),
                                          .OE1(OE1),
                                          .WE0(WE0),
                                          .WE1(WE1)
                                         );

    initial begin
        // Initialize reset
        nRESET = 0;     // Start with nREST disabled

        read = 0;
        write = 0;
        
        // Wait for a few cycles and then release reset
        #5;
        nRESET = 1;     // Activte nREST
        
       // DataMemoryAddress module Testing
        #50;
        address = 32'h1000_08AD;      // An address between 0x1000_0000 to 0x13FF_FFFF (SRAM 0)
        
        #10;
        read = 1;
        
        #10;
        read = 0;
        write = 1;
        
        #10;
        write = 0;
        
        #50;
        address = 32'h1400_0F32;      // An address between 0x1400_0000 to 0x17FF_FFFF (SRAM 1)
        
        #10;
        read = 1;
        
        #10;
        read = 0;
        write = 1;
        
        #10;
        write = 0;
        
        #50;
        address = 32'h2000_0FFA;      // An address between 0x2000_0000 to 0x44E0_FFFF (Not Used)
        
        #50;
        address = 32'h44E1_0ABC;      // An address between 0x44E1_0000 to 0x44E1_1FFF (Control Module)
        
        #50;
        address = 32'h44E1_28AD;      // An address between 0x44E1_2000 to 0x4802_1FFF (Not Used)
        
        #50;
        address = 32'h4802_2C58;      // An address between 0x4802_2000 to 0x4802_2FFF (UART1)
        
        #50;
        address = 32'h4802_3BBB;      // An address between 0x4802_3000 to 0x4AFF_FFFF (Not Used)
        
        // Simulate for 50ns
        #50;
        $finish;
    end
    
endmodule

