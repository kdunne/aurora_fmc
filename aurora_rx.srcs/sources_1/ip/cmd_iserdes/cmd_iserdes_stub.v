// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4.1 (lin64) Build 1149489 Thu Feb 19 16:00:12 MST 2015
// Date        : Thu Apr 19 13:27:05 2018
// Host        : dhcp-130-148.ucsc.edu running 64-bit Scientific Linux CERN SLC release 6.9 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /home/pixdaq/kdunne/fmc_four_lane_io_buf_640/aurora_rx/aurora_rx.srcs/sources_1/ip/cmd_iserdes/cmd_iserdes_stub.v
// Design      : cmd_iserdes
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module cmd_iserdes(data_in_from_pins, data_in_to_device, clk_in, clk_out, io_reset)
/* synthesis syn_black_box black_box_pad_pin="data_in_from_pins[0:0],data_in_to_device[0:0],clk_in,clk_out,io_reset" */;
  input [0:0]data_in_from_pins;
  output [0:0]data_in_to_device;
  input clk_in;
  output clk_out;
  input io_reset;
endmodule