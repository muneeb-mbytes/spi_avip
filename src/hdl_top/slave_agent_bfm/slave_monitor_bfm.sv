`ifndef SLAVE_MONITOR_BFM_INCLUDED_
`define SLAVE_MONITOR_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Inteface : Slave Monitor BFM
// Connects the slave monitor bfm with the monitor proxy
// to call the tasks and functions from monitor bfm to monitor proxy
//--------------------------------------------------------------------------------------------

import spi_globals_pkg::*;
interface slave_monitor_bfm(input pclk, input areset, 
                            input sclk, 
                            input [NO_OF_SLAVES-1:0] cs, 
                            input mosi0, mosi1, mosi2, mosi3,
                            input miso0, miso1, miso2, miso3);

  //-------------------------------------------------------
  // 
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  //-------------------------------------------------------
  // Package : Importing SPI Global Package and SPI Slave Package
  //-------------------------------------------------------
  import spi_slave_pkg::*;

  //Variable : slave_monitor_proxy_h
  // Creating the handle for proxy driver
  slave_monitor_proxy slave_monitor_proxy_h;

  initial begin
    $display("Slave Monitor BFM");
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
  //task drive_idle_state(bit cpol);

  // `uvm_info("MASTER_DRIVER_BFM", $sformatf("Strting to drive the IDLE state"), UVM_NONE);
  //  //bit cs;
  //  @(posedge pclk);
  //  cpol = sclk;
  //  // TODO(mshariff):
  //  // Use of replication operator 
  //  // cs <= 'b1;
  //  // cs   <= NO_OF_SLAVES{1};
  //  cs <= 'b1;

  //endtask: drive_idle_state

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
  //task drive_sclk(int delay);
  //  @(posedge pclk);
  //  sclk <= ~sclk;

  //  repeat(delay - 1) begin
  //    @(posedge pclk);
  //    sclk <= ~sclk;
  //  end
  //endtask: drive_sclk
 
  //-------------------------------------------------------
  // Task: drive_msb_first_pos_edge
  //-------------------------------------------------------
  // TODO(mshariff): Reconsider the logic with different baudrates
  task sample_msb_first_pos_edge(spi_transfer_char_s data_packet, spi_transfer_cfg_s cfg_pkt);

    // Asserting CS and driving sclk with initial value
    @(posedge pclk);
    data_packet.cs = cs; 
    cfg_pkt.cpol = sclk;
 
    // Adding half-sclk delay for CPHA=1
    if(cfg_pkt.cpha) begin
      data_packet.master_out_slave_in[0] = mosi0;
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
        //drive_sclk(cfg_pkt.baudrate/2);

        // For simple SPI
        // MSHA: data_packet.data[B0] = mois0;
        // data_packet.data[i] = mosi0;
        data_packet.master_out_slave_in[i] = mosi0;

        // Sampling MISO at negedge of sclk for CPOL=0 and CPHA=0  OR
        // Sampling MISO at posedge of SLCK for CPOL=1 and CPHA=0
        //drive_sclk(cfg_pkt.baudrate/2);
        //data_packet.miso[i] = miso0;
        data_packet.master_in_slave_out[i] = miso0;
      end
      else begin : CPHA_IS_1
        // Sampling MISO at posedge of sclk for CPOL=0 and CPHA=1  OR
        // Sampling MISO at negedge of sclk for CPOL=1 and CPHA=1
        //drive_sclk(cfg_pkt.baudrate/2);
        //data_packet.miso[i] = miso0;
        data_packet.master_in_slave_out[i] = miso0;

        // Driving MOSI at negedge of sclk for CPOL=0 and CPHA=1  OR
        // Driving MOSI at posedge of sclk for CPOL=1 and CPHA=1
        //drive_sclk(cfg_pkt.baudrate/2);
        // For simple SPI
        // MSHA: mosi0 <= data_packet.data[B0];
        // mosi0 <= data_packet.data[i];
        // 
        // Since first bit in CPHA=1 is driven at CS=0, 
        // we don't have to drive the last bit twice
        if(i < (data_packet.no_of_mosi_bits_transfer-1)) begin
          data_packet.master_out_slave_in[i] = mosi0;
        end
      end

    end

    // Generate T2C delay
    // Delay between last edge of SLCK to posedge of CS
    repeat(cfg_pkt.t2c * cfg_pkt.baudrate) begin
      @(posedge pclk);
    end
    
    //******************CS is not reg here don't know how to implement here******so,commented it?
    // TODO(mshariff): Make it work for more slaves
    // CS is de-asserted
    //cs = 'b1;

    // Generates WDELAY
    // Delay between 2 transfers 
    // This is the time for which CS is de-asserted between the transfers 
    repeat(cfg_pkt.wdelay * cfg_pkt.baudrate) begin
      @(posedge pclk);
    end

    slave_monitor_proxy_h.read(data_packet);

    
  endtask: sample_msb_first_pos_edge


   //variable data_mosi
   //data of master-out slave-in
  // bit[7:0]data_mosi;

  ////--------------------------------------------------------------------------------------------
  ////Task : mon_msb_first
  ////loop is used to iterate the data
  ////considering the first bit as most significant bit
  ////--------------------------------------------------------------------------------------------
  //task mon_msb_first(bit mosi);
  //  for(int i=DATA_WIDTH-1;i>0;i--) begin
  //    @(intf.sample_mosi_pos_cb);
  //    data_mosi = data_mosi << 1;
  //    data_mosi[i]=intf.sample_mosi_pos_cb.mosi0;
  //    data_mosi[i] = mosi;
  //  end
  //  // mon_proxy.write(data_mosi);
  //
  //endtask : mon_msb_first
  ////--------------------------------------------------------------------------------------------
  ////Task : mon_lsb_first
  ////loop is used to iterate the data
  ////data tranfering first bit as least significant bit
  ////--------------------------------------------------------------------------------------------
  //
  //task mon_lsb_first(bit mosi);
  //  //mosi = 1;
  //  for(int i=0;i<DATA_WIDTH;i++) begin
  //    @(intf.sample_mosi_pos_cb);
  //    data_mosi = data_mosi << 1;
  //    data_mosi[i]=intf.sample_mosi_pos_cb.mosi0;
  //    data_mosi[i] = mosi;
  //  end
  //  // mon_proxy.write(data_mosi);
  //
  //endtask : mon_lsb_first
  //
  ////--------------------------------------------------------------------------------------------
  ////Task  : sample_mosi_pos_00
  ////assigning the sampled_mosi_neg_cb signal to proxy mosi
  ////sampling happen on the posedge
  ////calling the mon_msb_first and mon_lsb_first tasks inside 
  ////to do the data sampling based on clock polarity and clock phase 
  ////--------------------------------------------------------------------------------------------
  //
  //task sample_mosi_pos_00 (bit mosi);
  //  if(!intf.cs) begin
  //    @(intf.sample_mosi_pos_cb)
  //    mosi=intf.sample_mosi_pos_cb.mosi0;
  //    mon_msb_first(mosi);
  //    //  mon_lsb_first(mosi);
  //  end
  //endtask : sample_mosi_pos_00
  //
  ////--------------------------------------------------------------------------------------------
  ////Task  : sample_mosi_neg_01
  ////assigning the sampled_mosi_neg_cb signal to proxy mosi
  ////sampling happen on the negedge
  ////calling the mon_msb_first and mon_lsb_first tasks inside 
  ////to do the data sampling based on clock polarity and clock phase 
  ////--------------------------------------------------------------------------------------------
  //
  //task sample_mosi_neg_01 (bit mosi);
  //  if(!intf.cs)begin
  //  @(intf.sample_mosi_neg_cb)
  //  mosi=intf.sample_mosi_neg_cb.mosi0;
  //  mon_msb_first(mosi);
  //  mon_lsb_first(mosi);
  //end
  //endtask : sample_mosi_neg_01
  //
  ////--------------------------------------------------------------------------------------------
  ////Task  :sample_mosi_pos_10
  ////assigning the sample_mosi_pos_cb signal to proxy mosi
  ////sampling happen on the posedge
  ////calling the mon_msb_first and mon_lsb_first tasks inside 
  ////to do the data sampling based on clock polarity and clock phase 
  ////--------------------------------------------------------------------------------------------
  //
  //task sample_mosi_pos_10 (bit mosi);
  //  if(!intf.cs)begin
  //  @(intf.sample_mosi_pos_cb)
  //  mosi=intf.sample_mosi_pos_cb.mosi0;
  //  mon_msb_first(mosi);
  //  mon_lsb_first(mosi);
  //end
  //endtask : sample_mosi_pos_10
  //
  ////--------------------------------------------------------------------------------------------
  //////Task  : sample_mosi_neg_11
  ////assigning the sample_mosi_pos_cb.miso signal to proxy mosi
  ////sampling happens on the negedge
  ////calling the mon_msb_first and mon_lsb_first tasks inside 
  ////to do the data sampling based on clock polarity and clock phase 
  ////--------------------------------------------------------------------------------------------
  //
  //task sample_mosi_neg_11 (bit mosi);
  //  if(!intf.cs)begin
  //  @(intf.sample_mosi_neg_cb)
  //  mosi=intf.sample_mosi_neg_cb.mosi0;
  //  mon_msb_first(mosi);
  //  mon_lsb_first(mosi);
  //end
  //endtask : sample_mosi_neg_11

//--------------------------------------------------------------------------------------------
//Task : mon_msb_first
//sampling happen on posedge clk and shifting happen in negedge clk
//considering the first bit as most significant bit
//--------------------------------------------------------------------------------------------
//task mon_msb_first_pos();
//  bit[DATA_WIDTH-1:0]data_miso;
//  bit[DATA_WIDTH-1:0]data_mosi;
//  bit[DATA_WIDTH-1:0]count;
//  
//  if(!cs)begin
//    @(posedge sclk);
//      data_mosi = data_mosi << 1;
//      data_mosi[count]=mosi0;
//    @(negedge sclk);
//     data_miso = data_miso << 1;
//     data_miso[count]=miso0;
//     count++;
//  end
//  
//  slave_monitor_proxy_h.read(data_mosi,data_miso,count);
//
//endtask : mon_msb_first_pos
//
////--------------------------------------------------------------------------------------------
////Task : mon_msb_first
////sampling happen in negedge clk and shifting happen in posedge clk
////considering the first bit as most significant bit
////--------------------------------------------------------------------------------------------
//task mon_msb_first_neg();
//  bit[DATA_WIDTH-1:0]data_miso;
//  bit[DATA_WIDTH-1:0]data_mosi;
//  bit[DATA_WIDTH-1:0]count;
//  
//  if(!cs)begin
//    @(negedge sclk);
//      data_mosi = data_mosi << 1;
//      data_mosi[count]=mosi0;
//    @(posedge sclk);
//      data_miso = data_miso << 1;
//      data_miso[count]=miso0;
//     count++;
//  end
//
//  slave_monitor_proxy_h.read(data_mosi,data_miso,count);
//  
//endtask : mon_msb_first_neg
//
////--------------------------------------------------------------------------------------------
////Task : mon_lsb_first
////sampling happen in posedge clk and shifting happen in negedge clk
////data tranfering first bit as least significant bit
////--------------------------------------------------------------------------------------------
//
//task mon_lsb_first_pos();
//  bit[DATA_WIDTH-1:0]data_miso;
//  bit[DATA_WIDTH-1:0]data_mosi;
//  bit[DATA_WIDTH-1:0]count;
//  
//  if(!cs)begin
//    @(posedge sclk);
//      data_mosi = data_mosi >>1;
//      data_mosi[count]=mosi0;
//    @(negedge sclk);
//      data_miso = data_miso >> 1;
//      data_miso[count]=miso0;
//      count++;
//  end
//
//  slave_monitor_proxy_h.read(data_mosi,data_miso,count); 
//
//endtask : mon_lsb_first_pos
//
////--------------------------------------------------------------------------------------------
////Task : mon_lsb_first
////sampling happen in negedge clk and shifting happen in posedge clk
////data tranfering first bit as least significant bit
////--------------------------------------------------------------------------------------------
//task mon_lsb_first_neg();
//  bit[DATA_WIDTH-1:0]data_miso;
//  bit[DATA_WIDTH-1:0]data_mosi;
//  bit[DATA_WIDTH-1:0]count;
//  
//  if(!cs)begin
//    @(negedge sclk);
//      data_mosi = data_mosi >> 1;
//      data_mosi[count]=mosi0;
//    @(posedge sclk);
//      data_miso = data_miso >> 1;
//     data_miso[count]=miso0;
//     count++;
//  end
//
//  slave_monitor_proxy_h.read(data_mosi,data_miso,count); 
//  
//endtask : mon_lsb_first_neg
//
//
////--------------------------------------------------------------------------------------------
////Task  : sample_cpol_0_cpha_0 
////calling the mon_msb_first and mon_lsb_first tasks inside 
////to do the data sampling based on clock polarity and clock phase 
////--------------------------------------------------------------------------------------------
//task sample_cpol_0_cpha_0 ();
//  mon_msb_first_pos();
//  mon_lsb_first_pos();
//endtask : sample_cpol_0_cpha_0
//
////--------------------------------------------------------------------------------------------
////Task  : sample_cpol_0_cpha_1 
////calling the mon_msb_first and mon_lsb_first tasks inside 
////to do the data sampling based on clock polarity and clock phase 
////--------------------------------------------------------------------------------------------
//task sample_cpol_0_cpha_1 ();
//  mon_msb_first_neg();
//  mon_lsb_first_neg();
//endtask : sample_cpol_0_cpha_1
//
////--------------------------------------------------------------------------------------------
////Task  :sample_cpol_1_cpha_0 
////calling the mon_msb_first and mon_lsb_first tasks inside 
////to do the data sampling based on clock polarity and clock phase 
////--------------------------------------------------------------------------------------------
//task sample_cpol_1_cpha_0 ();
//  mon_msb_first_neg();
//  mon_lsb_first_neg();
//endtask : sample_cpol_1_cpha_0 
//
////--------------------------------------------------------------------------------------------
////Task  : sample_cpol_1_cpha_1
////calling the mon_msb_first and mon_lsb_first tasks inside 
////to do the data sampling based on clock polarity and clock phase 
////--------------------------------------------------------------------------------------------
//task sample_cpol_1_cpha_1 ();
//  mon_msb_first_pos();
//  mon_msb_first_pos();
//endtask : sample_cpol_1_cpha_1 

endinterface : slave_monitor_bfm

`endif
