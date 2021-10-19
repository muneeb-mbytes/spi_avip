//--------------------------------------------------------------------------------------------
// Module       : Interface
// Description  : Declaration of pin level signals as logic
//--------------------------------------------------------------------------------------------
interface spi_if();

  logic clk;
  logic rst;
  logic sclk;
  logic cs;
   
  //master out slave in
  logic mosi;
  logic mosi1;
  logic mosi2;
  logic mosi3;  
             
  //master in slave out
  logic miso;
  logic miso1;
  logic miso2;
  logic miso3;

//-------------------------------------------------------
// Slave Interface
//-------------------------------------------------------

//-------------------------------------------------------
// Clocking block for slave driver
//-------------------------------------------------------
clocking s_drv_cb @(posedge sclk);
  
  //input and output skews
  default input #1 output #0;
  //signals from slave to master  
  input cs;
  output miso;
  output miso1;
  output miso2;
  output miso3;

endclocking : s_drv_cb

//-------------------------------------------------------
// Clocking block for slave monitor
//-------------------------------------------------------
clocking s_mon_cb @(posedge sclk);
  
  //input and output skews  
  default input #1 output #0 ;
  //signals from slave to  master
  input miso;
  input miso1;
  input miso2;
  input miso3;

endclocking : s_mon_cb

//-------------------------------------------------------
// Declaring modports for slave driver and monitor
//-------------------------------------------------------
  modport S_DRV_CB (output miso, input sclk, cs, mosi);
  modport S_MON_CB (input sclk, cs, mosi, miso);

endinterface : spi_if
