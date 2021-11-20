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
                           input cs, 
                           input mosi0, mosi1, mosi2, mosi3, 
                           output reg miso0, miso1, miso2, miso3);
 
  // To indicate the end of transfer when CS is de-asserted (0->1)                           
  bit end_of_transfer;

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
  // Task: wait_for_system_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
  task wait_for_system_reset();
    @(negedge areset);
    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("System reset detected"), UVM_HIGH);
    @(posedge areset);
    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("System reset deactivated"), UVM_HIGH);
  endtask: wait_for_system_reset

  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for the IDLE condition on SPI interface
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(negedge pclk);

    while (cs !== 1'b1) begin
      @(negedge pclk);
    end

    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("IDLE condition has been detected"), UVM_NONE);
  endtask: wait_for_idle_state

  //-------------------------------------------------------
  // Task: wait_for_transfer_start
  // Waits for the CS to be active-low
  //-------------------------------------------------------
  task wait_for_transfer_start();
    // 2bit shift register to check the edge on CS
    bit [1:0] cs_local;

    // Detect the falling edge on CS
    do begin
      @(negedge pclk);
      cs_local = {cs_local[0], cs};
    end while(cs_local != NEGEDGE);

    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("Transfer start is detected"), UVM_NONE);
  endtask: wait_for_transfer_start

  //-------------------------------------------------------
  // Task: drive_the_miso_data
  //-------------------------------------------------------
  // TODO(mshariff): Reconsider the logic with different baudrates
  task drive_the_miso_data (inout spi_transfer_char_s data_packet,
                            input spi_transfer_cfg_s cfg_pkt);
    int row_no;
    // reseting the no_of_miso_bits inorder to get the required count of miso data
    data_packet.no_of_miso_bits_transfer = 0;

    `uvm_info("DEBUG MOSI CPHA SLAVE_DRIVER_BFM",$sformatf("miso(8bits)=8'h%0x",data_packet.master_in_slave_out[0]),UVM_HIGH)

    // Driving of MISO data and sampling of MOSI data 
    // with respect to master's SCLK
    //
    // This loop is forever because the slave will continue to operate 
    // till the CS is active-low
    forever begin

      for(int k=0, bit_no=0; k<CHAR_LENGTH; k++) begin

        // Logic for MSB first or LSB first 
        bit_no = cfg_pkt.msb_first ? ((CHAR_LENGTH - 1) - k) : k;

        if(cfg_pkt.cpha == 0) begin : CPHA_IS_0

          // Driving MISO at posedge of sclk for CPOL=0 and CPHA=0  OR
          // Driving MISO at negedge of sclk for CPOL=1 and CPHA=0
          detect_sclk();
          if(end_of_transfer) break; 
          miso0 <= data_packet.master_in_slave_out[row_no][bit_no];
          data_packet.no_of_miso_bits_transfer++;

          // Sampling MOSI at negedge of sclk for CPOL=0 and CPHA=0  OR
          // Sampling MOSI at posedge of sclk for CPOL=1 and CPHA=0
          detect_sclk();
          if(end_of_transfer) break; 
          data_packet.master_out_slave_in[row_no][bit_no] = mosi0;
          data_packet.no_of_mosi_bits_transfer++;
        end
        else begin : CPHA_IS_1

          // When CPHA==1, the MISO is driven half-cycle(sclk) before first edge of sclk
          //
          // Driving MISO at negedge of sclk for CPOL=0 and CPHA=1  OR
          // Driving MISO at posedge of sclk for CPOL=1 and CPHA=1
          miso0 <= data_packet.master_in_slave_out[row_no][bit_no];
          data_packet.no_of_miso_bits_transfer++;

          detect_sclk();
          if(end_of_transfer) break; 

          // Sampling MOSI at posedge of sclk for CPOL=0 and CPHA=1  OR
          // Sampling MOSI at negedge of sclk for CPOL=1 and CPHA=1
          detect_sclk();
          if(end_of_transfer) break; 
          data_packet.master_out_slave_in[row_no][bit_no] = mosi0;
          data_packet.no_of_mosi_bits_transfer++;
        
        end

      end

      // Incrementing the row number
      row_no++;

      // break will come out of inner-most loop
      // This work-around is used to come out of the nested loop
      if(end_of_transfer) begin 
        end_of_transfer = 0;
        row_no = 0; 
        break; 
      end

    end
    
  endtask: drive_the_miso_data

  //-------------------------------------------------------
  // Task: detect_sclk
  // Detects the edge on sclk with regards to pclk
  //-------------------------------------------------------
  task detect_sclk();
    // 2bit shift register to check the edge on sclk
    bit [1:0] sclk_local;
    bit [1:0] cs_local;
    edge_detect_e sclk_edge_value;

    // Detect the edge on SCLK
    do begin

      @(negedge pclk);
      sclk_local = {sclk_local[0], sclk};
      end_of_transfer = 0;

      // Check for premature CS 
      // Stop the transfer when the CS is active-high
      cs_local = {cs_local[0], cs};
      if(cs_local == POSEDGE) begin
        `uvm_info("SLAVE_DRIVER_BFM", $sformatf("End of Transfer Detected"), UVM_NONE);
        end_of_transfer = 1;
        return;
      end

    end while(! ((sclk_local == POSEDGE) || (sclk_local == NEGEDGE)) );

    sclk_edge_value = edge_detect_e'(sclk_local);
    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("SCLK %s detected", sclk_edge_value.name()), UVM_HIGH);
  
  endtask: detect_sclk

endinterface : slave_driver_bfm

`endif

