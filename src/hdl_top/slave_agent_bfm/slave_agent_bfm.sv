`ifndef SLAVE_AGENT_BFM_INCLUDED_
`define SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : Slave Agent BFM
// Contains Slave driver bfm and slave monitor bfm interfaces
//--------------------------------------------------------------------------------------------
module slave_agent_bfm(spi_if intf);
 
  //import uvm_pkg::*;
  
  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_driver_bfm slave_driver_bfm_h (intf.SLV_DRV_MP, intf.MON_MP);

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_monitor_bfm slave_monitor_bfm_h (intf.MON_MP);


  //-------------------------------------------------------
  // Setting Slave_moitor_bfm interface in config db
  //-------------------------------------------------------
  initial begin
    $display("Slave Agent BFM");
    //uvm_config_db #(slave_monitor_bfm)::set(null,"*","slave_monitor_bfm",slave_monitor_bfm);
  end


endmodule : slave_agent_bfm

`endif
