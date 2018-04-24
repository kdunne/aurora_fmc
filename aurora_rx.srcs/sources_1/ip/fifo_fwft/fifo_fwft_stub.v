// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4.1 (lin64) Build 1149489 Thu Feb 19 16:00:12 MST 2015
// Date        : Thu Apr 19 13:27:48 2018
// Host        : dhcp-130-148.ucsc.edu running 64-bit Scientific Linux CERN SLC release 6.9 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /home/pixdaq/kdunne/fmc_four_lane_io_buf_640/aurora_rx/aurora_rx.srcs/sources_1/ip/fifo_fwft/fifo_fwft_stub.v
// Design      : fifo_fwft
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v12_0,Vivado 2014.4.1" *)
module fifo_fwft(clk, rst, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,din[65:0],wr_en,rd_en,dout[65:0],full,empty" */;
  input clk;
  input rst;
  input [65:0]din;
  input wr_en;
  input rd_en;
  output [65:0]dout;
  output full;
  output empty;
endmodule
