################################## Clock Constraints ##########################
create_clock -period 5.00000000000000000 -waveform {0.00000000000000000 2.50000000000000000} [get_ports sysclk_in_p]

# imported from fmc_four_lane_io_buf_640/aurora_tx
create_clock -period 12.5 -waveform {0.000 6.25} [get_ports USER_SMA_CLOCK_P]


#create_generated_clock -name ttc_decoder_i/rclk -source [get_pins pll_i/clk_out1] -divide_by 3 [get_pins ttc_decoder_i/sample_reg/Q]
#create_generated_clock -name phase_sel_i/clk40_i -source [get_pins ttc_decoder_i/sample_reg/Q] -divide_by 4 [get_pins phase_sel_i/clk_out_reg/Q]
#create_generated_clock -source [get_pins phase_sel_i/clk_out_reg/Q] -multiply_by 2 [get_pins cout_i/recovered_clk/inst/clk_out1]
#create_generated_clock -source [get_pins phase_sel_i/clk_out_reg/Q] -multiply_by 2 [get_pins cout_i/recovered_clk/clk_out1]

################################# Location constraints ########################

##### LOCATIONS ARE FOR XILINX VC707 BOARD ONLY #####

#Reset input - GPIO_SW_N
set_property PACKAGE_PIN AR40 [get_ports rst_in]
set_property IOSTANDARD LVCMOS18 [get_ports rst_in]

#Sys/Rst Clk - built into board 200MHz
set_property PACKAGE_PIN E18 [get_ports sysclk_in_n]
set_property IOSTANDARD LVDS [get_ports sysclk_in_n]
set_property PACKAGE_PIN E19 [get_ports sysclk_in_p]
set_property IOSTANDARD LVDS [get_ports sysclk_in_p]

# XAPP IOBUF used to route clk640 as Input
# set_property PACKAGE_PIN AD23 [get_ports clk640inout]
# set_property IOSTANDARD LVCMOS25 [get_ports clk640inout]


################################# FMC ISERDES Input ########################
## ISERDES Input
## FMC_LPC_LA06_P
#set_property PACKAGE_PIN AK20 [get_ports data_in_p[0]]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_p[0]]
#set_property DIFF_TERM TRUE [get_ports data_in_p[0]]
## FMC_LPC_LA06_N
#set_property PACKAGE_PIN AK21 [get_ports data_in_n[0]]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_n[0]]
#set_property DIFF_TERM TRUE [get_ports data_in_n[0]]


### Lane 0
###FMC_LPC_LA02_P
##set_property PACKAGE_PIN AF20 [get_ports data_in_p[0]]
##set_property IOSTANDARD LVDS_25 [get_ports data_in_p[0]]
##set_property DIFF_TERM TRUE [get_ports data_in_p[0]]
###FMC_LPC_LA02_N
##set_property PACKAGE_PIN AF21 [get_ports data_in_n[0]]
##set_property IOSTANDARD LVDS_25 [get_ports data_in_n[0]]
##set_property DIFF_TERM TRUE [get_ports data_in_n[0]]

## Lane 1
##FMC_LPC_LA03_P
#set_property PACKAGE_PIN AG20 [get_ports data_in_p[1]]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_p[1]]
#set_property DIFF_TERM TRUE [get_ports data_in_p[1]]
##FMC_LPC_LA03_N
#set_property PACKAGE_PIN AH20 [get_ports data_in_n[1]]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_n[1]]
#set_property DIFF_TERM TRUE [get_ports data_in_n[1]]

## Lane 2
##FMC_LPC_LA04_N
#set_property PACKAGE_PIN AH21 [get_ports data_in_p[2]]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_p[2]]
#set_property DIFF_TERM TRUE [get_ports data_in_p[2]]
##FMC_LPC_LA04_N
#set_property PACKAGE_PIN AJ21 [get_ports data_in_n[2]]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_n[2]]
#set_property DIFF_TERM TRUE [get_ports data_in_n[2]]

## Lane 3
##FMC_LPC_LA05_P
#set_property PACKAGE_PIN AG22 [get_ports data_in_p[3]]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_p[3]]
#set_property DIFF_TERM TRUE [get_ports data_in_p[3]]
##FMC_LPC_LA05_N
#set_property PACKAGE_PIN AH22 [get_ports data_in_n[3]]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_n[3]]
#set_property DIFF_TERM TRUE [get_ports data_in_n[3]]

################################# FMC Clock Output ########################
##USER FMC CLOCK
#set_property PACKAGE_PIN AD23 [get_ports USER_SMA_CLOCK_P]
#set_property IOSTANDARD LVDS_25 [get_ports USER_SMA_CLOCK_P]
#set_property PACKAGE_PIN AE24 [get_ports USER_SMA_CLOCK_N]
#set_property IOSTANDARD LVDS_25 [get_ports USER_SMA_CLOCK_N]

################################# SMA ISERDES Input ########################
## ISERDES Input
## USER_GPIO_P
#set_property PACKAGE_PIN Y23 [get_ports data_in_p]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_p]
#set_property DIFF_TERM TRUE [get_ports data_in_p]
## USER_GPIO_N
#set_property PACKAGE_PIN Y24 [get_ports data_in_n]
#set_property IOSTANDARD LVDS_25 [get_ports data_in_n]
#set_property DIFF_TERM TRUE [get_ports data_in_n]

################################# SMA Clock Output ########################
#USER SMA CLOCK
set_property PACKAGE_PIN AJ32 [get_ports USER_SMA_CLOCK_P]
set_property IOSTANDARD LVDS [get_ports USER_SMA_CLOCK_P]
set_property PACKAGE_PIN AK32 [get_ports USER_SMA_CLOCK_N]
set_property IOSTANDARD LVDS [get_ports USER_SMA_CLOCK_N]

######################## FMC HPC IO Buffer OSERDES Output ########################
## Lane 0
##FMC_LPC_LA06_P
#set_property PACKAGE_PIN AK20 [get_ports data_out_p[0]]
#set_property IOSTANDARD LVDS_25 [get_ports data_out_p[0]]
##FMC_LPC_LA06_N
#set_property PACKAGE_PIN AK21 [get_ports data_out_n[0]]
#set_property IOSTANDARD LVDS_25 [get_ports data_out_n[0]]

# Lane 0 
# Changed to VC707
# FMC_HPC_LA02_P
set_property PACKAGE_PIN P41 [get_ports data_in_p[0]]
set_property IOSTANDARD LVDS [get_ports data_in_p[0]]
set_property DIFF_TERM TRUE [get_ports data_in_p[0]]
# FMC_HPC_LA02_N
set_property PACKAGE_PIN N41 [get_ports data_in_n[0]]
set_property IOSTANDARD LVDS [get_ports data_in_n[0]]
set_property DIFF_TERM TRUE [get_ports data_in_n[0]]

# Lane 1
# Changed to VC707
# FMC_HPC_LA03_P
set_property PACKAGE_PIN M42 [get_ports data_in_p[1]]
set_property IOSTANDARD LVDS [get_ports data_in_p[1]]
set_property DIFF_TERM TRUE [get_ports data_in_p[1]]
# FMC_HPC_LA03_N
set_property PACKAGE_PIN L42 [get_ports data_in_n[1]]
set_property IOSTANDARD LVDS [get_ports data_in_n[1]]
set_property DIFF_TERM TRUE [get_ports data_in_n[1]]

# Lane 2
# Changed to VC707
# FMC_HPC_LA04_P
set_property PACKAGE_PIN H40 [get_ports data_in_p[2]]
set_property IOSTANDARD LVDS [get_ports data_in_p[2]]
set_property DIFF_TERM TRUE [get_ports data_in_p[2]]
# FMC_HPC_LA04_N
set_property PACKAGE_PIN H41 [get_ports data_in_n[2]]
set_property IOSTANDARD LVDS [get_ports data_in_n[2]]
set_property DIFF_TERM TRUE [get_ports data_in_n[2]]

# Lane 3
# Changed to VC707
# FMC_HPC_LA05_P
set_property PACKAGE_PIN AF42 [get_ports data_in_p[3]]
set_property IOSTANDARD LVDS [get_ports data_in_p[3]]
set_property DIFF_TERM TRUE [get_ports data_in_p[3]]
# FMC_HPC_LA05_N
set_property PACKAGE_PIN AG42 [get_ports data_in_n[3]]
set_property IOSTANDARD LVDS [get_ports data_in_n[3]]
set_property DIFF_TERM TRUE [get_ports data_in_n[3]]

######################### IO Buffer Driver Ports ########################
#FMC2_HPC_LA17_CC_N
# Changedto VC707
set_property PACKAGE_PIN D21 [get_ports latch]
set_property IOSTANDARD LVCMOS18 [get_ports latch]

#FMC2_HPC_LA32_N
# Changed to VC707
set_property PACKAGE_PIN H38 [get_ports clk_io]
set_property IOSTANDARD LVCMOS18 [get_ports clk_io]

#FMC2_HPC_LA33_P
# Changed to VC707
set_property PACKAGE_PIN G36 [get_ports ser_in]
set_property IOSTANDARD LVCMOS18 [get_ports ser_in]
