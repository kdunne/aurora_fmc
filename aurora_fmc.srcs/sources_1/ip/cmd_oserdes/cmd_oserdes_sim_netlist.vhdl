-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4.1 (lin64) Build 2117270 Tue Jan 30 15:31:13 MST 2018
-- Date        : Fri May 25 10:36:26 2018
-- Host        : GSVHonestMistake running 64-bit Ubuntu 16.04.4 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/tony/src/UW/research/Hauck_LHC/cern_cable_test/aurora/fmc_four_lane/aurora_tx_four_lane_1280/aurora_tx.srcs/sources_1/ip/cmd_oserdes/cmd_oserdes_sim_netlist.vhdl
-- Design      : cmd_oserdes
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity cmd_oserdes_cmd_oserdes_selectio_wiz is
  port (
    data_out_from_device : in STD_LOGIC_VECTOR ( 7 downto 0 );
    data_out_to_pins_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    data_out_to_pins_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk_in : in STD_LOGIC;
    clk_div_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute DEV_W : integer;
  attribute DEV_W of cmd_oserdes_cmd_oserdes_selectio_wiz : entity is 8;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of cmd_oserdes_cmd_oserdes_selectio_wiz : entity is "cmd_oserdes_selectio_wiz";
  attribute SYS_W : integer;
  attribute SYS_W of cmd_oserdes_cmd_oserdes_selectio_wiz : entity is 1;
  attribute num_serial_bits : integer;
  attribute num_serial_bits of cmd_oserdes_cmd_oserdes_selectio_wiz : entity is 8;
end cmd_oserdes_cmd_oserdes_selectio_wiz;

architecture STRUCTURE of cmd_oserdes_cmd_oserdes_selectio_wiz is
  signal data_out_to_pins_int : STD_LOGIC;
  signal \NLW_pins[0].oserdese2_master_OFB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].oserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].oserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].oserdese2_master_TBYTEOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].oserdese2_master_TFB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].oserdese2_master_TQ_UNCONNECTED\ : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \pins[0].obufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of \pins[0].obufds_inst\ : label is "DONT_CARE";
  attribute BOX_TYPE of \pins[0].oserdese2_master\ : label is "PRIMITIVE";
begin
\pins[0].obufds_inst\: unisim.vcomponents.OBUFDS
     port map (
      I => data_out_to_pins_int,
      O => data_out_to_pins_p(0),
      OB => data_out_to_pins_n(0)
    );
\pins[0].oserdese2_master\: unisim.vcomponents.OSERDESE2
    generic map(
      DATA_RATE_OQ => "DDR",
      DATA_RATE_TQ => "SDR",
      DATA_WIDTH => 8,
      INIT_OQ => '0',
      INIT_TQ => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      IS_D3_INVERTED => '0',
      IS_D4_INVERTED => '0',
      IS_D5_INVERTED => '0',
      IS_D6_INVERTED => '0',
      IS_D7_INVERTED => '0',
      IS_D8_INVERTED => '0',
      IS_T1_INVERTED => '0',
      IS_T2_INVERTED => '0',
      IS_T3_INVERTED => '0',
      IS_T4_INVERTED => '0',
      SERDES_MODE => "MASTER",
      SRVAL_OQ => '0',
      SRVAL_TQ => '0',
      TBYTE_CTL => "FALSE",
      TBYTE_SRC => "FALSE",
      TRISTATE_WIDTH => 1
    )
        port map (
      CLK => clk_in,
      CLKDIV => clk_div_in,
      D1 => data_out_from_device(0),
      D2 => data_out_from_device(1),
      D3 => data_out_from_device(2),
      D4 => data_out_from_device(3),
      D5 => data_out_from_device(4),
      D6 => data_out_from_device(5),
      D7 => data_out_from_device(6),
      D8 => data_out_from_device(7),
      OCE => '1',
      OFB => \NLW_pins[0].oserdese2_master_OFB_UNCONNECTED\,
      OQ => data_out_to_pins_int,
      RST => io_reset,
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      SHIFTOUT1 => \NLW_pins[0].oserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[0].oserdese2_master_SHIFTOUT2_UNCONNECTED\,
      T1 => '0',
      T2 => '0',
      T3 => '0',
      T4 => '0',
      TBYTEIN => '0',
      TBYTEOUT => \NLW_pins[0].oserdese2_master_TBYTEOUT_UNCONNECTED\,
      TCE => '0',
      TFB => \NLW_pins[0].oserdese2_master_TFB_UNCONNECTED\,
      TQ => \NLW_pins[0].oserdese2_master_TQ_UNCONNECTED\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity cmd_oserdes is
  port (
    data_out_from_device : in STD_LOGIC_VECTOR ( 7 downto 0 );
    data_out_to_pins_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    data_out_to_pins_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk_in : in STD_LOGIC;
    clk_div_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of cmd_oserdes : entity is true;
  attribute DEV_W : integer;
  attribute DEV_W of cmd_oserdes : entity is 8;
  attribute SYS_W : integer;
  attribute SYS_W of cmd_oserdes : entity is 1;
end cmd_oserdes;

architecture STRUCTURE of cmd_oserdes is
  attribute DEV_W of inst : label is 8;
  attribute SYS_W of inst : label is 1;
  attribute num_serial_bits : integer;
  attribute num_serial_bits of inst : label is 8;
begin
inst: entity work.cmd_oserdes_cmd_oserdes_selectio_wiz
     port map (
      clk_div_in => clk_div_in,
      clk_in => clk_in,
      data_out_from_device(7 downto 0) => data_out_from_device(7 downto 0),
      data_out_to_pins_n(0) => data_out_to_pins_n(0),
      data_out_to_pins_p(0) => data_out_to_pins_p(0),
      io_reset => io_reset
    );
end STRUCTURE;
