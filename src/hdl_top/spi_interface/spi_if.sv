//--------------------------------------------------------------------------------------------
// Module       : Interface
// Description  : Declaration of pin level signals as logic
//--------------------------------------------------------------------------------------------
interface spi_if;

  logic sclk;
  logic ss;
  
  //-------------------------------------------------------
  // Master out Slave in
  //-------------------------------------------------------
  logic mosi0;
  logic mosi1;
  logic mosi2;
  logic mosi3;
  //-------------------------------------------------------
  // Master out Slave in
  //-------------------------------------------------------
  logic miso0;
  logic miso1;
  logic miso2;
  logic miso3;

//-------------------------------------------------------
// Clocking block for slave driver bfm
//-------------------------------------------------------
clocking sd_cb @(posedge sclk);
  //-------------------------------------------------------
  // Input and output skews
  //-------------------------------------------------------
  default input #1 output #2;
  
  //-------------------------------------------------------
  // Signals from slave to master  
  //-------------------------------------------------------
  input ss;
  input mosi0;
  input mosi1;
  input mosi2;
  input mosi3;
  output miso0;
  output miso1;
  output miso2;
  output miso3;
endclocking : sd_cb

//-------------------------------------------------------
// Clocking block for slave driver proxy
//-------------------------------------------------------
clocking sdp_cb @(posedge sclk);
  //-------------------------------------------------------
  // Input and output skews
  //-------------------------------------------------------
  default input #1 output #2;
  
  //-------------------------------------------------------
  // Signals from slave to master  
  //-------------------------------------------------------
  input ss;
  input mosi0;
  input mosi1;
  input mosi2;
  input mosi3;
  output miso0;
  output miso1;
  output miso2;
  output miso3;
endclocking : sdp_cb

//-------------------------------------------------------
// Clocking block for slave monitor bfm
//-------------------------------------------------------
clocking sm_cb @(posedge sclk);
  //-------------------------------------------------------
  // Input and output skews
  //-------------------------------------------------------
  default input #1 output #2;
  
  //-------------------------------------------------------
  // Signals from slave to master  
  //-------------------------------------------------------
  input ss;
  input mosi0;
  input mosi1;
  input mosi2;
  input mosi3;
  input miso0;
  input miso1;
  input miso2;
  input miso3;
endclocking : sm_cb

//-------------------------------------------------------
// Clocking block for slave monitor proxy
//-------------------------------------------------------
clocking smp_cb @(posedge sclk);
  //-------------------------------------------------------
  // Input and output skews
  //-------------------------------------------------------
  default input #1 output #2;
  
  //-------------------------------------------------------
  // Signals from slave to master  
  //-------------------------------------------------------
  input ss;
  input mosi0;
  input mosi1;
  input mosi2;
  input mosi3;
  input miso0;
  input miso1;
  input miso2;
  input miso3;
endclocking : smp_cb

//-------------------------------------------------------
// Declaring modports for slave driver and monitor
//-------------------------------------------------------
  modport SD_MP (clocking sd_cb);
  modport SDP_MP (clocking sdp_cb);
  modport SM_MP (clocking sm_cb);
  modport SMP_MP (clocking smp_cb);

endinterface: spi_if 

