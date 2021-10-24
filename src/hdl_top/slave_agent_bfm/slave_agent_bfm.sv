`ifndef SLAVE_AGENT_BFM_INCLUDED_
`define SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : Slave Agent BFM 
//  This module is used as the configuration class for slave agent bfm and its components
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
  slave_driver_bfm s_drv_bfm_h (intf.SLV_DRV_MP, intf.MON_MP);

  //-------------------------------------------------------
  // Slave monitor bfm instantiation
  //-------------------------------------------------------
  slave_monitor_bfm slave_monitor_bfm_h (intf.MON_MP);

  //-------------------------------------------------------
  // Setting Slave_driver_bfm and monitor_bfm
  //-------------------------------------------------------
  initial begin
    uvm_config_db#(virtual slave_driver_bfm)::set(null,"*", "slave_driver_bfm", s_drv_bfm_h); 
    uvm_config_db#(virtual slave_monitor_bfm)::set(null,"*", "slave_monitor_bfm", slave_monitor_bfm_h); 
  end

  initial begin
    $display("Slave Agent BFM");
  end

endmodule : slave_agent_bfm

`endif
