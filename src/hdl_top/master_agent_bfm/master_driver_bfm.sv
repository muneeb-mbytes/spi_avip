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
                            output reg [NO_OF_SLAVES-1:0]cs, 
                            output reg mosi0, mosi1, mosi2, mosi3,
                            input miso0, miso1, miso2, miso3);
  //-------------------------------------------------------
  // Importing UVM Package 
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh" 
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
  //-------------------------------------------------------
  task wait_for_reset();
    @(negedge areset);
    `uvm_info("MASTER_DRIVER_BFM", $sformatf("System reset detected"), UVM_HIGH);
  endtask: wait_for_reset

  //-------------------------------------------------------
  // Task: drive_idle_state 
  // This task drives the SPI interface to it's IDLA state
  //
  // Parameters:
  //  cpol - Clock polarity of sclk
  //-------------------------------------------------------
  task drive_idle_state(bit cpol);

   `uvm_info("MASTER_DRIVER_BFM", $sformatf("Strting to drive the IDLE state"), UVM_HIGH);

    @(posedge pclk);
    sclk <= cpol;
    // TODO(mshariff):
    // Use of replication operator 
    // cs <= 'b1;
    // cs   <= NO_OF_SLAVES{1};
    cs <= 'b1;

  endtask: drive_idle_state

  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for the IDLE condition on SPI interface
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(negedge pclk);

    // TODO(mshariff): Need to modify this code for more slave
    while (cs !== 'b1)
      @(negedge pclk);

    `uvm_info("MASTER_DRIVER_BFM", $sformatf("IDLE condition has been detected"), UVM_HIGH);
  endtask: wait_for_idle_state

  //-------------------------------------------------------
  // Task: drive_sclk
  // Used for generating the sclk with regards to baudrate 
  //-------------------------------------------------------
  task drive_sclk(int delay);
    @(posedge pclk);
    sclk <= ~sclk;

    repeat(delay - 1) begin
      @(posedge pclk);
      sclk <= ~sclk;
    end
  endtask: drive_sclk
 
  //-------------------------------------------------------
  // Task: drive_msb_first_pos_edge
  //-------------------------------------------------------
  // TODO(mshariff): Reconsider the logic with different baudrates
  //task drive_msb_first_pos_edge(spi_transfer_char_s data_packet);

  task drive_msb_first_pos_edge(spi_transfer_char_s data_packet, spi_transfer_cfg_s cfg_pkt); 
    //`uvm_info("CS VALUE IN MASTER_DRIVER_BFM",$sformatf("data_packet.cs = \n %s",data_packet.cs),UVM_LOW)
    //`uvm_info("MOSI VALUE IN MASTER_DRIVER_BFM",$sformatf("data_packet.mosi = \n %s",data_packet.master_out_slave_in),UVM_LOW)
    // Asserting CS and driving sclk with initial value
    @(posedge pclk);
    cs <= data_packet.cs; 
    sclk <= cfg_pkt.cpol;
 
    // Adding half-sclk delay for CPHA=1
    if(cfg_pkt.cpha) begin
      //`uvm_info("MOSI VALUE IN MASTER_DRIVER_BFM",$sformatf("mosi[0]=%d",data_packet.master_out_slave_in[0]),UVM_LOW)
      mosi0 <= data_packet.master_out_slave_in[0];
      @(posedge pclk);
    end

    // Generate C2T delay
    // Delay between negedge of CS to posedge of sclk
    repeat((cfg_pkt.c2t * cfg_pkt.baudrate) - 1) begin
      @(posedge pclk);
    end
   
    // Driving CS, sclk and MOSI
    // and sampling MISO
    for(int i=0; i<data_packet.no_of_mosi_bits_transfer; i++) begin

      if(cfg_pkt.cpha == 0) begin : CPHA_IS_0
        // Driving MOSI at posedge of sclk for CPOL=0 and CPHA=0  OR
        // Driving MOSI at negedge of sclk for CPOL=1 and CPHA=0
        drive_sclk(cfg_pkt.baudrate/2);

        // For simple SPI
        // MSHA: mosi0 <= data_packet.data[B0];
        // mosi0 <= data_packet.data[i];
        //`uvm_info("MOSI VALUE IN MASTER_DRIVER_BFM",$sformatf("mosi[i]=%d",data_packet.master_out_slave_in[0]),UVM_LOW)
        mosi0 <= data_packet.master_out_slave_in[i];

        // Sampling MISO at negedge of sclk for CPOL=0 and CPHA=0  OR
        // Sampling MISO at posedge of SLCK for CPOL=1 and CPHA=0
        drive_sclk(cfg_pkt.baudrate/2);
        //data_packet.miso[i] = miso0;
        data_packet.master_in_slave_out[i] = miso0;
      end
      else begin : CPHA_IS_1
        // Sampling MISO at posedge of sclk for CPOL=0 and CPHA=1  OR
        // Sampling MISO at negedge of sclk for CPOL=1 and CPHA=1
        drive_sclk(cfg_pkt.baudrate/2);
        //data_packet.miso[i] = miso0;
        data_packet.master_in_slave_out[i] = miso0;

        // Driving MOSI at negedge of sclk for CPOL=0 and CPHA=1  OR
        // Driving MOSI at posedge of sclk for CPOL=1 and CPHA=1
        drive_sclk(cfg_pkt.baudrate/2);
        // For simple SPI
        // MSHA: mosi0 <= data_packet.data[B0];
        // mosi0 <= data_packet.data[i];
        // 
        // Since first bit in CPHA=1 is driven at CS=0, 
        // we don't have to drive the last bit twice
        if(i < (data_packet.no_of_mosi_bits_transfer-1)) begin
          //`uvm_info("CS VALUE IS MASTER_DRIVER_BFM",$sformatf("mosi[i]=%d",data_packet.master_out_slave_in[0]),UVM_LOW)
          mosi0 <= data_packet.master_out_slave_in[i];
        end
      end

    end

    // Generate T2C delay
    // Delay between last edge of SLCK to posedge of CS
    repeat(cfg_pkt.t2c * cfg_pkt.baudrate) begin
      @(posedge pclk);
    end

    // TODO(mshariff): Make it work for more slaves
    // CS is de-asserted
    cs <= 'b1;

    // Generates WDELAY
    // Delay between 2 transfers 
    // This is the time for which CS is de-asserted between the transfers 
    repeat(cfg_pkt.wdelay * cfg_pkt.baudrate) begin
      @(posedge pclk);
    end
    
  endtask: drive_msb_first_pos_edge

endinterface : master_driver_bfm
`endif
