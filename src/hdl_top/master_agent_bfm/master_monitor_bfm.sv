`ifndef MASTER_MONITOR_BFM_INCLUDED_
`define MASTER_MONITOR_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Inteface : Slave Monitor BFM
// Connects the slave monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

interface master_monitor_bfm ( sclk, cs, miso0, miso1, miso2, miso3,mosi0, mosi1, mosi2, mosi3);
  input sclk;
  input cs;
  input miso0;
  input miso1;
  input miso2;
  input miso3;
  input mosi0;
  input mosi1;
  input mosi2;
  input mosi3;


  import spi_master_pkg::master_monitor_proxy;
  
  //Variable : master_mon_proxy_h
  //Creating the handle for proxy driver
  master_monitor_proxy master_mon_proxy_h;
  
  
  initial begin
    $display("Master Monitor BFM");
  end

endinterface : master_monitor_bfm
`endif
