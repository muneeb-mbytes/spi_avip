`ifndef SLAVE_AGENT_BFM_INCLUDED_
`define SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module : Slave Agent BFM 
// This module is used as the configuration class for slave agent bfm and its components
//--------------------------------------------------------------------------------------------
module slave_agent_bfm(spi_if intf);

  //-------------------------------------------------------
  // Package : Importing Uvm Package and Test Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //-------------------------------------------------------
  // Package : Importing SPI Global Package 
  //-------------------------------------------------------
  import spi_globals_pkg::*;

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  //uvm_active_passive_enum is_active;  

  //-------------------------------------------------------
  // Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_driver_bfm slave_drv_bfm_h (.pclk(intf.pclk),
                                    .cs(intf.cs),
                                    .areset(intf.areset),
                                    .sclk(intf.sclk),
                                    .mosi0(intf.mosi0),
                                    .mosi1(intf.mosi1),
                                    .mosi2(intf.mosi2),
                                    .mosi3(intf.mosi3),
                                    .miso0(intf.miso0),
                                    .miso1(intf.miso1),
                                    .miso2(intf.miso2),
                                    .miso3(intf.miso3)
                                   );

  //-------------------------------------------------------
  // Slave monitor bfm instantiation
  //-------------------------------------------------------
  slave_monitor_bfm slave_mon_bfm_h (.pclk(intf.pclk),
                                     .areset(intf.areset),
                                     .sclk(intf.sclk),
                                     .cs(intf.cs),
                                     .mosi0(intf.mosi0),
                                     .mosi1(intf.mosi1),
                                     .mosi2(intf.mosi2),
                                     .mosi3(intf.mosi3),
                                     .miso0(intf.miso0),
                                     .miso1(intf.miso1),
                                     .miso2(intf.miso2),
                                     .miso3(intf.miso3)
                                    );

  //-------------------------------------------------------
  // Setting Slave_driver_bfm and monitor_bfm
  //-------------------------------------------------------
  initial begin

//  if (SLAVE_AGENT_ACTIVE == 1'b1) begin
//    slave_agent_bfm_h.is_active = UVM_ACTIVE;
    //if(slave_agent_bfm_h.is_active == UVM_ACTIVE) 
      uvm_config_db#(virtual slave_driver_bfm)::set(null,"*", "slave_driver_bfm", slave_drv_bfm_h); 
//    end

//  else if (SLAVE_AGENT_ACTIVE == 1'b0) begin
//    slave_agent_bfm_h.is_active = UVM_PASSIVE;
    //else if(slave_agent_bfm_h.is_active == UVM_PASSIVE)
      uvm_config_db #(virtual slave_monitor_bfm)::set(null,"*", "slave_monitor_bfm", slave_mon_bfm_h); 
//    end

  end

  initial begin
    $display("Slave Agent BFM");
  end

endmodule : slave_agent_bfm

`endif
