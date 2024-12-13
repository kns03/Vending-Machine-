`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:30:13 12/13/2024
// Design Name:   Vending
// Module Name:   vending_tb.v
// Project Name:  Vending_machine
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Vending
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

// Testbench for Vending Machine FSM

module vending_tb;

// Testbench signals
reg clk, rst, c5, c10;
wire p_out, c_out;

// Instantiate the vending machine module
Vending uut (
    .p_out(p_out),
    .c_out(c_out),
    .clk(clk),
    .rst(rst),
    .c5(c5),
    .c10(c10)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock cycle
end

// Test sequence
initial begin
    // Initialize inputs
    rst = 1; c5 = 0; c10 = 0;
    #10;
    
    // Release reset
    rst = 0;
    
    // Test 1: Insert 5 units
    c5 = 1; c10 = 0;
    #10; c5 = 0; // Insert completed

    // Test 2: Insert another 5 units
    c5 = 1; c10 = 0;
    #10; c5 = 0; // Insert completed
    
    // Test 3: Reset and insert 10 units directly
    rst = 1; #10; rst = 0;
    c5 = 0; c10 = 1;
    #10; c10 = 0; // Insert completed

    // Test 4: Insert 10 units followed by 5 units
    c10 = 1; #10; c10 = 0; // Insert 10 units
    c5 = 1; #10; c5 = 0;  // Insert 5 units

    // Test 5: Insert 10 units twice (overpayment)
    c10 = 1; #10; c10 = 0;
    c10 = 1; #10; c10 = 0;

    // End simulation
    #20;
    $stop;
end

endmodule

