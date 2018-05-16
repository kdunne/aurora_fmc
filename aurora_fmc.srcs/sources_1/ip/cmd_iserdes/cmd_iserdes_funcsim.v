// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4.1 (lin64) Build 1149489 Thu Feb 19 16:00:12 MST 2015
// Date        : Thu Apr 19 13:27:05 2018
// Host        : dhcp-130-148.ucsc.edu running 64-bit Scientific Linux CERN SLC release 6.9 (Carbon)
// Command     : write_verilog -force -mode funcsim
//               /home/pixdaq/kdunne/fmc_four_lane_io_buf_640/aurora_rx/aurora_rx.srcs/sources_1/ip/cmd_iserdes/cmd_iserdes_funcsim.v
// Design      : cmd_iserdes
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "cmd_iserdes,selectio_wiz_v5_1,{component_name=cmd_iserdes,bus_dir=INPUTS,bus_sig_type=SINGLE,bus_io_std=LVCMOS18,use_serialization=false,use_phase_detector=false,serialization_factor=4,enable_bitslip=false,enable_train=false,system_data_width=1,bus_in_delay=NONE,bus_out_delay=NONE,clk_sig_type=SINGLE,clk_io_std=LVCMOS18,clk_buf=BUFIO2,active_edge=RISING,clk_delay=NONE,selio_bus_in_delay=NONE,selio_bus_out_delay=NONE,selio_clk_buf=BUFIO,selio_active_edge=SDR,selio_ddr_alignment=SAME_EDGE_PIPELINED,selio_oddr_alignment=SAME_EDGE,ddr_alignment=C0,selio_interface_type=NETWORKING,interface_type=NETWORKING,selio_bus_in_tap=0,selio_bus_out_tap=0,selio_clk_io_std=LVCMOS18,selio_clk_sig_type=SINGLE}" *) (* SYS_W = "1" *) (* DEV_W = "1" *) 
(* NotValidForBitStream *)
module cmd_iserdes
   (data_in_from_pins,
    data_in_to_device,
    clk_in,
    clk_out,
    io_reset);
  input [0:0]data_in_from_pins;
  output [0:0]data_in_to_device;
  input clk_in;
  output clk_out;
  input io_reset;

(* IBUF_LOW_PWR *) (* IOSTANDARD = "LVCMOS18" *)   wire clk_in;
  wire clk_out;
(* IBUF_LOW_PWR *) (* IOSTANDARD = "LVCMOS18" *)   wire [0:0]data_in_from_pins;
  wire [0:0]data_in_to_device;
  wire io_reset;

(* DEV_W = "1" *) 
   (* SYS_W = "1" *) 
   cmd_iserdes_cmd_iserdes_selectio_wiz inst
       (.clk_in(clk_in),
        .clk_out(clk_out),
        .data_in_from_pins(data_in_from_pins),
        .data_in_to_device(data_in_to_device),
        .io_reset(io_reset));
endmodule

(* SYS_W = "1" *) (* DEV_W = "1" *) (* ORIG_REF_NAME = "cmd_iserdes_selectio_wiz" *) 
module cmd_iserdes_cmd_iserdes_selectio_wiz
   (data_in_from_pins,
    data_in_to_device,
    clk_in,
    clk_out,
    io_reset);
  input [0:0]data_in_from_pins;
  output [0:0]data_in_to_device;
  input clk_in;
  output clk_out;
  input io_reset;

(* IBUF_LOW_PWR *) (* IOSTANDARD = "LVCMOS18" *)   wire clk_in;
  wire clk_in_int;
  wire clk_out;
(* IBUF_LOW_PWR *) (* IOSTANDARD = "LVCMOS18" *)   wire [0:0]data_in_from_pins;
  wire data_in_from_pins_int;
  wire [0:0]data_in_to_device;
  wire io_reset;
  wire NLW_clkout_buf_inst_CE_UNCONNECTED;
  wire NLW_clkout_buf_inst_CLR_UNCONNECTED;

(* BOX_TYPE = "PRIMITIVE" *) 
   BUFR #(
    .BUFR_DIVIDE("BYPASS"),
    .SIM_DEVICE("7SERIES")) 
     clkout_buf_inst
       (.CE(NLW_clkout_buf_inst_CE_UNCONNECTED),
        .CLR(NLW_clkout_buf_inst_CLR_UNCONNECTED),
        .I(clk_in_int),
        .O(clk_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   IBUF ibuf_clk_inst
       (.I(clk_in),
        .O(clk_in_int));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* IOB = "TRUE" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     \pins[0].fdre_in_inst 
       (.C(clk_out),
        .CE(1'b1),
        .D(data_in_from_pins_int),
        .Q(data_in_to_device),
        .R(io_reset));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   IBUF \pins[0].ibuf_inst 
       (.I(data_in_from_pins),
        .O(data_in_from_pins_int));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
