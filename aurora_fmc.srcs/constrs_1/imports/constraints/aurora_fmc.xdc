################################## Clock Constraints ##########################
create_clock -period 5.00000000000000000 -waveform {0.00000000000000000 2.50000000000000000} [get_ports sysclk_in_p]

# imported from fmc_four_lane_io_buf_640/aurora_tx
create_clock -period 12.5 -waveform {0.000 6.25} [get_ports USER_SMA_CLOCK_P]


#create_generated_clock -name ttc_decoder_i/rclk -source [get_pins pll_i/clk_out1] -divide_by 3 [get_pins ttc_decoder_i/sample_reg/Q]
#create_generated_clock -name phase_sel_i/clk40_i -source [get_pins ttc_decoder_i/sample_reg/Q] -divide_by 4 [get_pins phase_sel_i/clk_out_reg/Q]
#create_generated_clock -source [get_pins phase_sel_i/clk_out_reg/Q] -multiply_by 2 [get_pins cout_i/recovered_clk/inst/clk_out1]
#create_generated_clock -source [get_pins phase_sel_i/clk_out_reg/Q] -multiply_by 2 [get_pins cout_i/recovered_clk/clk_out1]

################################# Location constraints ########################

##### LOCATIONS ARE FOR XILINX VC707 BOARD UNLESS NOTED #####

#Reset input - GPIO_SW_N
set_property PACKAGE_PIN AR40 [get_ports rst_in]
set_property IOSTANDARD LVCMOS18 [get_ports rst_in]

#Sys/Rst Clk - built into board 200MHz
set_property PACKAGE_PIN E18 [get_ports sysclk_in_n]
set_property IOSTANDARD LVDS [get_ports sysclk_in_n]
set_property PACKAGE_PIN E19 [get_ports sysclk_in_p]
set_property IOSTANDARD LVDS [get_ports sysclk_in_p]

# XAPP IOBUF used to route clk640 as Input
# KC705
# set_property PACKAGE_PIN AD23 [get_ports clk640inout]
# set_property IOSTANDARD LVCMOS25 [get_ports clk640inout]

######################## FMC HPC IO Buffer OSERDES Output ########################
# Lane 0
#FMC_HPC_LA02_P
set_property PACKAGE_PIN AK39 [get_ports data_out_p[0]]
set_property IOSTANDARD LVCMOS18 [get_ports data_out_p[0]]
#FMC_HPC_LA02_N
set_property PACKAGE_PIN AL39 [get_ports data_out_n[0]]
set_property IOSTANDARD LVCMOS18 [get_ports data_out_n[0]]

# Lane 1
#FMC_HPC_LA03_P
set_property PACKAGE_PIN AJ42 [get_ports data_out_p[1]]
set_property IOSTANDARD LVCMOS18 [get_ports data_out_p[1]]
#FMC_HPC_LA03_N
set_property PACKAGE_PIN AK42 [get_ports data_out_n[1]]
set_property IOSTANDARD LVCMOS18 [get_ports data_out_n[1]]

# Lane 2
#FMC_HPC_LA04_N
set_property PACKAGE_PIN AL41 [get_ports data_out_p[2]]
set_property IOSTANDARD LVCMOS18 [get_ports data_out_p[2]]
#FMC_HPC_LA04_N
set_property PACKAGE_PIN AL42 [get_ports data_out_n[2]]
set_property IOSTANDARD LVCMOS18 [get_ports data_out_n[2]]

# Lane 3
#FMC_HPC_LA08_P
set_property PACKAGE_PIN AD42 [get_ports data_out_p[3]]
set_property IOSTANDARD LVCMOS18 [get_ports data_out_p[3]]
#FMC_HPC_LA08_N
set_property PACKAGE_PIN AE42 [get_ports data_out_n[3]]
set_property IOSTANDARD LVCMOS18 [get_ports data_out_n[3]]

# Lane 4
#FMC_HPC_LA07_P
#set_property PACKAGE_PIN AC40 [get_ports data_out_p[4]]
#set_property IOSTANDARD LVCMOS18 [get_ports data_out_p[4]]
#FMC_HPC_LA07_N
#set_property PACKAGE_PIN AC41 [get_ports data_out_n[4]]
#set_property IOSTANDARD LVCMOS18 [get_ports data_out_n[4]]

# Lane 5
#FMC_HPC_LA12_P
#set_property PACKAGE_PIN Y39 [get_ports data_out_p[5]]
#set_property IOSTANDARD LVCMOS18 [get_ports data_out_p[5]]
#FMC_HPC_LA12_N
#set_property PACKAGE_PIN AA39 [get_ports data_out_n[5]]
#set_property IOSTANDARD LVCMOS18 [get_ports data_out_n[5]]

# Lane 6
#FMC_HPC_LA11_P
#set_property PACKAGE_PIN Y42 [get_ports data_out_p[6]]
#set_property IOSTANDARD LVCMOS18 [get_ports data_out_p[6]]
#FMC_HPC_LA11_N
#set_property PACKAGE_PIN AA42 [get_ports data_out_n[6]]
#set_property IOSTANDARD LVCMOS18 [get_ports data_out_n[6]]

# Lane 7
#FMC_HPC_LA15_P
#set_property PACKAGE_PIN AC38 [get_ports data_out_p[7]]
#set_property IOSTANDARD LVCMOS18 [get_ports data_out_p[7]]
#FMC_HPC_LA15_N
#set_property PACKAGE_PIN AC39 [get_ports data_out_n[7]]
#set_property IOSTANDARD LVCMOS18 [get_ports data_out_n[7]]

################################# FMC ISERDES Input ########################
## ISERDES Input

### Lane 0
###FMC_LPC_LA25_P
set_property PACKAGE_PIN R33 [get_ports data_in_p[0]]
set_property IOSTANDARD LVDS [get_ports data_in_p[0]]
set_property DIFF_TERM TRUE [get_ports data_in_p[0]]
###FMC_LPC_LA25_N
set_property PACKAGE_PIN R34 [get_ports data_in_n[0]]
set_property IOSTANDARD LVDS [get_ports data_in_n[0]]
set_property DIFF_TERM TRUE [get_ports data_in_n[0]]

## Lane 1
##FMC_LPC_LA24_P
set_property PACKAGE_PIN U34 [get_ports data_in_p[1]]
set_property IOSTANDARD LVDS [get_ports data_in_p[1]]
set_property DIFF_TERM TRUE [get_ports data_in_p[1]]
##FMC_LPC_LA24_N
set_property PACKAGE_PIN T35 [get_ports data_in_n[1]]
set_property IOSTANDARD LVDS [get_ports data_in_n[1]]
set_property DIFF_TERM TRUE [get_ports data_in_n[1]]

## Lane 2
##FMC_LPC_LA29_N
set_property PACKAGE_PIN W36 [get_ports data_in_p[2]]
set_property IOSTANDARD LVDS [get_ports data_in_p[2]]
set_property DIFF_TERM TRUE [get_ports data_in_p[2]]
##FMC_LPC_LA29_N
set_property PACKAGE_PIN W37 [get_ports data_in_n[2]]
set_property IOSTANDARD LVDS [get_ports data_in_n[2]]
set_property DIFF_TERM TRUE [get_ports data_in_n[2]]

## Lane 3
##FMC_LPC_LA28_P
set_property PACKAGE_PIN V35 [get_ports data_in_p[3]]
set_property IOSTANDARD LVDS [get_ports data_in_p[3]]
set_property DIFF_TERM TRUE [get_ports data_in_p[3]]
##FMC_LPC_LA28_N
set_property PACKAGE_PIN V36 [get_ports data_in_n[3]]
set_property IOSTANDARD LVDS [get_ports data_in_n[3]]
set_property DIFF_TERM TRUE [get_ports data_in_n[3]]

### Lane 4
###FMC_LPC_LA31_P
#set_property PACKAGE_PIN V39 [get_ports data_in_p[4]]
#set_property IOSTANDARD LVDS18 [get_ports data_in_p[4]]
#set_property DIFF_TERM TRUE [get_ports data_in_p[4]]
###FMC_LPC_LA31_N
#set_property PACKAGE_PIN V40 [get_ports data_in_n[4]]
#set_property IOSTANDARD LVDS18 [get_ports data_in_n[4]]
#set_property DIFF_TERM TRUE [get_ports data_in_n[4]]

## Lane 5
##FMC_LPC_LA30_P
#set_property PACKAGE_PIN T32 [get_ports data_in_p[5]]
#set_property IOSTANDARD LVDS18 [get_ports data_in_p[5]]
#set_property DIFF_TERM TRUE [get_ports data_in_p[5]]
##FMC_LPC_LA30_N
#set_property PACKAGE_PIN R32 [get_ports data_in_n[5]]
#set_property IOSTANDARD LVDS18 [get_ports data_in_n[5]]
#set_property DIFF_TERM TRUE [get_ports data_in_n[5]]

## Lane 6
##FMC_LPC_LA33_N
#set_property PACKAGE_PIN T36 [get_ports data_in_p[6]]
#set_property IOSTANDARD LVDS18 [get_ports data_in_p[6]]
#set_property DIFF_TERM TRUE [get_ports data_in_p[6]]
##FMC_LPC_LA33_N
#set_property PACKAGE_PIN R37 [get_ports data_in_n[6]]
#set_property IOSTANDARD LVDS18 [get_ports data_in_n[6]]
#set_property DIFF_TERM TRUE [get_ports data_in_n[6]]

## Lane 7
##FMC_LPC_LA32_P
#set_property PACKAGE_PIN P37 [get_ports data_in_p[7]]
#set_property IOSTANDARD LVDS18 [get_ports data_in_p[7]]
#set_property DIFF_TERM TRUE [get_ports data_in_p[7]]
##FMC_LPC_LA32_N
#set_property PACKAGE_PIN P38 [get_ports data_in_n[7]]
#set_property IOSTANDARD LVDS18 [get_ports data_in_n[7]]
#set_property DIFF_TERM TRUE [get_ports data_in_n[7]]

################################# FMC Clock Output ########################
##USER FMC CLOCK
# KC705
#set_property PACKAGE_PIN AD23 [get_ports USER_SMA_CLOCK_P]
#set_property IOSTANDARD LVDS_25 [get_ports USER_SMA_CLOCK_P]
#set_property PACKAGE_PIN AE24 [get_ports USER_SMA_CLOCK_N]
#set_property IOSTANDARD LVDS_25 [get_ports USER_SMA_CLOCK_N]

################################# SMA ISERDES Input ########################
## ISERDES Input
# KC705
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

################################## LCD Ports ########################
#GPIO LCD
#set_property PACKAGE_PIN AA13 [get_ports LCD_DB4_LS]
#set_property IOSTANDARD LVCMOS15 [get_ports LCD_DB4_LS]
#set_property PACKAGE_PIN AA10 [get_ports LCD_DB5_LS]
#set_property IOSTANDARD LVCMOS15 [get_ports LCD_DB5_LS]
#set_property PACKAGE_PIN AA11 [get_ports LCD_DB6_LS]
##set_property IOSTANDARD LVCMOS15 [get_ports LCD_DB6_LS]
#set_property IOSTANDARD LVCMOS15 [get_ports LCD_DB6_LS]
#set_property PACKAGE_PIN Y10 [get_ports LCD_DB7_LS]
#set_property IOSTANDARD LVCMOS15 [get_ports LCD_DB7_LS]
#set_property PACKAGE_PIN AB10 [get_ports LCD_E_LS]
#set_property IOSTANDARD LVCMOS15 [get_ports LCD_E_LS]
#set_property PACKAGE_PIN Y11 [get_ports LCD_RS_LS]
#set_property IOSTANDARD LVCMOS15 [get_ports LCD_RS_LS]
#set_property PACKAGE_PIN AB13 [get_ports LCD_RW_LS]
#set_property IOSTANDARD LVCMOS15 [get_ports LCD_RW_LS]

# Set False clock paths
#set_false_path -from [get_pins ttc_decoder_i/posOR_reg_reg/C] -to [get_pins ttc_decoder_i/sample_reg/D]
#set_false_path -from [get_clocks clk_out2_clk_wiz_0] -to [get_clocks ttc_decoder_i/rclk]
#set_false_path -from [get_clocks clk_out3_clk_wiz_0] -to [get_clocks clk_out1_clk_wiz_0]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk160]

