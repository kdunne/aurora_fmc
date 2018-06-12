// Engineer: Lev Kurilenko
// Date: 11/27/2017
// Email: levkur@uw.edu
// Module: Aurora Tx Top w/ Support for multiple Aurora Lanes

module aurora_tx_four_lane_top(
    // input sysclk_in_p,
    // input sysclk_in_n,
    input rst_in,
    
    output [num_lanes-1:0] data_out_p,
    output [num_lanes-1:0] data_out_n,
    
    output latch,
    output clk_io,
    output ser_in,
    
    input USER_SMA_CLOCK_P,
    input USER_SMA_CLOCK_N
);

localparam ber_char = 64'hB0B5_C0CA_C01A_CAFE;
localparam cb_char = 64'h7800_0000_0000_0040;   // From Memory may need to be changed
localparam num_lanes = 4;       // Specify number of desired lanes. Needs further modifications to make this general purpose.
integer i;

// Resets
wire rst;

// Clocks
wire clk640;
wire clk160;
wire clk40;
wire mmcm_locked;

// Data Driver Signals
reg [11:0] cb_cnt;      // Counter used to send Channel Bonding frame every 4096 clock cycles

// Aurora Tx Core Signals
wire [num_lanes-1:0]  gearbox_rdy;
wire [num_lanes-1:0]  data_next;
reg  [63:0] data_in[num_lanes];
reg  [1:0]  sync[num_lanes];

// Reset deasserted when mmcm locks
assign rst = !mmcm_locked;

// Debug/Monitoring Signals
wire vio_rst;
wire vio_en;
wire [255:0] vio_data;
wire [7:0] vio_sync;
wire vio_en_counting;

//============================================
//               Data Driver
//============================================

always @(posedge clk40) begin
    if (rst|vio_rst) begin
        for (i=0; i<num_lanes; i=i+1) begin
            data_in[i] <= 64'h0000_0000_0000_0000;
            sync[i] <= 2'b00;
        end
        cb_cnt <= 12'h000;
    end
    else if ((&gearbox_rdy) & (&data_next)) begin
        if (vio_en) begin
            if (vio_en_counting) begin
                for (i=0; i<num_lanes; i=i+1) begin
                    data_in[i] <= data_in[i] + 1;
                    sync[i] <= 2'b01;
                end
            end
            else begin
                //for (i=0; i<num_lanes; i=i+1) begin
                //    data_in[i] <= vio_data[63+(64*i):i*64];
                //    sync[i] <= 2'b01;
                //end
                
                data_in[0] <= vio_data[63+(64*0):0*64];
                //sync[0] <= vio_sync[1+(2*0):0*2];
                sync[0] <= vio_sync[1:0];
                
                data_in[1] <= vio_data[63+(64*1):1*64];
                //sync[1] <= vio_sync[1+(2*1):1*2];
                sync[1] <= vio_sync[3:2];
                
                data_in[2] <= vio_data[63+(64*2):2*64];
                //sync[2] <= vio_sync[1+(2*2):2*2];
                sync[2] <= vio_sync[5:4];
                
                data_in[3] <= vio_data[63+(64*3):3*64];
                //sync[3] <= vio_sync[1+(2*3):3*2];
                //sync[3] <= vio_sync[1:0];
                sync[3] <= 2'b10;
            end
        end
        else begin
            cb_cnt <= cb_cnt + 1;
            if (cb_cnt == 12'hFFF) begin
                for (int i=0; i<num_lanes; i=i+1) begin
                    data_in[i] <= cb_char;
                    sync[i] <= 2'b10;
                end
            end
            else begin
                for (int i=0; i<num_lanes; i=i+1) begin
                    data_in[i] <= 64'hC0CA_C01A_CAFE_0000;
                    sync[i] <= 2'b01;
                end
            end
        end
    end
end

//==========================
//  Clock Generation MMCM
//==========================
// Internal clocks generated from incoming clk sent over SMA or VHDCI

//// Frequencies
//// clk640: 640 MHz
//// clk160: 160 MHz
//// clk40:  40  MHz

//clk_wiz_3 pll_fast(
//   .clk_in1_p(USER_SMA_CLOCK_P),
//   .clk_in1_n(USER_SMA_CLOCK_N),
//   .clk_out1(clk640),
//   .clk_out2(clk160),
//   .clk_out3(clk40),
//   .clk_out4(clk400),
//   .reset(rst_in),
//   .locked(mmcm_locked)
//);

// Frequencies
// clk640: 320 MHz
// clk160: 80  MHz
// clk40:  20  MHz
//
// WARNING: If this PLL is instantiated the clocks
// will run at slower frequencies, despite
// having names such as clk40, clk160, clk640.
clk_wiz_2 pll_mid_high(
   .clk_in1_p(USER_SMA_CLOCK_P),
   .clk_in1_n(USER_SMA_CLOCK_N),
   .clk_out1(clk640),
   .clk_out2(clk160),
   .clk_out3(clk40),
   .reset(rst_in),
   .locked(mmcm_locked)
);


//// Frequencies
//// clk640: 160 MHz
//// clk160: 40  MHz
//// clk40:  10  MHz
////
//// WARNING: If this PLL is instantiated the clocks
//// will run at slower frequencies, despite
//// having names such as clk40, clk160, clk640.
//clk_wiz_0 pll_mid(
//   .clk_in1_p(USER_SMA_CLOCK_P),
//   .clk_in1_n(USER_SMA_CLOCK_N),
//   .clk_out1(clk640),
//   .clk_out2(clk160),
//   .clk_out3(clk40),
//   .reset(rst_in),
//   .locked(mmcm_locked)
//);

//// Frequencies
//// clk640: 80 MHz
//// clk160: 20 MHz
//// clk40:  5  MHz
////
//// WARNING: If this PLL is instantiated the clocks
//// will run at slower frequencies, despite
//// having names such as clk40, clk160, clk640.
//wire clk160_ila;

//clk_wiz_1 pll_slow(
//   .clk_in1_p(USER_SMA_CLOCK_P),
//   .clk_in1_n(USER_SMA_CLOCK_N),
//   .clk_out1(clk640),
//   .clk_out2(clk160),
//   .clk_out3(clk40),
//   .clk_out4(clk160_ila),
//   .reset(rst_in),
//   .locked(mmcm_locked)
//);

//==========================
//        Aurora Tx
//==========================

// Creating four lanes so need to encapsulate Aurora Tx top.
genvar j;

generate
    for (j=0; j < num_lanes; j=j+1)
        begin : tx_core
            aurora_tx_top tx_lane (
                .rst(rst|vio_rst),
                .clk40(clk40),
                .clk160(clk160),
                .clk640(clk640),
                .data_in(data_in[j]),
                .sync(sync[j]),
                .gearbox_rdy(gearbox_rdy[j]),
                .data_next(data_next[j]),
                .data_out_p(data_out_p[j]),
                .data_out_n(data_out_n[j])
            );
    end
endgenerate

//============================================================================
//                       IO Buffer Configuration Driver
//============================================================================
reg [31:0] io_config;
reg start;
reg [3:0] io_rst_cnt;
wire [31:0] vio_io_config;
wire vio_start;
wire vio_io_en;

always @(posedge clk160) begin
    if (rst|vio_rst) begin
        io_config <= 32'h0000_0000;
        start <= 1'b0;
        io_rst_cnt <= 4'h0;
    end
    else begin
        if (vio_io_en) begin
            io_config <= vio_io_config;
            start <= vio_start; 
        end
        else begin
            if (io_rst_cnt <= 15) begin
                io_rst_cnt <= io_rst_cnt + 1;
            end
            
            if (io_rst_cnt == 10) begin
                start <= 1'b1;
            end
            else begin
                start <= 1'b0;
            end
            
            io_config <= 32'h0000_0000;
        end
    end
end

io_buf_config_driver io_buf_config(
    .rst(rst|vio_rst),
    .clk160(clk160),
    .io_config(io_config),
    .start(start),
    .latch(latch),
    .clk_io(clk_io),
    .ser_in(ser_in)
);

//============================================================================
//                          Debugging & Monitoring
//============================================================================

// ILA
ila_1 ila_slim (
    .clk(clk160),             // input wire clk
    //.clk(clk160_ila),
    .probe0(data_in),         // input wire [255:0] probe0  
    .probe1(mmcm_locked),     // input wire [0:0] probe1 
    .probe2(gearbox_rdy),     // input wire [0:0] probe2
    .probe3(sync)
);

vio_0 vio (
  .clk(clk40),
  //.clk(clk160_ila),
  .probe_out0(vio_rst),         // output wire [0:0]  probe_out0
  .probe_out1(vio_en),          // output wire [0:0]  probe_out1
  .probe_out2(vio_data),        // output wire [255:0] probe_out2
  .probe_out3(vio_en_counting), // output wire [0:0]  probe_out3
  .probe_out4(vio_sync),        // output wire [0:0]  probe_out4
  .probe_out5(vio_io_config),   // output wire [31:0]  probe_out5
  .probe_out6(vio_start),       // output wire [0:0]  probe_out6
  .probe_out7(vio_io_en)        // output wire [0:0]  probe_out7
);

endmodule
