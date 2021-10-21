<<<<<<< HEAD
`ifndef SPI_IF_INCLUDED_
`define SPI_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : spi_if
//  Declaration of pin level signals for SPI interface
//--------------------------------------------------------------------------------------------
interface spi_if;

  // Variable: sclk
  // SPI clock signal
  logic sclk;

  // Variable: cs
  // Active low chip select
  logic cs;
  
  //-------------------------------------------------------
  // Master Out Slave In signals
  //-------------------------------------------------------
  // Variable: mosi0
  // Master-out slave-in 0
  logic mosi0;

  // Variable: mosi0
  // Master-out slave-in 1
  logic mosi1;

  // Variable: mosi0
  // Master-out slave-in 2
  logic mosi2;

  // Variable: mosi0
  // Master-out slave-in 3
  logic mosi3;

  //-------------------------------------------------------
  // Master In Slave Out signals
  //-------------------------------------------------------
  // Variable: miso0
  // Master-in slave-out 0
  logic miso0;

  // Variable: miso0
  // Master-in slave-out 1
  logic miso1;

  // Variable: miso0
  // Master-in slave-out 2
  logic miso2;

  // Variable: miso0
  // Master-in slave-out 3
  logic miso3;

  //-------------------------------------------------------
  // Clocking : m_pos_drv_cb
  // Used for driving the MOSI signals at posedge of sclk
  //-------------------------------------------------------
  clocking m_pos_drv_cb @(posedge sclk);
    // Input and output skews
    default input #1 output #0;

    output mosi0;
    output mosi1;
    output mosi2;
    output mosi3;
  endclocking : m_pos_drv_cb
  
  //-------------------------------------------------------
  // Clocking : m_neg_drv_cb
  // Used for driving the MOSI signals at negedge of sclk
  //-------------------------------------------------------
  clocking m_neg_drv_cb @(negedge sclk);
    // Input and output skews
    default input #1 output #0;

    output mosi0;
    output mosi1;
    output mosi2;
    output mosi3;
  endclocking : m_neg_drv_cb

  //-------------------------------------------------------
  // Clocking : s_pos_drv_cb
  // Used for driving the MISO signals at posedge of sclk
  //-------------------------------------------------------
  clocking s_pos_drv_cb @(posedge sclk);
    // Input and output skews
    default input #1 output #0;

    output miso0;
    output miso1;
    output miso2;
    output miso3;
  endclocking : s_pos_drv_cb
  
  //-------------------------------------------------------
  // Clocking : s_neg_drv_cb
  // Used for driving the MISO signals at negedge of sclk
  //-------------------------------------------------------
  clocking s_neg_drv_cb @(negedge sclk);
    // Input and output skews
    default input #1 output #0;

    output miso0;
    output miso1;
    output miso2;
    output miso3;
  endclocking : s_neg_drv_cb

  //-------------------------------------------------------
  // Clocking : sample_mosi_pos_cb
  // Used for sampling the MOSI signals at posedge of sclk
  //-------------------------------------------------------
  clocking sample_mosi_pos_cb @(posedge sclk);
    // Input and output skews
    default input #1 output #0;

    input mosi0;
    input mosi1;
    input mosi2;
    input mosi3;
  endclocking : sample_mosi_pos_cb 
  
  //-------------------------------------------------------
  // Clocking : sample_mosi_neg_cb
  // Used for sampling the MOSI signals at negedge of sclk
  //-------------------------------------------------------
  clocking sample_mosi_neg_cb @(negedge sclk);
    // Input and output skews
    default input #1 output #0;

    input mosi0;
    input mosi1;
    input mosi2;
    input mosi3;
  endclocking : sample_mosi_neg_cb 
  
  //-------------------------------------------------------
  // Clocking : sample_miso_pos_cb
  // Used for sampling the MISO signals at posedge of sclk
  //-------------------------------------------------------
  clocking sample_miso_pos_cb @(posedge sclk);
    // Input and output skews
    default input #1 output #0;

    input miso0;
    input miso1;
    input miso2;
    input miso3;
  endclocking : sample_miso_pos_cb 
  
  //-------------------------------------------------------
  // Clocking : sample_miso_neg_cb
  // Used for sampling the MISO signals at negedge of sclk
  //-------------------------------------------------------
  clocking sample_miso_neg_cb @(negedge sclk);
    // Input and output skews
    default input #1 output #0;

    input miso0;
    input miso1;
    input miso2;
    input miso3;
  endclocking : sample_miso_neg_cb 
  
  //-------------------------------------------------------
  // Declaring modports for Master driver
  //-------------------------------------------------------
  modport MAS_DRV_MP (clocking m_pos_drv_cb, clocking m_neg_drv_cb, 
                      clocking sample_miso_pos_cb, clocking sample_miso_neg_cb,
                      input cs);  

  //-------------------------------------------------------
  // Declaring modports for Slave driver
  //-------------------------------------------------------
  modport SLV_DRV_MP (clocking s_pos_drv_cb, clocking s_neg_drv_cb, 
                      clocking sample_mosi_pos_cb, clocking sample_mosi_neg_cb,
                      input cs);  

  //-------------------------------------------------------
  // Declaring modports for Slave monitor 
  //-------------------------------------------------------
  modport MON_MP (clocking sample_mosi_pos_cb, clocking sample_mosi_neg_cb, 
                  clocking sample_miso_pos_cb, clocking sample_miso_neg_cb,
                  input cs);  

endinterface: spi_if 

`endif
=======
//--------------------------------------------------------------------------------------------
// Module       : Interface
// Description  : Declaration of pin level signals as logic
//--------------------------------------------------------------------------------------------
interface spi_if;

  logic sclk;
  logic miso;
  logic mosi;
  logic ss;

endinterface : spi_if
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
