 `include "master_drv.sv"
 `include "master_mon.sv"

  module master_agent_bfm(spi_if intf);

   initial
   begin
      $display("Master Agent BFM");
   end
   
   master_drv master_drv_h(intf);
   master_mon master_mon_h(intf);

  endmodule
