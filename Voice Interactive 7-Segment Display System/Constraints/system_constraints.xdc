# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]       
    set_property IOSTANDARD LVCMOS33 [get_ports clk]
    	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

set_property PACKAGE_PIN T17 [get_ports nRESET]     
    set_property IOSTANDARD LVCMOS33 [get_ports nRESET]
    
##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN C17 [get_ports {address[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[0]}]
set_property PACKAGE_PIN C18 [get_ports {address[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[1]}]
set_property PACKAGE_PIN C19 [get_ports {address[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[2]}]
set_property PACKAGE_PIN D1 [get_ports {address[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[3]}]
set_property PACKAGE_PIN D2 [get_ports {address[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[4]}]
set_property PACKAGE_PIN D3 [get_ports {address[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[5]}]
set_property PACKAGE_PIN D17 [get_ports {address[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[6]}]
set_property PACKAGE_PIN D18 [get_ports {address[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[7]}]
set_property PACKAGE_PIN D19 [get_ports {address[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[8]}]
set_property PACKAGE_PIN E1 [get_ports {address[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[9]}]
set_property PACKAGE_PIN E2 [get_ports {address[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[10]}]
set_property PACKAGE_PIN E3 [get_ports {address[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[11]}]
set_property PACKAGE_PIN E17 [get_ports {address[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[12]}]
set_property PACKAGE_PIN E18 [get_ports {address[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[13]}]
set_property PACKAGE_PIN E19 [get_ports {address[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[14]}]
set_property PACKAGE_PIN F1 [get_ports {address[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[15]}]
set_property PACKAGE_PIN F2 [get_ports {address[16]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[16]}]
set_property PACKAGE_PIN F3 [get_ports {address[17]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[17]}]
set_property PACKAGE_PIN F17 [get_ports {address[18]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[18]}]
set_property PACKAGE_PIN F18 [get_ports {address[19]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[19]}]
set_property PACKAGE_PIN F19 [get_ports {address[20]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[20]}]
set_property PACKAGE_PIN G1 [get_ports {address[21]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[21]}]
set_property PACKAGE_PIN G2 [get_ports {address[22]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[22]}]
set_property PACKAGE_PIN G3 [get_ports {address[23]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[23]}]
set_property PACKAGE_PIN G7 [get_ports {address[24]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[24]}]
set_property PACKAGE_PIN G8 [get_ports {address[25]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[25]}]
set_property PACKAGE_PIN G9 [get_ports {address[26]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[26]}]
set_property PACKAGE_PIN G10 [get_ports {address[27]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[27]}]
set_property PACKAGE_PIN G11 [get_ports {address[28]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[28]}]
set_property PACKAGE_PIN G12 [get_ports {address[29]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[29]}]
set_property PACKAGE_PIN G13 [get_ports {address[30]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[30]}]
set_property PACKAGE_PIN G14 [get_ports {address[31]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[31]}]
set_property PACKAGE_PIN G15 [get_ports {address[32]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {address[32]}]
   
# Switches
set_property PACKAGE_PIN R2 [get_ports {read}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {read}]
set_property PACKAGE_PIN T1 [get_ports {write}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {write}]
	
##Pmod Header JB
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
