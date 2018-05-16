-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.4.1 (lin64) Build 1149489 Thu Feb 19 16:00:12 MST 2015
-- Date        : Thu Apr 19 13:27:48 2018
-- Host        : dhcp-130-148.ucsc.edu running 64-bit Scientific Linux CERN SLC release 6.9 (Carbon)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/pixdaq/kdunne/fmc_four_lane_io_buf_640/aurora_rx/aurora_rx.srcs/sources_1/ip/fifo_fwft/fifo_fwft_stub.vhdl
-- Design      : fifo_fwft
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx485tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifo_fwft is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 65 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 65 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC
  );

end fifo_fwft;

architecture stub of fifo_fwft is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst,din[65:0],wr_en,rd_en,dout[65:0],full,empty";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v12_0,Vivado 2014.4.1";
begin
end;
