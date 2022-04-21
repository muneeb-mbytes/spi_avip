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
  
  //-------------------------------------------------------
  // Importing Uvm Package
  //-------------------------------------------------------
  import spi_globals_pkg::*;

  //-------------------------------------------------------
  // Master Driver bfm instantiation
  //-------------------------------------------------------
  master_driver_bfm master_drv_bfm_h (.pclk(intf.pclk), 
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
  // Master monitor  bfm instantiation
  //-------------------------------------------------------
  master_monitor_bfm master_mon_bfm_h (.pclk(intf.pclk), 
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
  // Binding Master monitor bfm with Master assertions and instantiation of handle
  //-------------------------------------------------------
  bind master_monitor_bfm master_assertions master_assertion_h (.pclk(pclk),
                                                                .cs(cs),
                                                                .areset(areset),
                                                                .sclk(sclk),
                                                                .mosi0(mosi0),
                                                                .mosi1(mosi1),
                                                                .mosi2(mosi2),
                                                                .mosi3(mosi3),
                                                                .miso0(miso0),
                                                                .miso1(miso1),
                                                                .miso2(miso2),
                                                                .miso3(miso3)
                                                              );

  //-------------------------------------------------------
  // Setting the virtual handle of BMFs into config_db
  //-------------------------------------------------------
  initial begin
    uvm_config_db#(virtual master_driver_bfm)::set(null,"*", "master_driver_bfm", master_drv_bfm_h); 
    uvm_config_db#(virtual master_monitor_bfm)::set(null,"*", "master_monitor_bfm", master_mon_bfm_h);
  end
  
  initial begin
    $display("Master Agent BFM");
  end
   
endmodule : master_agent_bfm

`endif

