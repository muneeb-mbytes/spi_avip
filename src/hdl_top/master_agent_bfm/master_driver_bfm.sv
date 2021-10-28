`ifndef MASTER_DRIVER_BFM_INCLUDED_
`define MASTER_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
//Interface : master_driver_bfm
//Used as the HDL driver for SPI
//It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------

interface master_driver_bfm(sclk, cs, miso0, miso1, miso2, miso3, mosi0, mosi1, mosi2, mosi3 );
  
  input sclk;
  input cs;
  input miso0;
  input miso1;
  input miso2;
  input miso3;
  output reg mosi0;
  output reg mosi1;
  output reg mosi2;
  output reg mosi3;
 
  import spi_master_pkg::master_driver_proxy;

  //--------------------------------------------------------------------------------------------
  // Creating handle for virtual Interface
  //--------------------------------------------------------------------------------------------
  // virtual spi_if v_intf;
 
  //Variable : master_driver_proxy_h
  //Creating the handle for proxy driver
  master_driver_proxy master_drv_proxy_h;

  initial begin
    $display("Master driver BFM");
  end

endinterface : master_driver_bfm
`endif
