`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module low_pass_filter_tb;

    reg clk;
    reg rst;
    reg [31:0] noisy_data;        // 32-bit noisy data input to the filter
    wire [31:0] filtered_data;    // 32-bit filtered output data
    reg [31:0] memory [0:171];   // Memory array to store 1080 data points (32-bit)
    integer i;
    integer mem_index;           // Index to read data from the memory array
    
    parameter ClockPeriod = 10;     // ClockPeriod is 10 ns
    
    // Clock generation
    initial clk = 0;            // Initialize clock signal to active low (0) at the start of simulation
    always #(ClockPeriod / 2) clk = ~clk;       // Continuously toggle the clock every (10 / 2 = 5 ns) to create a waveform

    // Instantiate the low_pass_filter
    low_pass_filter uut (
        .clk(clk),
        .rst(rst),
        .noisy_data(noisy_data),
        .filtered_data(filtered_data)
    );

    // Clock generation (50 MHz clock)
    always begin
        #10 clk = ~clk;  // Toggle every 10ns, creating a 50 MHz clock
    end

    // Stimulus process
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        noisy_data = 32'd0;
        mem_index = 0;  // Start at the beginning of the memory array

        // Apply reset
        rst = 1;
        #20;  // Wait for a few clock cycles
        rst = 0;

        // Read the noisy data from the .mem file into the memory array
        $readmemh("noisy_data.mem", memory);  // Read the data from the .mem file

        // Apply the noisy data to the filter
        for (i = 0; i < 171; i = i + 1) begin
            #20 noisy_data = memory[mem_index];  // Feed the noisy data into the filter
            mem_index = mem_index + 1;  // Move to the next data point
        end

        // End simulation after all data has been fed into the filter
        #10000;
        $finish;
    end

    // Monitor output data
    initial begin
        $monitor("At time %t, noisy_data = %h, filtered_data = %h", $time, noisy_data, filtered_data);
    end

endmodule
