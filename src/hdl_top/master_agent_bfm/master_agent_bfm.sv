<<<<<<< HEAD
`ifndef MASTER_AGENT_BFM_INCLUDED_
`define MASTER_AGENT_BFM_INCLUDED_

  //--------------------------------------------------------------------------------------------
  // Module : Master_agent_bfm
  // Description : Instantiate driver and monitor
  //--------------------------------------------------------------------------------------------
=======
 `include "master_drv.sv"
 `include "master_mon.sv"
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

  module master_agent_bfm(spi_if intf);

   initial
   begin
      $display("Master Agent BFM");
   end
<<<<<<< HEAD
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
=======
   
   master_drv master_drv_h(intf);
   master_mon master_mon_h(intf);

  endmodule
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
