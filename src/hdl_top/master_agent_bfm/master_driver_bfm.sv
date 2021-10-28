`ifndef MASTER_DRIVER_BFM_INCLUDED_
`define MASTER_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
//Interface : master_driver_bfm
//Used as the HDL driver for SPI
//It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
import spi_globals_pkg::*;
interface master_driver_bfm(input pclk, input areset, 
                            output reg sclk, 
                            output reg [NO_OF_SLAVES-1:0] cs, 
                            output reg mosi0, mosi1, mosi2, mosi3,
                            input miso0, miso1, miso2, miso3);
  
  //-------------------------------------------------------
  // Importing SPI Global Package and Slave package
  //-------------------------------------------------------
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

  //-------------------------------------------------------
  // Task: wait_for_reset
  // Waiting for system reset to be active
  //
  // Parameters:
  //  cpol - Clock polarity value
  //-------------------------------------------------------
  task wait_for_reset(bit cpol);
    @(negedge areset);
    
  //  `uvm_info("MASTER_DRIVER_BFM", $sformatf("System reset detected"), UVM_NONE)

    @(posedge pclk);
    sclk <= cpol;
    // TODO(mshariff):
    // Use of replication operator 
    // cs <= 'b1;
    // cs   <= NO_OF_SLAVES{1};
    cs <= 1'b1;

  endtask: wait_for_reset

  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for the IDLE condition on SPI interface
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(negedge pclk);

    // TODO(mshariff): Need to modify this code for more slave
    while (cs !== 1'b1)
      @(negedge pclk);

  //  `uvm_info("MASTER_DRIVER_BFM", $sformatf("IDLE condition has been detected"), UVM_NONE);
  endtask: wait_for_idle_state
 
  //-------------------------------------------------------
  // Task: drive_msb_first_pos_edge
  //-------------------------------------------------------
  task drive_msb_first_pos_edge(spi_transfer_char_s data_packet);
    @(posedge pclk);
    // TODO(mshariff): Make this work for more slaves
    cs <= 1'b0;
    sclk <= 1'b0;
  
    // Generate C2T delay
    // Delay between negedge of CS to posedge of SCLK
    repeat((data_packet.c2t * data_packet.baudrate) - 1) begin
      @(posedge pclk);
    end
   
    // Driving CS, SCLK and MOSI
    // and sampling MISO
    for(int i=0; i<data_packet.no_of_mosi_bits_transfer; i++) begin
      @(posedge pclk);
      sclk <= ~sclk;
      // For simple SPI
      // MSHA: mosi0 <= data_packet.data[B0];
      // mosi0 <= data_packet.data[i];
         mosi0 <= data_packet.master_out_slave_in[i];
      @(posedge pclk);
      sclk <= ~sclk;
      //data_packet.miso[i] = miso0;
      data_packet.master_in_slave_out[i] = miso0;
    end

    // Generate T2C delay
    // Delay between last edge of SLCK to posedge of CS
    repeat(data_packet.t2c * data_packet.baudrate) begin
      @(posedge pclk);
    end

    // TODO(mshariff): Make it work for more slaves
    cs <= 1'b0;
  endtask: drive_msb_first_pos_edge

endinterface : master_driver_bfm
`endif
