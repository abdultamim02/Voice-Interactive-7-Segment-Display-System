# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]       
    set_property IOSTANDARD LVCMOS33 [get_ports clk]
    	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# Buttons
set_property PACKAGE_PIN U18 [get_ports reset]     
    set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN T18 [get_ports nRESET]     
    set_property IOSTANDARD LVCMOS33 [get_ports nRESET]

# LEDs
set_property PACKAGE_PIN L1 [get_ports {read}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {read}]
set_property PACKAGE_PIN P1 [get_ports {write}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {write}]
set_property PACKAGE_PIN N3 [get_ports {rx_busy}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rx_busy}]

# Switches
set_property PACKAGE_PIN R2 [get_ports {read}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {read}]
set_property PACKAGE_PIN T1 [get_ports {write}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {write}]

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports rx]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx]

##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {address}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address}]
	
##Pmod Header JB
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {Control_Module}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Control_Module}]
##Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {UART1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {UART1}]
##Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {CE0}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {CE0}]
##Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {CE1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {CE1}]
##Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {OE0}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OE0}]
##Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {OE1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {OE1}]
##Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {WE0}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {WE0}]
##Sch name = JB10 
set_property PACKAGE_PIN C16 [get_ports {WE1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {WE1}]

##Pmod Header JC
##Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {CS0}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {CS0}]
##Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {CS1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {CS1}]
##Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports {WP}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {WP}]
##Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports {data}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data}]
##Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {filtered_data}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {filtered_data}]
##Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {lfsr_4bit}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lfsr_4bit}]
##Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports {lfsr_8bit}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lfsr_8bit}]
##Sch name = JC10
set_property PACKAGE_PIN R18 [get_ports {lfsr_32bit}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lfsr_32bit}]
	
#Pmod Header JXADC
#Sch name = XA4_P
set_property PACKAGE_PIN N2 [get_ports {Seven_Segment_Display}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Seven_Segment_Display}]
