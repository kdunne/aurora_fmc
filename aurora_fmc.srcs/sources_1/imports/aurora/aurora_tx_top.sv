// Engineer: Lev Kurilenko
// Date: 8/22/2017
// Email: levkur@uw.edu
//
// Module: Aurora Tx Top

module aurora_tx_top (
    input rst,
    input clk40,
    input clk160,
    input clk640,
    
    input [63:0] data_in,
    input [1:0]  sync,
    output gearbox_rdy,
    output data_next,
    output data_out_p,
    output data_out_n
);

// Tx Gearbox Signals
wire [31:0] data32_gb_tx;
wire        data_next;      // Redeclaration. May need to get rid of it. Perform tests first.

// Scrambler Signals
wire [65:0] data66_tx_scr;

// OSERDES Signals
wire [7:0]  piso;
reg  [63:0] tx_buffer;
reg  [2:0]  tx_buf_cnt;

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

// wire rst_serdes;
// reg shift_rst[3];
// 
// always @(posedge clk40) begin
//     shift_rst[0] <= rst;
//     shift_rst[1] <= shift_rst[0];
//     shift_rst[2] <= shift_rst[1];
// end
// 
// assign rst_serdes = shift_rst[2];

//==========================
//        Aurora Tx
//==========================

// Scrambler
scrambler scr (
    .clk(clk40),
    .rst(rst),
    .data_in(data_in),
    .sync_info(sync),
    .enable(data_next&gearbox_rdy),
    .data_out(data66_tx_scr)
);

// Gearbox
gearbox66to32 tx_gb (
    .rst(rst),
    .clk(clk40),
    .data66(data66_tx_scr),
    //.data66({sync, data_in}),     // Use this to bypass Scrambler
    .gearbox_rdy(gearbox_rdy),
    .data32(data32_gb_tx),
    .data_next(data_next)
);

//OSERDES Interface
//cmd_oserdes piso0_1280(
//   .io_reset(rst),
// .data_out_from_device(piso),
// .data_out_to_pins_p(data_out_p),
// .data_out_to_pins_n(data_out_n),
// .clk_in(clk640),
// .clk_div_in(clk160)
//

endmodule
