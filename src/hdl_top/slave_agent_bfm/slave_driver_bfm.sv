`ifndef SLAVE_DRIVER_BFM_INCLUDED_
`define SLAVE_DRIVER_BFM_INCLUDED_

`define cs_length 2

//--------------------------------------------------------------------------------------------
// Interface : slave_driver_bfm
// Used as the HDL driver for SPI
// It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
// intf - SPI Interface
//--------------------------------------------------------------------------------------------
//interface slave_driver_bfm(input sclk, cs, mosi0, output miso0);
interface slave_driver_bfm(spi_if intf);
  
  parameter int DATA_WIDTH = 8;

  logic sclk;
  logic [`cs_length-1:0] cs;
  logic mosi0;
  logic miso0;

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import spi_slave_pkg::slave_driver_proxy;
  slave_driver_proxy s_drv_proxy_h;
  
  initial begin
    $display("Slave Driver BFM");
  end

  //--------------------------------------------------------------------------------------------
  // Tasks for MSB and LSB first for both posedge and negedge clock
  //--------------------------------------------------------------------------------------------

  //-------------------------------------------------------
  // MSB is driven first for pos edge
  //-------------------------------------------------------
  task drive_msb_first_pos_edge (input bit[7:0] data);
    @(posedge intf.sclk);

    for(int i=DATA_WIDTH; i>0; i--) begin
      intf.miso0 <= data[i-1];
    end
  endtask : drive_msb_first_pos_edge
  
  //-------------------------------------------------------
  // LSB is driven first for pos edge
  //-------------------------------------------------------
  task drive_lsb_first_pos_edge (input bit[7:0] data);
    @(negedge intf.sclk);

    for(int i=0; i < DATA_WIDTH; i++) begin
      intf.miso0 <= data[i];
    end
  endtask : drive_lsb_first_pos_edge
  
  //-------------------------------------------------------
  // MSB is driven first for neg edge
  //-------------------------------------------------------
  task drive_msb_first_neg_edge (input bit[7:0] data);
    @(negedge intf.sclk);

    for(int i=DATA_WIDTH; i>0; i--) begin
      intf.miso0 <= data[i-1];
    end
  endtask : drive_msb_first_neg_edge
  
  //-------------------------------------------------------
  // LSB is driven first for neg edge
  //-------------------------------------------------------
  task drive_lsb_first_neg_edge (input bit[7:0] data);
    @(negedge intf.sclk);

    for(int i=DATA_WIDTH; i>0; i--) begin
      intf.miso0 <= data[i];
    end
  endtask : drive_lsb_first_neg_edge
  
  
  //--------------------------------------------------------------------------------------------
  // Tasks for driving miso0 signal for 4 conditions of cpol and cpha
  //--------------------------------------------------------------------------------------------
  
  //--------------------------------------------------------------------------------------------
  // Task for driving miso0 signal for condition cpol==0,cpha==0
  //--------------------------------------------------------------------------------------------
//  if (!intf.cs) begin
  
    task drive_cpol_0_cpha_0 (bit[7:0] data);
      drive_msb_first_pos_edge(data);
      drive_lsb_first_pos_edge(data);
  //  drive_msb_first_neg_edge(data);
  //  drive_lsb_first_neg_edge(data);
  
      intf.miso0 <= data;
    endtask : drive_cpol_0_cpha_0
    
    //--------------------------------------------------------------------------------------------
    // Task for sampling mosi signal and driving miso signal for condition cpol==0,cpha==1
    //--------------------------------------------------------------------------------------------
    task drive_cpol_0_cpha_1 (bit[7:0] data);
  //  drive_msb_first_pos_edge(data);
  //  drive_lsb_first_pos_edge(data);
      drive_msb_first_neg_edge(data);
      drive_lsb_first_neg_edge(data);
      
      intf.miso0 <= data;
    endtask : drive_cpol_0_cpha_1
    
    //--------------------------------------------------------------------------------------------
    // Task for sampling mosi signal and driving miso signal for condition cpol==1,cpha==0
    //--------------------------------------------------------------------------------------------
    task drive_cpol_1_cpha_0 (bit[7:0] data);
      drive_msb_first_pos_edge(data);
      drive_lsb_first_pos_edge(data);
//    drive_msb_first_neg_edge(data);
//    drive_lsb_first_neg_edge(data);
      
      intf.miso0 <= data;
    endtask : drive_cpol_1_cpha_0
    
    //--------------------------------------------------------------------------------------------
    // Task for sampling mosi signal and driving miso signal for condition cpol==1,cpha==0
    //--------------------------------------------------------------------------------------------
    task drive_cpol_1_cpha_1 (bit[7:0] data);
//    drive_msb_first_pos_edge(data);
//    drive_lsb_first_pos_edge(data);
      drive_msb_first_neg_edge(data);
      drive_lsb_first_neg_edge(data);
      
      intf.miso0 <= data;
    endtask : drive_cpol_1_cpha_1

 // end
    
endinterface : slave_driver_bfm

`endif
