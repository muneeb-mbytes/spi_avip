`ifndef SLAVE_DRIVER_BFM_INCLUDED_
`define SLAVE_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : slave_driver_bfm
// Used as the HDL driver for SPI
// It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
interface slave_driver_bfm(input sclk, cs, mosi0, mosi1, mosi2, mosi3, 
                           output reg miso0, miso1, miso2, miso3);

  //-------------------------------------------------------
  // Importing SPI Global Package and Slave package
  //-------------------------------------------------------
  import spi_globals_pkg::*;
  import spi_slave_pkg::*;
  
  //parameter int DATA_WIDTH = 8;
  
  // Variable : slave_driver_proxy
  // Creating the handle for proxy driver
  slave_driver_proxy slave_drv_proxy_h;
  
  initial begin
    $display("Slave Driver BFM");
  end

  //--------------------------------------------------------------------------------------------
  // Tasks for MSB and LSB first for both posedge and negedge clock
  //--------------------------------------------------------------------------------------------

  task drive_msb_first_pos_edge (input bit[7:0] data);
    @(posedge sclk);

    for(int i=DATA_WIDTH; i>0; i--) begin
      miso0 <= data[i-1];
    end
  endtask : drive_msb_first_pos_edge
  
  //-------------------------------------------------------
  // LSB is driven first for pos edge
  //-------------------------------------------------------
  task drive_lsb_first_pos_edge (input bit[7:0] data);
    @(posedge sclk);

    for(int i=0; i < DATA_WIDTH; i++) begin
      miso0 <= data[i];
    end
  endtask : drive_lsb_first_pos_edge
  
  //-------------------------------------------------------
  // MSB is driven first for neg edge
  //-------------------------------------------------------
  task drive_msb_first_neg_edge (input bit[7:0] data);
    @(negedge sclk);

    for(int i=DATA_WIDTH; i>0; i--) begin
      miso0 <= data[i-1];
    end
  endtask : drive_msb_first_neg_edge
  
  //-------------------------------------------------------
  // LSB is driven first for neg edge
  //-------------------------------------------------------
  task drive_lsb_first_neg_edge (input bit[7:0] data);
    @(negedge sclk);

    for(int i=DATA_WIDTH; i>0; i--) begin
      miso0 <= data[i];
    end
  endtask : drive_lsb_first_neg_edge
  

endinterface : slave_driver_bfm

`endif
