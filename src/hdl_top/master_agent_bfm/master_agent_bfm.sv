// `include "master_drv.sv"
// `include "master_mon.sv"
`ifndef MASTER_AGENT_BFM_INCLUDED_
`define MASTER_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module: Master Agent BFM
// This module is used as the configuration class for master agent bfm and its components
//--------------------------------------------------------------------------------------------
module master_agent_bfm(spi_if intf);

  //-------------------------------------------------------
  // Package : Importing Uvm Pakckage and Test Package
  //-------------------------------------------------------
   import uvm_pkg::*;
   `include "uvm_macros.svh"
  
  //--------------------------------------------------------------------------------------------
  // Master Driver bfm instantiation
  //--------------------------------------------------------------------------------------------
  master_driver_bfm master_drv_bfm_h (.sclk(intf.sclk),.cs(intf.cs),.mosi(intf.mosi),.miso(intf.miso));
 
   
  //--------------------------------------------------------------------------------------------
  // Master monitor  bfm instantiation
  //--------------------------------------------------------------------------------------------
  master_monitor_bfm master_mon_bfm_h (.sclk(intf.sclk),.mosi(intf.mosi));

  initial begin
    uvm_config_db#(virtual master_driver_bfm)::set(null,"*", "master_driver_bfm", master_drv_bfm_h); 
    uvm_config_db#(virtual master_monitor_bfm)::set(null,"*", "master_monitor_bfm", master_mon_bfm_h);
  end

  
  initial begin
    $display("Master Agent BFM");
  end
   
  //master_drv master_drv_h(intf);
  //master_mon master_mon_h(intf);

endmodule : master_agent_bfm
`endif
