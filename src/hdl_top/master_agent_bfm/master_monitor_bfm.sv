`ifndef MASTER_MONITOR_BFM_INCLUDED_
`define MASTER_MONITOR_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Inteface : Slave Monitor BFM
// Connects the slave monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------
import spi_globals_pkg::*;
interface master_monitor_bfm(input pclk, input areset, 
                             input sclk, 
                             input [NO_OF_SLAVES-1:0] cs, 
                             input mosi0, mosi1, mosi2, mosi3,
                             input miso0, miso1, miso2, miso3);

  import spi_master_pkg::master_monitor_proxy;
  
  //Variable : master_mon_proxy_h
  //Creating the handle for proxy driver
  master_monitor_proxy master_mon_proxy_h;
  
  initial begin
    $display("Master Monitor BFM");
  end

endinterface : master_monitor_bfm
`endif
