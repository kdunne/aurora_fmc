// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4.1 (lin64) Build 1149489 Thu Feb 19 16:00:12 MST 2015
// Date        : Thu Apr 19 13:28:57 2018
// Host        : dhcp-130-148.ucsc.edu running 64-bit Scientific Linux CERN SLC release 6.9 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /home/pixdaq/kdunne/fmc_four_lane_io_buf_640/aurora_rx/aurora_rx.srcs/sources_1/ip/vio_0/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2014.4.1" *)
module vio_0(clk, probe_out0, probe_out1, probe_out2, probe_out3)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_out0[0:0],probe_out1[31:0],probe_out2[0:0],probe_out3[0:0]" */;
  input clk;
  output [0:0]probe_out0;
  output [31:0]probe_out1;
  output [0:0]probe_out2;
  output [0:0]probe_out3;
endmodule
