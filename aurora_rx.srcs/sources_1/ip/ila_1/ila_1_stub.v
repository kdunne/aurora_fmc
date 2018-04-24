// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4.1 (lin64) Build 1149489 Thu Feb 19 16:00:12 MST 2015
// Date        : Thu Apr 19 13:30:04 2018
// Host        : dhcp-130-148.ucsc.edu running 64-bit Scientific Linux CERN SLC release 6.9 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /home/pixdaq/kdunne/fmc_four_lane_io_buf_640/aurora_rx/aurora_rx.srcs/sources_1/ip/ila_1/ila_1_stub.v
// Design      : ila_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2014.4.1" *)
module ila_1(clk, probe0, probe1, probe2, probe3, probe4, probe5, probe6, probe7, probe8, probe9, probe10)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0],probe1[3:0],probe2[255:0],probe3[255:0],probe4[7:0],probe5[3:0],probe6[0:0],probe7[0:0],probe8[0:0],probe9[0:0],probe10[0:0]" */;
  input clk;
  input [0:0]probe0;
  input [3:0]probe1;
  input [255:0]probe2;
  input [255:0]probe3;
  input [7:0]probe4;
  input [3:0]probe5;
  input [0:0]probe6;
  input [0:0]probe7;
  input [0:0]probe8;
  input [0:0]probe9;
  input [0:0]probe10;
endmodule
