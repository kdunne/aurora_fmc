Based on firmware from Lev Kurilenko

An FPGA Mezzanine Card to drive 8 LVDS pairs using Aurora 64b/66b encoding
Using Xilinx VC707 evaluation board

--------------------

### TODO

-  Merge aurora rx_four_lane_top with tx_four_lane_top
-  Find out if IO_config_buf is needed
-  Select appropriate clocks (160 Mbps)
-  Generate 1 lane of data
-  Use debug cores to test
-  Route BER output somewhere (LCDdriver)
-  Find replacement for USER_SMA_CLK?

---

### Finished

- [x] Change constraints from KC705 to VC707 evaluation board commit: 172764114d4dd8e4aec780bc010fea50a3d8d92f
- [x] Merge rx/tx constraints commit: 172764114d4dd8e4aec780bc010fea50a3d8d92f
- [x] Program rx/tx separately to VC707 - probe FMC outputs
- [x] Merge rx/tx sources to aurora_fmc/ commit: 172764114d4dd8e4aec780bc010fea50a3d8d92f
- [x] Merge aurora_rx_top.sv with aurora_fmc_top.sv commit: a7fe34345864793f72ecf45fddb8a5f5cc03979e
