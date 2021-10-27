`ifndef SLAVE_AGENT_BFM_INCLUDED_
`define SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module : Slave Agent BFM 
// This module is used as the configuration class for slave agent bfm and its components
//--------------------------------------------------------------------------------------------
module slave_agent_bfm(spi_if intf);

  //-------------------------------------------------------
  // Package : Importing Uvm Pakckage and Test Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //-------------------------------------------------------
  // Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_driver_bfm slave_drv_bfm_h (.sclk(intf.sclk),.cs(intf.cs),.mosi0(intf.mosi0),
              .mosi1(intf.mosi1),.mosi2(intf.mosi2),.mosi3(intf.mosi3),.miso0(intf.miso0),
              .miso1(intf.miso1),.miso2(intf.miso2),.miso3(intf.miso3));
  //slave_driver_bfm slave_drv_bfm_h (intf);
  
  //-------------------------------------------------------
  // Slave monitor bfm instantiation
  //-------------------------------------------------------
  slave_monitor_bfm slave_mon_bfm_h (.sclk(intf.sclk),.cs(intf.cs),.mosi0(intf.mosi0),
              .mosi1(intf.mosi1),.mosi2(intf.mosi2),.mosi3(intf.mosi3),.miso0(intf.miso0),
              .miso1(intf.miso1),.miso2(intf.miso2),.miso3(intf.miso3));
  
  //slave_monitor_bfm slave_mon_bfm_h (intf);
   
  //slave_monitor_bfm slave_mon_bfm_h (sclk,cs,mosi0,mosi1,mosi2,mosi3, miso0, miso1,miso2,miso3 );
 // slave_monitor_bfm slave_mon_bfm_h (intf.sclk, intf.cs, intf.mosi0, intf.mosi1, intf.mosi2, intf.mosi3 );
  //-------------------------------------------------------
  // Setting Slave_driver_bfm and monitor_bfm
  //-------------------------------------------------------
  initial begin
    uvm_config_db#(virtual slave_driver_bfm)::set(null,"*", "slave_driver_bfm", slave_drv_bfm_h); 
    uvm_config_db#(virtual slave_monitor_bfm)::set(null,"*", "slave_monitor_bfm", slave_mon_bfm_h); 
  end

  initial begin
    $display("Slave Agent BFM");
    
  end

endmodule : slave_agent_bfm

`endif
