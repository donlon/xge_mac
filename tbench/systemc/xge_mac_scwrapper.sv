module xge_mac_scwrapper(
    input  bit                   clk_156m25,
    input  bit                   clk_xgmii_rx,
    input  bit                   clk_xgmii_tx,
    input  bit                   pkt_rx_ren,
    input  longint unsigned      pkt_tx_data,
    input  bit                   pkt_tx_eop,
    input  int unsigned          pkt_tx_mod,  // bit [2:0]
    input  bit                   pkt_tx_sop,
    input  bit                   pkt_tx_val,
    input  bit                   reset_156m25_n,
    input  bit                   reset_xgmii_rx_n,
    input  bit                   reset_xgmii_tx_n,
    input  int unsigned          wb_adr_i,    // [7:0]
    input  bit                   wb_clk_i,
    input  bit                   wb_cyc_i,
    input  int unsigned          wb_dat_i,    // [31:0]
    input  bit                   wb_rst_i,
    input  bit                   wb_stb_i,
    input  bit                   wb_we_i,
    input  int unsigned          xgmii_rxc,   // [7:0]
    input  longint unsigned      xgmii_rxd,
    output bit                   pkt_rx_avail,
    output longint unsigned      pkt_rx_data,
    output bit                   pkt_rx_eop,
    output bit                   pkt_rx_err,
    output int unsigned          pkt_rx_mod,  // bit [2:0]
    output bit                   pkt_rx_sop,
    output bit                   pkt_rx_val,
    output bit                   pkt_tx_full,
    output bit                   wb_ack_o,
    output int unsigned          wb_dat_o,    // [31:0]
    output bit                   wb_int_o,
    output int unsigned          xgmii_txc,   // [7:0]
    output longint unsigned      xgmii_txd
);

bit [7:0] xgmii_txc_i;

xge_mac i_xge_mac (
    .clk_156m25(clk_156m25),
    .clk_xgmii_rx(clk_xgmii_rx),
    .clk_xgmii_tx(clk_xgmii_tx),
    .pkt_rx_ren(pkt_rx_ren),
    .pkt_tx_data(pkt_tx_data),
    .pkt_tx_eop(pkt_tx_eop),
    .pkt_tx_mod(pkt_tx_mod[2:0]),
    .pkt_tx_sop(pkt_tx_sop),
    .pkt_tx_val(pkt_tx_val),
    .reset_156m25_n(reset_156m25_n),
    .reset_xgmii_rx_n(reset_xgmii_rx_n),
    .reset_xgmii_tx_n(reset_xgmii_tx_n),
    .wb_adr_i(wb_adr_i[7:0]),
    .wb_clk_i(wb_clk_i),
    .wb_cyc_i(wb_cyc_i),
    .wb_dat_i(wb_dat_i[31:0]),
    .wb_rst_i(wb_rst_i),
    .wb_stb_i(wb_stb_i),
    .wb_we_i(wb_we_i),
    .xgmii_rxc(xgmii_rxc[7:0]),
    .xgmii_rxd(xgmii_rxd),
    .pkt_rx_avail(pkt_rx_avail),
    .pkt_rx_data(pkt_rx_data),
    .pkt_rx_eop(pkt_rx_eop),
    .pkt_rx_err(pkt_rx_err),
    .pkt_rx_mod(pkt_rx_mod[2:0]),
    .pkt_rx_sop(pkt_rx_sop),
    .pkt_rx_val(pkt_rx_val),
    .pkt_tx_full(pkt_tx_full),
    .wb_ack_o(wb_ack_o),
    .wb_dat_o(wb_dat_o[31:0]),
    .wb_int_o(wb_int_o),
    .xgmii_txc(xgmii_txc_i),
    .xgmii_txd(xgmii_txd)
);


assign xgmii_txc = {24'b0, xgmii_txc_i};
endmodule