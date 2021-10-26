`ifndef MASTER_MONITOR_BFM_INCLUDED_
`define MASTER_MONITOR_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Inteface : Slave Monitor BFM
// Connects the slave monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

interface master_monitor_bfm (spi_if intf);

  import spi_master_pkg::master_monitor_proxy;

  //--------------------------------------------------------------------------------------------
  //Creating the handle for proxy driver
  //--------------------------------------------------------------------------------------------
  master_monitor_proxy master_mon_proxy_h;
  
  
  initial begin
    $display("Master Monitor BFM");
  end

endinterface : master_monitor_bfm
`endif
