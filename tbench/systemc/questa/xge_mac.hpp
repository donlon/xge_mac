#ifndef __SCGENMOD_xge_mac_scwrapper__
#define __SCGENMOD_xge_mac_scwrapper__

#include "systemc.h"

class xge_mac_sc_wrapper : public sc_foreign_module {
public:
    sc_in<bool> clk_156m25;
    sc_in<bool> clk_xgmii_rx;
    sc_in<bool> clk_xgmii_tx;
    sc_in<bool> pkt_rx_ren;
    sc_in<unsigned long long> pkt_tx_data;
    sc_in<bool> pkt_tx_eop;
    sc_in<unsigned int> pkt_tx_mod;
    sc_in<bool> pkt_tx_sop;
    sc_in<bool> pkt_tx_val;
    sc_in<bool> reset_156m25_n;
    sc_in<bool> reset_xgmii_rx_n;
    sc_in<bool> reset_xgmii_tx_n;
    sc_in<unsigned int> wb_adr_i;
    sc_in<bool> wb_clk_i;
    sc_in<bool> wb_cyc_i;
    sc_in<unsigned int> wb_dat_i;
    sc_in<bool> wb_rst_i;
    sc_in<bool> wb_stb_i;
    sc_in<bool> wb_we_i;
    sc_in<unsigned int> xgmii_rxc;
    sc_in<unsigned long long> xgmii_rxd;
    sc_out<bool> pkt_rx_avail;
    sc_out<unsigned long long> pkt_rx_data;
    sc_out<bool> pkt_rx_eop;
    sc_out<bool> pkt_rx_err;
    sc_out<unsigned int> pkt_rx_mod;
    sc_out<bool> pkt_rx_sop;
    sc_out<bool> pkt_rx_val;
    sc_out<bool> pkt_tx_full;
    sc_out<bool> wb_ack_o;
    sc_out<unsigned int> wb_dat_o;
    sc_out<bool> wb_int_o;
    sc_out<unsigned int> xgmii_txc;
    sc_out<unsigned long long> xgmii_txd;

    xge_mac_sc_wrapper(const sc_module_name& nm, const char *hdl_name)
            : sc_foreign_module(nm),
              clk_156m25("clk_156m25"),
              clk_xgmii_rx("clk_xgmii_rx"),
              clk_xgmii_tx("clk_xgmii_tx"),
              pkt_rx_ren("pkt_rx_ren"),
              pkt_tx_data("pkt_tx_data"),
              pkt_tx_eop("pkt_tx_eop"),
              pkt_tx_mod("pkt_tx_mod"),
              pkt_tx_sop("pkt_tx_sop"),
              pkt_tx_val("pkt_tx_val"),
              reset_156m25_n("reset_156m25_n"),
              reset_xgmii_rx_n("reset_xgmii_rx_n"),
              reset_xgmii_tx_n("reset_xgmii_tx_n"),
              wb_adr_i("wb_adr_i"),
              wb_clk_i("wb_clk_i"),
              wb_cyc_i("wb_cyc_i"),
              wb_dat_i("wb_dat_i"),
              wb_rst_i("wb_rst_i"),
              wb_stb_i("wb_stb_i"),
              wb_we_i("wb_we_i"),
              xgmii_rxc("xgmii_rxc"),
              xgmii_rxd("xgmii_rxd"),
              pkt_rx_avail("pkt_rx_avail"),
              pkt_rx_data("pkt_rx_data"),
              pkt_rx_eop("pkt_rx_eop"),
              pkt_rx_err("pkt_rx_err"),
              pkt_rx_mod("pkt_rx_mod"),
              pkt_rx_sop("pkt_rx_sop"),
              pkt_rx_val("pkt_rx_val"),
              pkt_tx_full("pkt_tx_full"),
              wb_ack_o("wb_ack_o"),
              wb_dat_o("wb_dat_o"),
              wb_int_o("wb_int_o"),
              xgmii_txc("xgmii_txc"),
              xgmii_txd("xgmii_txd") {
        elaborate_foreign_module(hdl_name);
    }

    ~xge_mac_sc_wrapper() override = default;

};

#endif
