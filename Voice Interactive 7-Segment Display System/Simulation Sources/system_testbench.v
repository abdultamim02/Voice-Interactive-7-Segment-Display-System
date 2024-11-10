`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module system_testbench;

    // Parameters
    parameter N = 4;

    reg clk;
    reg reset;
    reg nRESET;                         // Active Low reset
    wire signed [7:0] out;              // Sine wave output from the ---> read_memory.v module <---
    wire [N-1:0] lfsr_4bit;             // 4 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*2-1:0] lfsr_8bit;           // 8 bit output from ---> RandomNoiseLFSR.v module <---
    wire [N*8-1:0] lfsr_32bit;          // 32 bit output from ---> RandomNoiseLFSR.v module <---
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
    wire CS0;                           // 1 bit output first Flash CS0 for ---> ProgramAddressMap module <---
    wire CS1;                           // 1 bit output second Flash CS1 for ---> ProgramAddressMap module <---
    wire WP;                            // 1 bit output Write Protect for ---> ProgramAddressMap module <---
    reg rx;                             // Serial data input bit (1-bit) for ---> UART_Receiver module <---
    wire rx_busy;                       // Signal to indicate whether transmission is -> busy <- or not (tx_busy = 1: transmitter is busy and currently involved in transmitting data | tx_done = 0: transmitter is not busy or has completed its transmission) for ---> UART_Receiver module <---
    wire [7:0] data;                    // 8-bit data to transmit for ---> UART_Receiver module <---
    wire [13:0] Seven_Segment_Display;  // 14 bit output testing for seven segment display for ---> DigitTo7SegmentDisplay.v module <---
    reg [31:0] noisy_data;              // 32-bit noisy input data for  ---> Low_Pass_Filter module <---
    wire [31:0] filtered_data;          // 32-bit filtered output data for ---> Low_Pass_Filter module <---

    reg [31:0] memory [0:125];      // Memory array to store 125 data points (32-bit)

    parameter ClockPeriod = 10;     // ClockPeriod is 10 ns
    
    // Clock generation
    initial clk = 0;            // Initialize clock signal to active low (0) at the start of simulation
    always #(ClockPeriod / 2) clk = ~clk;       // Continuously toggle the clock every (10 / 2 = 5 ns) to create a waveform
    
    // Instantiate the design under test (DUT)
    Top #(.N(N)) top
         (.clk(clk),
          .reset(reset),
          .nRESET(nRESET),
          .out(out),
          .lfsr_4bit(lfsr_4bit),
          .lfsr_8bit(lfsr_8bit),
          .lfsr_32bit(lfsr_32bit),
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
          .WE1(WE1),
          .CS0(CS0),
          .CS1(CS1),
          .WP(WP),
          .rx(rx),
          .rx_busy(rx_busy),
          .data(data),
          .Seven_Segment_Display(Seven_Segment_Display),
          .noisy_data(noisy_data),
          .filtered_data(filtered_data)
          );

    integer i;
    integer mem_index;              // Index to read data from the memory array

    // Task to send an ID (in reverse) with start and stop bits
    task send_ID(input [7:0] ID);
        begin
            rx <= 0;                                // Start bit (LOW)
            @(posedge clk);                    // First Check (IDLE state)
            @(posedge clk);                    // Second Check (START state)
        
            // Send each bit of the ID in reverse order
            for (i = 7; i >= 0; i = i - 1) begin
                rx <= ID[i];
                @(posedge clk);
            end
            
            rx <= 1;  @(posedge clk);          // Stop bit (HIGH)
        
            rx <= 1; @(posedge clk);           // Default IDLE state (HIGH)
        end
    endtask


    initial begin
        // Initialize reset
        reset = 1;      // Start with reset enabled
        nRESET = 0;     // Start with nREST disabled
        
        read = 0;
        write = 0;
        
        noisy_data = 32'd0;
        mem_index = 0;      // Start at the beginning of the memory array

        // Wait for a few cycles and then release reset
        #5;
        reset = 0;      // Deactivte reset
        nRESET = 1;     // Activte nREST
        
        // Sending multiple ID numbers using the task to UART_Receiver module
        rx <= 1; @(posedge clk);           // Default IDLE state (HIGH)
        
        send_ID(8'd0);          // Start with ID = 0 (IDEL state)
        send_ID(8'd5);          // Change ID to 5 (move to START state)
        send_ID(8'd13);         // Record number
        send_ID(8'd35);         // Record number
        send_ID(8'd44);         // Record number
        send_ID(8'd46);         // 46 Indicates no more numbers (move to DONE state)
        send_ID(8'd47);         // 47 indicates there is another number to display (go back to START state)
        send_ID(8'd30);         // Record number
        send_ID(8'd38);         // Record number
        send_ID(8'd46);         // 46 Indicates no more numbers (move to DONE state)
        send_ID(8'd0);          // 0 Indicates no more numbers (back to IDEL state)
        
        // ProgramAddressMap module Testing
        #100;
        address = 32'h0000_0BCD;      // An address between 0x0000_0000 to 0x07FF_FFFF (Flash 0)
        
        #100;
        address = 32'h0800_0CBA;      // An address between 0x0800_0000 to 0x0FFF_FFFF (Flash 1)
        
        #100;
        address = 32'h2000_0DEF;      // An address between 0x2000_0000 - 0x4AFF_FFFF (Not Used)
        
        // DataMemoryAddress module Testing
        #90;
        address = 32'h1000_08AD;      // An address between 0x1000_0000 to 0x13FF_FFFF (SRAM 0)
        
        #10;
        read = 1;
        
        #10;
        read = 0;
        write = 1;
        
        #10;
        write = 0;
        
        #90;
        address = 32'h1400_0F32;      // An address between 0x1400_0000 to 0x17FF_FFFF (SRAM 1)
        
        #10;
        read = 1;
        
        #10;
        read = 0;
        write = 1;
        
        #10;
        write = 0;
        
        #100;
        address = 32'h2000_0FFA;      // An address between 0x2000_0000 to 0x44E0_FFFF (Not Used)
        
        #100;
        address = 32'h44E1_0ABC;      // An address between 0x44E1_0000 to 0x44E1_1FFF (Control Module)
        
        #100;
        address = 32'h44E1_28AD;      // An address between 0x44E1_2000 to 0x4802_1FFF (Not Used)
        
        #100;
        address = 32'h4802_2C58;      // An address between 0x4802_2000 to 0x4802_2FFF (UART1)
        
        #100;
        address = 32'h4802_3BBB;      // An address between 0x4802_3000 to 0x4AFF_FFFF (Not Used)
        
        // Read the noisy data from the .mem file into the memory array
        $readmemh("NoisyWave.mem", memory);  // Read the data from the .mem file
        
        // Apply the noisy data to the filter
        for (i = 0; i < 125; i = i + 1) begin
            #20 noisy_data = memory[mem_index];     // Feed the noisy data into the filter
            mem_index = mem_index + 1;      // Move to the next data point
        end
        
        // Simulate for 200ns
        #200;
        $finish;
    end
    
endmodule
