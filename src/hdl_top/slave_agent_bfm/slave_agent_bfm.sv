`ifndef SLAVE_AGENT_BFM_INCLUDED_
`define SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : Slave Agent BFM 
//  This module is used as the configuration class for slave agent bfm and its components
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


  if (SLAVE_DRIVER_ACTIVE == 1) begin
  //-------------------------------------------------------
  // Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_driver_bfm s_drv_bfm_h (.sclk(intf.sclk),
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
  end


  //-------------------------------------------------------
  // Slave monitor bfm instantiation
  //-------------------------------------------------------
  slave_monitor_bfm slave_monitor_bfm_h (.sclk(intf.sclk),
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
    if (SLAVE_DRIVER_ACTIVE == 1) begin
    uvm_config_db#(virtual slave_driver_bfm)::set(null,"*", "slave_driver_bfm", s_drv_bfm_h); 
  end
    uvm_config_db#(virtual slave_monitor_bfm)::set(null,"*", "slave_monitor_bfm", slave_monitor_bfm_h); 
  end

  initial begin
    $display("Slave Agent BFM");
    $display("Slave_driver_active=%0d", SLAVE_DRIVER_ACTIVE);
  end

endmodule : slave_agent_bfm

`endif
