// Channel Bond
// Author: Lev Kurilenko
// Date: 8/23/2017
// Email: levkur@uw.edu

// Description:
// In a multi-lane configuration
// this module will use an elastic buffer
// to "bond" all lanes, meaning data arrives on
// each lane at the same time. This compensates for
// cable mismatches between lanes and
// other phenomenon.

module channel_bond (
    input rst,
    input clk40,
    
    input [63:0] data_in[4],
    input [1:0]  sync_in[4],
    input [3:0]  blocksync_out,
    input [3:0]  gearbox_rdy_rx,
    input [3:0]  data_valid,
    
    output [63:0] data_out_cb[4],
    output [1:0]  sync_out_cb[4],
    output data_valid_cb,
    output channel_bonded
);

localparam cb_char = 64'h7800_0000_0000_0040;   // From Memory may need to be changed

// FIFO Signals
reg  [3:0] rd_en;
wire full[4];
wire empty[4];
reg fifo_rst;           // Signal used to reset FIFO if it becomes full.
reg [1:0] fifo_rst_cnt; // Counter used to control the duration of a reset.
reg [2:0] init_cnt;     // Counter incremented after a reset event is finished. Used for initialization after a reset.

// Signal used to enable writing to FIFO's. Goes low if FIFO is being reset 
// and makes sure the FIFO is not written to during reset.
// This avoids unexpected behavior. Recommened in the Xilinx FIFO manual.
reg wr_en_rst;

//assign fifo_rst = !rst&(full[0]|full[1]|full[2]|full[3]);

always @(posedge clk40) begin
    if (rst) begin
        fifo_rst <= 1'b0;
        fifo_rst_cnt <= 2'b00;
        init_cnt <= 3'b000;
        wr_en_rst <= 1'b0;
    end
    else begin
        if (init_cnt < 6) begin
            init_cnt <= init_cnt + 1;
            wr_en_rst <= 1'b1;
        end
        else begin
            fifo_rst_cnt <= fifo_rst_cnt + 1;
            if (fifo_rst&&(fifo_rst_cnt == 3)) begin
                fifo_rst <= 1'b0;
                init_cnt <= 3'b000;
            end
            else if (!fifo_rst&(full[0]|full[1]|full[2]|full[3])) begin
                wr_en_rst <= 1'b0;
                fifo_rst <= 1'b1;
                fifo_rst_cnt <= 2'b00;
            end
        end
    end
end

// Channel Bonding Signals
reg [3:0] cb_detect;

// Data valid signal assigned to read enable
assign data_valid_cb = &rd_en;

assign channel_bonded = ((blocksync_out == 4'hF) && (cb_detect == 4'hF));

always @(posedge clk40) begin
    if (rst) begin
        cb_detect <= 4'h0;
    end
    else if (blocksync_out == 4'hF) begin
        if (data_valid_cb && (cb_detect == 4'hF) &&
            ((data_out_cb[0] == cb_char)||(data_out_cb[1] == cb_char)||(data_out_cb[2] == cb_char)||(data_out_cb[3] == cb_char)) &&
            // May need to change this to make it account for sync headers as well.
            ((data_out_cb[0][63:0] != data_out_cb[1][63:0])||(data_out_cb[0][63:0] != data_out_cb[2][63:0])||(data_out_cb[0][63:0] != data_out_cb[3][63:0]))) begin
            cb_detect <= 4'h0;
        end
        else begin
            for (int j=0; j<4; j=j+1) begin
                if (({sync_out_cb[j], data_out_cb[j]} == {2'b10, cb_char}) && (cb_detect != 4'hF) && gearbox_rdy_rx[j] && data_valid[j]) begin
                    cb_detect[j] <= 1'b1;
                end
            end
        end
    end
end

// Add FIFO full logic

always @(*) begin
    rd_en = 4'h0;
    // Channel Bonding Loop
    if (rst) begin
        rd_en = 4'h0;
    end
    else if (fifo_rst) begin
        // If FIFO is being reset, make sure you aren't trying to read.
        // Reading can cause unexpected behavior, as documented in Xilinx FIFO Manual.
        rd_en = 4'h0;
    end
    else begin
        for (int j=0; j<4; j=j+1) begin
            // FIFO Read Logic
            // Check if FIFO is empty
            if (empty[j]) begin
                if (cb_detect == 4'hF) begin
                    for (int k=0; k<4; k=k+1) begin
                        rd_en[k] = 1'b0;
                    end
                    break;
                end
                else begin
                    rd_en[j] = 1'b0;
                end
            end
            else if ((cb_detect[j] == 1) && (cb_detect != 4'hF)) begin
                rd_en[j] = 1'b0;
            end
            else if (!data_valid[j]) begin
                rd_en[j] = 1'b1;
            end
            else begin
                rd_en[j] = 1'b0;
            end
        end
    end
end

//============================================================================
//                            Module Instantiation
//============================================================================

fifo_fwft fifo_0 (
  .clk(clk40),
  .rst(rst|fifo_rst),
  .din({sync_in[0], data_in[0]}),
  .wr_en(gearbox_rdy_rx[0]&data_valid[0]&wr_en_rst),
  .rd_en(rd_en[0]),
  .dout({sync_out_cb[0], data_out_cb[0]}),
  .full(full[0]),
  .empty(empty[0])
);

fifo_fwft fifo_1 (
  .clk(clk40),
  .rst(rst|fifo_rst),
  .din({sync_in[1], data_in[1]}),
  .wr_en(gearbox_rdy_rx[1]&data_valid[1]&wr_en_rst),
  .rd_en(rd_en[1]),
  .dout({sync_out_cb[1], data_out_cb[1]}),
  .full(full[1]),
  .empty(empty[1])
);

fifo_fwft fifo_2 (
  .clk(clk40),
  .rst(rst|fifo_rst),
  .din({sync_in[2], data_in[2]}),
  .wr_en(gearbox_rdy_rx[2]&data_valid[2]&wr_en_rst),
  .rd_en(rd_en[2]),
  .dout({sync_out_cb[2], data_out_cb[2]}),
  .full(full[2]),
  .empty(empty[2])
);

fifo_fwft fifo_3 (
  .clk(clk40),
  .rst(rst|fifo_rst),
  .din({sync_in[3], data_in[3]}),
  .wr_en(gearbox_rdy_rx[3]&data_valid[3]&wr_en_rst),
  .rd_en(rd_en[3]),
  .dout({sync_out_cb[3], data_out_cb[3]}),
  .full(full[3]),
  .empty(empty[3])
);

endmodule
