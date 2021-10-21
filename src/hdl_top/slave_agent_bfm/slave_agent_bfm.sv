<<<<<<< HEAD
`ifndef SLAVE_AGENT_BFM_INCLUDED_
`define SLAVE_AGENT_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : Slave Agent BFM
// TODO(mshariff): 
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------
=======
//--------------------------------------------------------------------------------------------
// Module      : Slave Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

//-------------------------------------------------------
// Making a copy of the bfm files using `include
//-------------------------------------------------------
`include "slave_driver_bfm.sv"
`include "slave_monitor_bfm.sv"

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
module slave_agent_bfm(spi_if intf);
  
  initial begin
    $display("Slave Agent BFM");
  end

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
<<<<<<< HEAD
  slave_driver_bfm slave_driver_bfm_h (intf.SLV_DRV_MP, intf.MON_MP);
=======
  slave_driver_bfm slave_driver_bfm_h(intf);
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
<<<<<<< HEAD
  slave_monitor_bfm slave_monitor_bfm_h (intf.MON_MP);

endmodule : slave_agent_bfm

`endif
=======
  slave_monitor_bfm slave_monitor_bfm_h(intf);

endmodule : slave_agent_bfm
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
