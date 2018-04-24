// Engineer: Lev Kurilenko
// Date: 11/28/2017
// Email: levkur@uw.edu
//
// Module: Aurora Rx Top w/ Xilinx XAPP 1017 integrated

module aurora_rx_top_xapp (
    input rst,
    input clk40,
    input clk160,
    input clk640,
    
    input data_in_p,
    input data_in_n,
    
    input idelay_rdy,
    
    output blocksync_out,
    output gearbox_rdy,
    output data_valid,
    output reg [1:0]  sync_out,
    output [63:0] data_out
);

// ISERDES Signals
reg  [31:0] data32_iserdes;
wire [7:0]  sipo;

// Rx Gearbox Signals
wire [65:0] data66_gb_rx;
wire [1:0] sync_out_i;

// Block Sync Signals
wire        rxgearboxslip_out;

// Bit Error Rate Logic
reg [15:0] bit_err_cnt;
reg [15:0] bit_err_cnt_next;
reg [15:0] inv_data_cnt;
reg [63:0] data64_latched;
wire [63:0] data64_added;
reg latched_true;

// Bitslip FSM Signals
wire        iserdes_slip;
wire        gearbox_slip;

// Data Reception (8 bits to 32 bits)
always @(posedge clk160) begin
    if (rst) begin
        data32_iserdes <= 32'h0000_0000;
    end
    else begin
        data32_iserdes[31:24] <= sipo;
        data32_iserdes[23:16] <= data32_iserdes[31:24];
        data32_iserdes[15:8]  <= data32_iserdes[23:16];
        data32_iserdes[7:0]   <= data32_iserdes[15:8];
    end
end

// 2 Flip-Flop Synchronizer for Clock Domain Crossing
reg [31:0] data32_iserdes_r;
reg [31:0] data32_iserdes_r_r;

always @(posedge clk40) begin
    if (rst) begin
        data32_iserdes_r <= 32'h0000_0000;
        data32_iserdes_r_r <= 32'h0000_0000;
    end
    else begin
        data32_iserdes_r <= data32_iserdes;
        data32_iserdes_r_r <= data32_iserdes_r;
    end
end

// Delay sync_out by one 40 Mhz clock cycle to align with data_out
// Needed for proper channel bonding.
always @(posedge clk40) begin
    if (rst) begin
        sync_out <= 2'b00;
    end
    else begin
        sync_out <= sync_out_i;
    end
end

//========================= XAPP =========================

wire rx_lckd;
wire [28:0] debug;
//wire idelay_rdy;

// MAKE CLKIN_PERIOD and bit_rate_value input parameters

serdes_1_to_468_idelay_ddr #(
	.S			(8),				// Set the serdes factor (4, 6 or 8)
 	.HIGH_PERFORMANCE_MODE 	("TRUE"),
      	.D			(1),				// Number of data lines
      	//.REF_FREQ		(400.0),			// Set idelay control reference frequency, 300 MHz shown
      	.REF_FREQ		(300.0),			// Set idelay control reference frequency, 300 MHz shown
      	//.CLKIN_PERIOD		(1.5625),			// Set input clock period, 640 MHz shown
      	.CLKIN_PERIOD		(3.125),			// Set input clock period, 320 MHz shown
	.DATA_FORMAT 		("PER_CLOCK"))  		// PER_CLOCK or PER_CHANL data formatting
iserdes_inst (                      
	.clk160             (clk160),
    .clk640             (clk640),
	.datain_p     		(data_in_p),
	.datain_n     		(data_in_n),
	.enable_phase_detector	(1'b1),				// enable phase detector (active alignment) operation
	.enable_monitor		(1'b0),				// enables data eye monitoring
	.dcd_correct		(1'b0),				// enables clock duty cycle correction
	.rxclk    		(),
	.idelay_rdy		(idelay_rdy),
	.system_clk		(),
	.reset     		(rst),
	.rx_lckd		(rx_lckd),
	.bitslip  		(iserdes_slip),
	.rx_data		(sipo),
	//.bit_rate_value		(16'h1280),			// required bit rate value in BCD (1280 Mbps shown)
	.bit_rate_value		(16'h0640),			// required bit rate value in BCD (640 Mbps shown)
	.bit_time_value		(),				// bit time value
	.eye_info		(),				// data eye monitor per line
	.m_delay_1hot		(),				// sample point monitor per line
	.debug			(debug)) ;				// debug bus
    
//========================= XAPP =========================
    
gearbox32to66 rx_gb (
    .rst(rst),
    .clk(clk40),
    .data32(data32_iserdes_r_r),
    .gearbox_rdy(gearbox_rdy),
    .gearbox_slip(gearbox_slip),
    .data66(data66_gb_rx),
    .data_valid(data_valid)
);

descrambler uns (
    .clk(clk40),
    .rst(!blocksync_out|rst),
    .data_in(data66_gb_rx), 
    .sync_info(sync_out_i),
    .enable(blocksync_out&data_valid&gearbox_rdy),
    .data_out(data_out)
);

block_sync # (
    .SH_CNT_MAX(16'd400),           // default: 64
    .SH_INVALID_CNT_MAX(10'd16)     // default: 16
)
b_sync (
    .clk(clk40),
    .system_reset(rst),
    .blocksync_out(blocksync_out),
    .rxgearboxslip_out(rxgearboxslip_out),
    .rxheader_in(sync_out_i),
    .rxheadervalid_in(data_valid&gearbox_rdy)
);

bitslip_fsm bs_fsm (
    .clk(clk160),
    .rst(rst),
    .blocksync(blocksync_out),
    .rxgearboxslip(rxgearboxslip_out),
    .iserdes_slip(iserdes_slip),
    .gearbox_slip(gearbox_slip)
);

//============================================================================
//                           Bit Error Rate Logic
//                   May need to make this a seperate module
//============================================================================
always @(posedge clk40) begin
    if (rst) begin
        bit_err_cnt <= 16'h0000;
        inv_data_cnt <= 16'h0000;
        latched_true <= 1'b0;
        data64_latched <= 64'h0000_0000_0000_0000;
    end
    else if (latched_true == 0) begin
        bit_err_cnt <= bit_err_cnt_next;
        
        if (data_out == data64_latched + 1) begin
            latched_true <= 1'b1;
        end
        else if (blocksync_out&data_valid&gearbox_rdy) begin
            data64_latched <= data_out;
        end
    end
    else if (latched_true == 1) begin
        bit_err_cnt <= bit_err_cnt_next;
        
        //if ((blocksync_out&data_valid&gearbox_rdy)&&(data_out == data64_latched)) begin
        //    latched_true <= 1'b0;
        //    bit_err_cnt <= 16'h0000;
        //    inv_data_cnt <= 16'h0000;
        //end
        if ((blocksync_out&data_valid&gearbox_rdy)&&(data_out != data64_latched + 1)) begin
            inv_data_cnt <= inv_data_cnt + 1;
            //data64_latched <= data64_latched + 1;
        end
        
        if (blocksync_out&data_valid&gearbox_rdy) begin
            data64_latched <= data64_latched + 1;
        end
    end
end

assign data64_added = data64_latched + 1;
always @(*) begin
    bit_err_cnt_next = bit_err_cnt;
    if (rst) begin
        bit_err_cnt_next = 16'h0000;
    end
    else if (blocksync_out&latched_true&data_valid) begin
        for (int j = 0; j < 64; j = j + 1) begin
            //bit_err_cnt_next = bit_err_cnt + (data_out[j] != data64_added[j]);
            bit_err_cnt_next = bit_err_cnt_next + (data_out[j] != data64_added[j]);
        end
    end
end

endmodule
