`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: San Diego State University
// Engineer: Abdul Karim Tamim
//////////////////////////////////////////////////////////////////////////////////


module Low_Pass_Filter(input clk,                           
                       input reset,                           
                       input [31:0] noisy_data,             // 32-bit noisy input data
                       output reg [31:0] filtered_data      // 32-bit filtered output data
                       );

    parameter N = 16;       // Moving average window size (16 samples)
    
    // Register to store the last N samples (32-bit data)
    reg [31:0] data_window [0:N-1];         // Array to hold samples
    
    // Sum of the last N samples for averaging (48-bit to avoid overflow)
    reg [47:0] sum;  // 48-bit sum to handle the large 32-bit values
    
    // Counter to track how many samples we've seen
    reg [4:0] count;  // 5-bit counter to track up to N (16 in this case)

    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the sum, counter, and the data window
            sum <= 0;
            count <= 0;
            for (i = 0; i < N; i = i + 1) begin
                data_window[i] <= 32'd0;
            end
            filtered_data <= 32'd0;
        end else begin
            // Shift the data window by one and insert the new sample at the beginning
            sum <= sum - data_window[count] + noisy_data;  // Update sum (subtract old, add new)
            data_window[count] <= noisy_data;  // Store the new data sample

            // Increment counter and wrap around if we exceed N samples
            if (count < N-1) begin
                count <= count + 1;
            end else begin
                count <= 0;
            end

            // Compute the filtered output (moving average)
            if (count == N-1) begin
                filtered_data <= sum / N;  // Calculate average after N samples
            end
        end
    end

endmodule
