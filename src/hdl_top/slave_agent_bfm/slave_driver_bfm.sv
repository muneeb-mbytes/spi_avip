`ifndef SLAVE_DRIVER_BFM_INCLUDED_
`define SLAVE_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : slave_driver_bfm
// Used as the HDL driver for SPI
// It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface slave_driver_bfm(sclk, cs, mosi0, mosi1, mosi2, mosi3, miso0, miso1 ,
  miso2, miso3 );

  input sclk;
  input cs;
  input mosi0;
  input mosi1;
  input mosi2;
  input mosi3;
  output reg miso0;
  output reg miso1;
  output reg miso2;
  output reg miso3;
  

  import spi_slave_pkg::slave_driver_proxy;

  //parameter int DATA_WIDTH = 8;

  //Variable : slave_driver_proxy
  //Creating the handle for proxy driver
  slave_driver_proxy slave_drv_proxy_h;
  
  initial begin
    $display("Slave Driver BFM");
  end

  //--------------------------------------------------------------------------------------------
  // Tasks for MSB and LSB first
  //--------------------------------------------------------------------------------------------

  //-------------------------------------------------------
  // MSB is driven first for pos edge
  //-------------------------------------------------------
  //task drive_msb_first_pos_edge (input bit[7:0] data);
  //  for(int i=DATA_WIDTH; i>0 ; i--) begin
  //    @(s_drv_intf.sample_mosi_pos_cb);
  //    // TODO(mshariff): 
  //    // Slave drives MISO data
  //    // and samples MOSI data. Thus, mosi cannot come on left hand side
  //    // MSHA:   s_drv_intf.sample_mosi_pos_cb.mosi0 = data[i-1];
  //  end
  //endtask : drive_msb_first_pos_edge
  //
  ////-------------------------------------------------------
  //// LSB is driven first for pos edge
  ////-------------------------------------------------------
  //task drive_lsb_first_pos_edge (input bit[7:0] data);
  //  for(int i=0; i < DATA_WIDTH; i++) begin
  //    @(s_drv_intf.sample_mosi_pos_cb);
  //    // TODO(mshariff): 
  //    // Slave drives MISO data
  //    // and samples MOSI data. Thus, mosi cannot come on left hand side
  //    // MSHA: s_drv_intf.sample_mosi_pos_cb.mosi0 = data[i];
  //  end
  //endtask : drive_lsb_first_pos_edge
  //
  ////-------------------------------------------------------
  //// MSB is driven first for neg edge
  ////-------------------------------------------------------
  //task drive_msb_first_neg_edge (input bit[7:0] data);
  //  for(int i=DATA_WIDTH; i>0 ; i--) begin
  //   @(s_drv_intf.sample_mosi_neg_cb);
  //    // TODO(mshariff): 
  //    // Slave drives MISO data
  //    // and samples MOSI data. Thus, mosi cannot come on left hand side
  //    // MSHA:  s_drv_intf.sample_mosi_neg_cb.mosi0 = data[i-1];
  // end
  //endtask : drive_msb_first_neg_edge
  //
  ////-------------------------------------------------------
  //// LSB is driven first for neg edge
  ////-------------------------------------------------------
  //task drive_lsb_first_neg_edge (input bit[7:0] data);
  //  for(int i=0; i < DATA_WIDTH; i++) begin
  //    @(s_drv_intf.sample_mosi_neg_cb);
  //    // TODO(mshariff): 
  //    // Slave drives MISO data
  //    // and samples MOSI data. Thus, mosi cannot come on left hand side
  //    // MSHA: s_drv_intf.sample_mosi_neg_cb.mosi0 = data[i];
  //  end
  //endtask : drive_lsb_first_neg_edge
  //
  //
  ////--------------------------------------------------------------------------------------------
  //// Task for sampling mosi signal and driving miso signal for condition cpol==0,cpha==0
  ////--------------------------------------------------------------------------------------------
  //task drive_mosi_pos_miso_neg_cpol_0_cpha_0 (bit[7:0] data);
  //  
  //  drive_msb_first_pos_edge(data);
  //  drive_lsb_first_pos_edge(data);
  //  drive_msb_first_neg_edge(data);
  //  drive_lsb_first_neg_edge(data);

  //    // TODO(mshariff): 
  //    // Slave drives MISO data
  //    // and samples MOSI data. Thus, mosi cannot come on left hand side
  //    // MSHA: s_drv_intf.sample_mosi_pos_cb.mosi0 = data;

  //endtask : drive_mosi_pos_miso_neg_cpol_0_cpha_0
  //
  ////--------------------------------------------------------------------------------------------
  //// Task for sampling mosi signal and driving miso signal for condition cpol==0,cpha==1
  ////--------------------------------------------------------------------------------------------
  //task drive_mosi_neg_miso_pos_cpol_0_cpha_1 (bit[7:0] data);
  //  
  //  drive_msb_first_pos_edge(data);
  //  drive_lsb_first_pos_edge(data);
  //  drive_msb_first_neg_edge(data);
  //  drive_lsb_first_neg_edge(data);
  //  
  //    // TODO(mshariff): 
  //    // Slave drives MISO data
  //    // and samples MOSI data. Thus, mosi cannot come on left hand side
  //    // MSHA: s_drv_intf.sample_mosi_neg_cb.mosi0 = data;

  //endtask : drive_mosi_neg_miso_pos_cpol_0_cpha_1
  //
 
  ////--------------------------------------------------------------------------------------------
  //// Task for sampling mosi signal and driving miso signal for condition cpol==1,cpha==0
  ////--------------------------------------------------------------------------------------------
  //task drive_mosi_pos_miso_neg_cpol_1_cpha_0 (bit[7:0] data);
  //  
  //  drive_msb_first_pos_edge(data);
  //  drive_lsb_first_pos_edge(data);
  //  drive_msb_first_neg_edge(data);
  //  drive_lsb_first_neg_edge(data);
  //  
  //    // TODO(mshariff): 
  //    // Slave drives MISO data
  //    // and samples MOSI data. Thus, mosi cannot come on left hand side
  //    // MSHA: s_drv_intf.sample_mosi_pos_cb.mosi0 = data;

  //endtask : drive_mosi_pos_miso_neg_cpol_1_cpha_0
  //
  //
  ////--------------------------------------------------------------------------------------------
  //// Task for sampling mosi signal and driving miso signal for condition cpol==1,cpha==0
  ////--------------------------------------------------------------------------------------------
  //task drive_mosi_neg_miso_pos_cpol_1_cpha_1 (bit[7:0] data);
  //  
  //  drive_msb_first_pos_edge(data);
  //  drive_lsb_first_pos_edge(data);
  //  drive_msb_first_neg_edge(data);
  //  drive_lsb_first_neg_edge(data);
  //  
  //    // TODO(mshariff): 
  //    // Slave drives MISO data
  //    // and samples MOSI data. Thus, mosi cannot come on left hand side
  //    // MSHA: s_drv_intf.sample_mosi_neg_cb.mosi0 = data;

  //endtask : drive_mosi_neg_miso_pos_cpol_1_cpha_1
  
endinterface : slave_driver_bfm

`endif
