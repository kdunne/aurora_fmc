// Based on fmc_four_lane_io_buf_640
// Engineer: Lev Kurilenko
// Date: June 2018
//
// Module: Aurora FMC Top

module aurora_fmc_top (
    input rst,
    input clk40,
    input clk160,
    input clk640,
    
    // Rx signals
    input data_in_p,
    input data_in_n,

    output blocksync_out,
    output gearbox_rdy,
    output data_valid,
    output reg [1:0]  sync_out,
    output [63:0] data_out,

    // Tx signals
    input[63:0] data_in,
    input[1:0] sync,

    output gearbox_rdy_tx,
    output data_next,
    output data_out_p,
    output data_out_n

);

// Scrambler Signals
wire [65:0] data66_tx_sr;

// OSERDES Signals
wire [7:0] piso;
reg [63:0] tx_buffer;
reg [2:0] tx_buf_cnt;

// ISERDES Signals
reg  [31:0] data32_iserdes;
wire [7:0]  sipo;

// Tx Gearbox Signals
wire [31:0] data32_gb_tx;
wire	    data_next; 		// Redeclaration. May ned to get rid of it. 

// Rx Gearbox Signals
wire [65:0] data66_gb_rx;
wire [1:0] sync_out_i;

// Block Sync Signals
wire        rxgearboxslip_out;

// Serializer 32 to 8 bits
always @(posedge clk160) begin
    if (rst) begin
        tx_buf_cnt <= 3'h0;
    end
    else begin
        tx_buf_cnt <= tx_buf_cnt + 1;
        
        if ((tx_buf_cnt == 0) || (tx_buf_cnt == 4)) begin
            tx_buffer <= {data32_gb_tx, tx_buffer[39:8]};
        end
        else begin
            tx_buffer <= {8'h00, tx_buffer >> 8};
        end
    end
end

assign piso = tx_buffer[7:0];

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


//==================
// Aurora Tx
//==================

// Scrambler
scrambler scr (
    .clk(clk40),
    .rst(rst),
    .data_in(data_in),
    .sync_info(sync),
    .enable(data_next&gearbox_rdy),
    .data_out(data66_tx_scr)
);

// Tx Gearbox
gearbox66to32 tx_gb (
    .rst(rst),
    .clk(clk40),
    .data66(data66_tx_scr),
    //.data66({sync, data_in}),		// Use this to bypass Scrambler
    .gearbox_rdy(gearbox_rdy_tx),
    .data32(data32_gb_tx),
    .data_next(data_next)
);

// OSERDES Interface
cmd_oserdes piso0_1280(
  .io_reset(rst),
  .data_in_to_device(piso),
  .data_in_from_pins_p(data_out_p),
  .data_in_from_pins_n(data_out_n),
  .clk_in(clk640),
  .clk_out(clk160)
);

//===================
// Aurora Rx
//===================

// ISERDES Interface
//cmd_iserdes i0 (
//    .data_in_from_pins_p(data_in_p),
//    .data_in_from_pins_n(data_in_n),
//    .clk_in(clk640),
//    .clk_div_in(clk160),
//    .io_reset(rst),
//    .bitslip(iserdes_slip),
//    .data_in_to_device(sipo)
//);


// Rx Gearbox
gearbox32to66 rx_gb (
    .rst(rst),
    .clk(clk40),
    .data32(data32_iserdes_r_r),
    .gearbox_rdy(gearbox_rdy),
    .gearbox_slip(gearbox_slip),
    .data66(data66_gb_rx),
    .data_valid(data_valid)
);

// Descrambler
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
