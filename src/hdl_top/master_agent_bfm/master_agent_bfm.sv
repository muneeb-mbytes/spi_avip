`ifndef MASTER_AGENT_BFM_INCLUDED_
`define MASTER_AGENT_BFM_INCLUDED_

  //--------------------------------------------------------------------------------------------
  // Module : Master_agent_bfm
  // Description : Instantiate driver and monitor
  //--------------------------------------------------------------------------------------------

  module master_agent_bfm(spi_if intf);

   initial
   begin
      $display("Master Agent BFM");
   end
  //--------------------------------------------------------------------------------------------
  // Master Driver bfm 
  //--------------------------------------------------------------------------------------------
   master_driver_bfm master_driver_bfm_h(intf.MON_DRV_MP,intf.MON_MP);
  
  //--------------------------------------------------------------------------------------------
  // Master Monitor bfm
  //--------------------------------------------------------------------------------------------
   master_monitor_bfm master_monitor_bfm_h(intf.MON_MP);

  endmodule : master_agent_bfm

`endif
