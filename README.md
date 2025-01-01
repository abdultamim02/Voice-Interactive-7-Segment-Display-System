# Voice-Interactive-7-Segment-Display-System
**"Note"**: This Project Is Fully <ins>**Hypothetical**</ins> (No Hardware Implementation Was Performed).

## Project Description

Field-programmable gate arrays (FPGAs) are integrated circuits that can be reconfigured to meet designers’ needs. FPGAs contain an array of programmable logic blocks, and chip adoption is driven by their flexibility, hardware-timed speed and reliability, and parallelism. This project is a voice recognition system that processes spoken numbers between 0 and 9999 and displays the recognized number on a 4-digit 7-segment display. The system will utilize the Basys-3 Artix-7 FPGA to handle signal processing and interface with a voice recognition module. The design will include an external microprocessor and memories of volatile (SRAM) and non-volatile (Flash) components to handle real-time data and store previous inputs.

## Verilog Use

The project will utilize Verilog, a hardware description language, which will be used for designing, and implementing the logical modules for the project. Verilog also allows for simulation, timing, and test analysis verification. While several software applications support Verilog development and implementation, this project will primarily utilize Vivado for Verilog code writing and simulation. Xilinx's Vivado offers a comprehensive integrated development environment (IDE) that is specifically designed for FPGA design and verification. due to its numerous capabilities, which include advanced synthesis and analysis tools, it is an ideal choice for implementing complicated digital systems like the voice recognition project.

## Calculations and Analysis

Calculations of the design verification analysis were calculated and obtained from the components utilized in this project. These analysis include:

* **Noise margin Analysis** -- A measure of design margins to ensure circuits function properly within specified conditions. The noise margin is divided into two-part calculations that require many I/O electrical characteristics values, the first part is the Noise Margin High (NMH), also known as Logic One Case, which is the range of tolerance for which you can still correctly receive a logical high signal. The second part is the Noise Margin Low (NML), also known as the Logic Zero Case, which stipulates the range of tolerance for a logical low signal on the wire.

* **Loading analysis** -- An evaluation of how many circuit elements a given output can drive without degrading the signal. Loading analysis requires many I/O electrical characteristic values, just like the noise margin, that can be used to calculate the total input currents and capacitance, as well as the margin. Mainly for the loading analysis, the processor or CPU derives the other components, such as the external memories and FPGA. Source signals like the data bus signals, address bus signals, and control bus signals are derived from the CPU and sent to the other components.

* **Timing Analysis** -- Utilized to ensure that a circuit meets all timing specifications and will operate correctly at speed. To ensure this the longest propagation delay of the circuit must be tested. The timing analysis is entirely important for the SRAM and Flash memories, as it helps analyze the time it takes to access data, including the delay from when an address is sent to the memory device to when the valid data is available at the output.

## High Level Design Diagram
![High_Level_Design_Diagram](https://github.com/user-attachments/assets/cf3bd3a9-b085-4b73-9558-6431cdab7630)

## System Testbench Simulation Output

![Screenshot 2024-11-09 170249](https://github.com/user-attachments/assets/4a68dc8f-8a37-44fc-91ad-ae5f95b1a952)
