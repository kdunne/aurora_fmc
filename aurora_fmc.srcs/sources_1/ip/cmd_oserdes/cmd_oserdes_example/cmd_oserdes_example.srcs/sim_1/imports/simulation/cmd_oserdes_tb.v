
// file: cmd_oserdes_tb.v
// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

//----------------------------------------------------------------------------
// SelectIO wizard demonstration testbench
//----------------------------------------------------------------------------
// This demonstration testbench instantiates the example design for the 
//   SelectIO wizard. 
//----------------------------------------------------------------------------

`timescale 1ps/1ps

module cmd_oserdes_tb ();
  
  parameter        SYS_W = 1;
  parameter        DEV_W = 1;
  localparam       num_serial_bits = DEV_W/SYS_W;
  wire [1:0]       pattern_completed_out;
  wire [1:0]       pattern_completed_out1;
 
  // From the system into the device
  wire  [SYS_W-1:0] data_in_from_pins;
  wire  [SYS_W-1:0] data_in_from_pins_DEL;
  wire             clk_in_fwd;
  wire		   clk_to_pins_fwd;
  wire [SYS_W-1:0] data_in_from_pins_del;
  wire [SYS_W-1:0] data_in_from_pins_p_del;
  wire [SYS_W-1:0] data_in_from_pins_n_del;

  // From the drive out to the system
  wire [SYS_W-1:0] data_out_to_pins;
  reg              clk_in   = 0;
  reg              clk_reset;
  reg              io_reset;

  reg [16:0]        timeout_counter = 17'b00000000000000000;
  reg [16:0]        bitslip_timeout = 17'b00000000000000000;

  // clock generator- 100 MHz simulation clock
  //------------------------------------------
  localparam       clk_per = 10 * 1000;
  always begin
    clk_in = #(clk_per/2) ~clk_in;
  end

 initial begin 
    $display("Timing checks are not valid\n");
    // reset the logic
    clk_reset   = 1;
    io_reset    = 1;
    
    #(18*clk_per);
    clk_reset   = 0;

    #(120.5*clk_per);
    @(negedge clk_in) io_reset    = 0;
    #(2.5*clk_per);
    $display("Timing checks are valid\n");

  end



   always @(negedge clk_in) 
   begin
      if (io_reset == 1'b0) begin
       timeout_counter <= timeout_counter + 1'b1;
         if ((timeout_counter == 17'b11111111111110000) && (pattern_completed_out == 2'b00)) begin
           $timeformat(-9, 2, "ns", 10);
           $display("ERROR : SIMULATION TIMED OUT");
           $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/clk_per);
           $finish;
         end 
     end
   end


   always @(negedge clk_in) 
   begin
   if (io_reset == 1'b0) begin
    if (pattern_completed_out == 2'b00) 
       $display("SIMULATION started");
    else if (pattern_completed_out == 2'b10) begin
       $timeformat(-9, 2, "ns", 10);
       $display("ERROR : SIMULATION FAILED. SDR, DDR Design");
       $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/clk_per);
       $finish;
      end
    else if (pattern_completed_out == 2'b01) begin
       bitslip_timeout <= bitslip_timeout + 1'b1;
       if (bitslip_timeout == 17'b11111111111111111) begin
       $timeformat(-9, 2, "ns", 10);
       $display("ERROR : TOO LONG. SDR, DDR Design");
       $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/clk_per);
       $finish;
       end
       $display("SIMULATION in progress: data checking in progress");
       end
    else if (pattern_completed_out == 2'b11) begin
       bitslip_timeout <= 0;
       $timeformat(-9, 2, "ns", 10);
       $display("SIMULATION PASSED");
       $display ("Test Completed Successfully");
       $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/clk_per);
       $finish;
      end
    else begin
       $timeformat(-9, 2, "ns", 10);
       $display("ERROR : UNKNOWN STATE. SDR, DDR Design");
       $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/clk_per);
       $finish;
      end
    end
   end


   assign #1000 data_in_from_pins_del = data_in_from_pins;
   assign data_in_from_pins = data_out_to_pins;

   assign  clk_in_fwd    =   clk_to_pins_fwd;

  assign #(0.3*clk_per) pattern_completed_out = pattern_completed_out1;


  // Instantiation of the example design
  //---------------------------------------------------------
  cmd_oserdes_exdes
         dut
  (
   .pattern_completed_out     (pattern_completed_out1),
   // From the system into the device
   .data_in_from_pins         (data_in_from_pins_del),
   .data_out_to_pins	      (data_out_to_pins),
   .clk_to_pins_fwd           (clk_to_pins_fwd),
   .clk_in_fwd                (clk_in_fwd),
   .clk_in                    (clk_in),

   .clk_reset                 (clk_reset),
   .io_reset                  (io_reset));
endmodule
