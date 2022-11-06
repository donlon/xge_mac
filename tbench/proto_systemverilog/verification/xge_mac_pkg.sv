package xge_mac_pkg;

   typedef enum { NONE, TRANSMIT, RECEIVE } typeOfPkt;

   typedef struct packed { 
      bit          startOfPacket;
      bit [63:0]   frame;
      bit          endOfPacket;
      bit [2:0]    packetModulus;
   } packetFrame;

   `include "packet.svh"
   `include "driver.svh"
   `include "monitor.svh"
   `include "scoreboard.svh"
   `include "env.svh"
endpackage : xge_mac_pkg