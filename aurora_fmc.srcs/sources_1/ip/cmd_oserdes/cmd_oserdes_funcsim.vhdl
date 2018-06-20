-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.4.1 (lin64) Build 1149489 Thu Feb 19 16:00:12 MST 2015
-- Date        : Tue Jun 19 15:43:16 2018
-- Host        : dhcp-130-148.ucsc.edu running 64-bit Scientific Linux CERN SLC release 6.9 (Carbon)
-- Command     : write_vhdl -force -mode funcsim
--               /home/pixdaq/kdunne/fmc_one_lane/aurora_fmc/aurora_fmc.srcs/sources_1/ip/cmd_oserdes/cmd_oserdes_funcsim.vhdl
-- Design      : cmd_oserdes
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx485tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity cmd_oserdes_cmd_oserdes_selectio_wiz is
  port (
    data_in_from_pins_p : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in_from_pins_n : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in_to_device : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk_in_p : in STD_LOGIC;
    clk_in_n : in STD_LOGIC;
    clk_out : out STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute SYS_W : integer;
  attribute SYS_W of cmd_oserdes_cmd_oserdes_selectio_wiz : entity is 1;
  attribute DEV_W : integer;
  attribute DEV_W of cmd_oserdes_cmd_oserdes_selectio_wiz : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of cmd_oserdes_cmd_oserdes_selectio_wiz : entity is "cmd_oserdes_selectio_wiz";
end cmd_oserdes_cmd_oserdes_selectio_wiz;

architecture STRUCTURE of cmd_oserdes_cmd_oserdes_selectio_wiz is
  signal clk_in_int : STD_LOGIC;
  signal \^clk_out\ : STD_LOGIC;
  signal data_in_from_pins_int : STD_LOGIC;
  signal NLW_clkout_buf_inst_CE_UNCONNECTED : STD_LOGIC;
  signal NLW_clkout_buf_inst_CLR_UNCONNECTED : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkout_buf_inst : label is "PRIMITIVE";
  attribute BOX_TYPE of ibufds_clk_inst : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of ibufds_clk_inst : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of ibufds_clk_inst : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of ibufds_clk_inst : label is "AUTO";
  attribute BOX_TYPE of \pins[0].fdre_in_inst\ : label is "PRIMITIVE";
  attribute IOB : string;
  attribute IOB of \pins[0].fdre_in_inst\ : label is "TRUE";
  attribute BOX_TYPE of \pins[0].ibufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[0].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[0].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[0].ibufds_inst\ : label is "AUTO";
begin
  clk_out <= \^clk_out\;
clkout_buf_inst: unisim.vcomponents.BUFR
    generic map(
      BUFR_DIVIDE => "BYPASS",
      SIM_DEVICE => "7SERIES"
    )
    port map (
      CE => NLW_clkout_buf_inst_CE_UNCONNECTED,
      CLR => NLW_clkout_buf_inst_CLR_UNCONNECTED,
      I => clk_in_int,
      O => \^clk_out\
    );
ibufds_clk_inst: unisim.vcomponents.IBUFDS
    generic map(
      DQS_BIAS => "FALSE"
    )
    port map (
      I => clk_in_p,
      IB => clk_in_n,
      O => clk_in_int
    );
\pins[0].fdre_in_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => \^clk_out\,
      CE => '1',
      D => data_in_from_pins_int,
      Q => data_in_to_device(0),
      R => io_reset
    );
\pins[0].ibufds_inst\: unisim.vcomponents.IBUFDS
    generic map(
      DQS_BIAS => "FALSE"
    )
    port map (
      I => data_in_from_pins_p(0),
      IB => data_in_from_pins_n(0),
      O => data_in_from_pins_int
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity cmd_oserdes is
  port (
    data_in_from_pins_p : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in_from_pins_n : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in_to_device : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk_in_p : in STD_LOGIC;
    clk_in_n : in STD_LOGIC;
    clk_out : out STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of cmd_oserdes : entity is true;
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of cmd_oserdes : entity is "cmd_oserdes,selectio_wiz_v5_1,{component_name=cmd_oserdes,bus_dir=INPUTS,bus_sig_type=DIFF,bus_io_std=LVDS,use_serialization=false,use_phase_detector=false,serialization_factor=4,enable_bitslip=false,enable_train=false,system_data_width=1,bus_in_delay=NONE,bus_out_delay=NONE,clk_sig_type=SINGLE,clk_io_std=LVCMOS18,clk_buf=BUFIO2,active_edge=RISING,clk_delay=NONE,selio_bus_in_delay=NONE,selio_bus_out_delay=NONE,selio_clk_buf=BUFIO,selio_active_edge=SDR,selio_ddr_alignment=SAME_EDGE_PIPELINED,selio_oddr_alignment=SAME_EDGE,ddr_alignment=C0,selio_interface_type=NETWORKING,interface_type=NETWORKING,selio_bus_in_tap=0,selio_bus_out_tap=0,selio_clk_io_std=LVDS,selio_clk_sig_type=DIFF}";
  attribute SYS_W : integer;
  attribute SYS_W of cmd_oserdes : entity is 1;
  attribute DEV_W : integer;
  attribute DEV_W of cmd_oserdes : entity is 1;
end cmd_oserdes;

architecture STRUCTURE of cmd_oserdes is
  attribute DEV_W of inst : label is 1;
  attribute SYS_W of inst : label is 1;
begin
inst: entity work.cmd_oserdes_cmd_oserdes_selectio_wiz
    port map (
      clk_in_n => clk_in_n,
      clk_in_p => clk_in_p,
      clk_out => clk_out,
      data_in_from_pins_n(0) => data_in_from_pins_n(0),
      data_in_from_pins_p(0) => data_in_from_pins_p(0),
      data_in_to_device(0) => data_in_to_device(0),
      io_reset => io_reset
    );
end STRUCTURE;
