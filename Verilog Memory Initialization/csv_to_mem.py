import csv
import math

def csv_to_mem(csv_filename, mem_filename):
    # Open the CSV file for reading
    with open(csv_filename, 'r') as csvfile:
        reader = csv.reader(csvfile)
        
        # Open the .mem file for writing
        with open(mem_filename, 'w') as memfile:
            for row in reader:
                angle = float(row[0])
                sine_value = float(row[1])
                
                # Scale the sine value to fit in an 8-bit signed integer (-128 to 127)
                scaled_value = round(sine_value * 127)
                
                # Convert the scaled value to 8-bit two's complement binary
                if scaled_value < 0:
                    bin_value = format((1 << 8) + scaled_value, '08b')  # Two's complement for negative values
                else:
                    bin_value = format(scaled_value, '08b')
                
                # Write the binary value to the .mem file
                memfile.write(bin_value + '\n')

# Convert your SineWave.csv to SineWave.mem
csv_to_mem('SineWave.csv', 'SineWave.mem')
