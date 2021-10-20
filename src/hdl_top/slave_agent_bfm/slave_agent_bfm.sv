`ifndef SLAVE_AGENT_BFM_INCLUDED_
`define SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : Slave Agent BFM 
//  This module is used as the configuration class for slave agent bfm and its components
//--------------------------------------------------------------------------------------------
module slave_agent_bfm(spi_if intf);
  
  initial begin
    $display("Slave Agent BFM");
  end

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_driver_bfm slave_driver_bfm_h (intf.SLV_DRV_MP, intf.MON_MP);

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_monitor_bfm slave_monitor_bfm_h (intf.MON_MP);

endmodule : slave_agent_bfm

`endif
