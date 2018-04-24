// Channel Bond
// Author: Lev Kurilenko
// Date: 11/29/2017
// Email: levkur@uw.edu
//
// Description:
// This module acts as the driver for the IO buffer
// configuration on the FMC card. Four 8-bit shift registers
// are daisy chained and drive the ENABLE pin on 8 IO buffers 
// per shift register. This gives a total of 32 output LVDS pairs.
// A serial stream of configuration data is shifted through the 
// registers and latched once the bits have arrived to their
// proper output locations.
//
//   ENABLE |   IO
// ---------+---------
//      0   |   IN
//      1   |   OUT
//
//
// Parts:
// Shift Register - SN74LV595APWT (http://www.ti.com/lit/ds/symlink/sn74lv595a.pdf)
// IO Buffer - FIN1101K8X (http://www.mouser.com/ds/2/149/FIN1101-1008606.pdf)
//

module io_buf_config_driver (
    input rst,
    input clk160,
    input [31:0] io_config,
    input start,
    
    output latch,
    output clk_io,
    output ser_in
);

// IO Buffer Driver Signals
reg [3:0] latch_reg;
reg [3:0] clk_io_reg;
reg [3:0] ser_in_reg;

reg [1:0] clk40_cnt;
reg [4:0] shift_in_cnt;

assign latch  = latch_reg [3];
assign clk_io = clk_io_reg[3];
assign ser_in = ser_in_reg[3];

always @(posedge clk160) begin
    if (rst) begin
        latch_reg <= 4'h0;
        clk_io_reg <= 4'h0;
        ser_in_reg <= 4'h0;
        clk40_cnt <= 2'b00;
        shift_in_cnt <= 5'hFF;
    end
    else begin
        clk40_cnt <= clk40_cnt + 1;
        ser_in_reg <= {ser_in_reg[2:0], io_config[shift_in_cnt]};
        latch_reg <= {latch_reg[2:0], 1'b0};
        
        // Conditional to reset the bit shifting sequence
        if (start) begin
            clk40_cnt <= 2'b00;
            shift_in_cnt <= 5'hFF;
        end
        else if (clk40_cnt == 2'b11) begin
            shift_in_cnt <= shift_in_cnt - 1;
        end
        
        // Conditional to generate 40 Mhz CLK
        if (clk40_cnt[1] == 0) begin
            clk_io_reg <= {clk_io_reg[2:0], 1'b0};
        end
        else begin
            clk_io_reg <= {clk_io_reg[2:0], 1'b1};
        end
        
        // Conditional to generate 40 Mhz Latch shifted 180 degrees from CLK
        if ((shift_in_cnt == 5'hFF) && (clk40_cnt[1] == 0)) begin
            latch_reg <= {latch_reg[2:0], 1'b1};
        end
    end
end

endmodule
