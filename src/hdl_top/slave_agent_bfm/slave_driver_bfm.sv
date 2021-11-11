`ifndef SLAVE_DRIVER_BFM_INCLUDED_
`define SLAVE_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : slave_driver_bfm
// Used as the HDL driver for SPI
// It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
//-------------------------------------------------------
// Importing SPI Global Package
//-------------------------------------------------------
import spi_globals_pkg::*;

interface slave_driver_bfm(input pclk, input areset, 
                           input sclk, 
                           input [NO_OF_SLAVES-1:0] cs, 
                           input mosi0, mosi1, mosi2, mosi3, 
                           output reg miso0, miso1, miso2, miso3);
  
  // Importing SPI Slave Package
  import spi_slave_pkg::*;
  

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  //--------------------------------------------------------------------------------------------
  // Creating handle for virtual Interface
  //--------------------------------------------------------------------------------------------
  // virtual spi_if v_intf;
  
  // Variable : slave_driver_proxy
  // Creating the handle for proxy driver
  slave_driver_proxy slave_drv_proxy_h;
  
  initial begin
    $display("Slave Driver BFM");
  end

  //-------------------------------------------------------
  // Task: wait_for_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
  task wait_for_reset();
    @(negedge areset);
    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("System reset detected"), UVM_HIGH);
  endtask: wait_for_reset

  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for the IDLE condition on SPI interface
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(negedge pclk);

    // TODO(mshariff): Need to modify this code for more slave
    while (cs !== 'b1)
      @(negedge pclk);

    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("IDLE condition has been detected"), UVM_NONE);
  endtask: wait_for_idle_state

  //-------------------------------------------------------
  // Task: drive_the_miso_data
  //-------------------------------------------------------
  // TODO(mshariff): Reconsider the logic with different baudrates
  task drive_the_miso_data (spi_transfer_char_s data_packet,spi_transfer_cfg_s cfg_pkt);

// MSHA:     `uvm_info("SLAVE_DRIVER_BFM", $sformatf("TASK: DRIVING THE MISO DATA"), UVM_HIGH);
// MSHA:     `uvm_info("SLAVE_DRIVER_BFM", $sformatf("data_packet.miso =%d",data_packet.master_in_slave_out), UVM_LOW);
// MSHA:     // Driving sclk with initial value
// MSHA:     @(posedge pclk);
// MSHA: //    cs <= data_packet.cs; 
// MSHA:     sclk <= cfg_pkt.cpol;
// MSHA:  
// MSHA:     // Adding half-sclk delay for CPHA=1
// MSHA:     if(cfg_pkt.cpha) begin
// MSHA:       miso0 <= data_packet.master_in_slave_out[0];
// MSHA:       @(posedge pclk);
// MSHA:     end
// MSHA: 
// MSHA:     // Generate C2T delay
// MSHA:     // Delay between negedge of CS to posedge of sclk
// MSHA:     repeat((cfg_pkt.c2t * cfg_pkt.baudrate_divisor) - 1) begin
// MSHA:       @(posedge pclk);
// MSHA:     end
// MSHA:    
// MSHA:     // Driving sclk and MISO and sampling MOSI
// MSHA:     for(int i=0; i<data_packet.no_of_miso_bits_transfer; i++) begin
// MSHA: 
// MSHA:       if(cfg_pkt.cpha == 0) begin : CPHA_IS_0
// MSHA:         // Driving MISO at posedge of sclk for CPOL=0 and CPHA=0  OR
// MSHA:         // Driving MISO at negedge of sclk for CPOL=1 and CPHA=0
// MSHA:         drive_sclk(cfg_pkt.baudrate_divisor/2);
// MSHA: 
// MSHA:         // For simple SPI
// MSHA:         // MSHA: miso0 <= data_packet.data[B0];
// MSHA:         // miso0 <= data_packet.data[i];
// MSHA:         miso0 <= data_packet.master_in_slave_out[i];
// MSHA: 
// MSHA:         // Sampling MOSI at negedge of sclk for CPOL=0 and CPHA=0  OR
// MSHA:         // Sampling MOSI at posedge of SLCK for CPOL=1 and CPHA=0
// MSHA:         drive_sclk(cfg_pkt.baudrate_divisor/2);
// MSHA:         //data_packet.miso[i] = miso0;
// MSHA:         data_packet.master_out_slave_in[i] = mosi0;
// MSHA:       end
// MSHA: 
// MSHA:       else begin : CPHA_IS_1
// MSHA:         // Sampling MOSI at negedge of sclk for CPOL=0 and CPHA=1  OR
// MSHA:         // Sampling MOSI at posedge of SLCK for CPOL=1 and CPHA=1
// MSHA:         drive_sclk(cfg_pkt.baudrate_divisor/2);
// MSHA:         //data_packet.miso[i] = miso0;
// MSHA:         data_packet.master_out_slave_in[i] = mosi0;
// MSHA: 
// MSHA:         // Driving MISO at posedge of sclk for CPOL=0 and CPHA=1  OR
// MSHA:         // Driving MISO at negedge of sclk for CPOL=1 and CPHA=1
// MSHA:         drive_sclk(cfg_pkt.baudrate_divisor/2);
// MSHA:         // For simple SPI
// MSHA:         // MSHA: miso0 <= data_packet.data[B0];
// MSHA:         // miso0 <= data_packet.data[i];
// MSHA:         // 
// MSHA:         // Since first bit in CPHA=1 is driven at CS=0, 
// MSHA:         // we don't have to drive the last bit twice
// MSHA:         if(i < (data_packet.no_of_miso_bits_transfer-1)) begin
// MSHA:           miso0 <= data_packet.master_in_slave_out[i];
// MSHA:         end
// MSHA:       end
// MSHA: 
// MSHA:     end
// MSHA: 
// MSHA:     // Generate T2C delay
// MSHA:     // Delay between last edge of SLCK to posedge of CS
// MSHA:     repeat(cfg_pkt.t2c * cfg_pkt.baudrate_divisor) begin
// MSHA:       @(posedge pclk);
// MSHA:     end
// MSHA: 
// MSHA: //    // TODO(mshariff): Make it work for more slaves
// MSHA: //    // CS is de-asserted
// MSHA: //    cs <= 'b1;
// MSHA: //
// MSHA: //    // Generates WDELAY
// MSHA: //    // Delay between 2 transfers 
// MSHA: //    // This is the time for which CS is de-asserted between the transfers 
// MSHA: //    repeat(data_packet.wdelay * data_packet.baudrate_divisor) begin
// MSHA: //      @(posedge pclk);
// MSHA: //    end
// MSHA:     
  endtask: drive_the_miso_data

endinterface : slave_driver_bfm

`endif

