`ifndef SLAVE_DRIVER_PROXY_INCLUDED_
`define SLAVE_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: slave_driver_proxy
//  This is the proxy driver on the HVL side
//  It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class slave_driver_proxy extends uvm_driver#(slave_tx);
  `uvm_component_utils(slave_driver_proxy)
  slave_tx tx;

  // Variable: slave_driver_bfm_h;
  // Handle for slave driver bfm
  virtual slave_driver_bfm slave_drv_bfm_h;

  //  slave_spi_seq_item_converter  slave_spi_seq_item_conv_h;

  // Variable: slave_agent_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive_to_dut();
//  extern virtual task drive_cpol_0_cpha_0(bit [7:0] data);
//  extern virtual task drive_cpol_0_cpha_1(bit [7:0] data);
//  extern virtual task drive_cpol_1_cpha_0(bit [7:0] data);
//  extern virtual task drive_cpol_1_cpha_1(bit [7:0] data);


endclass : slave_driver_proxy

//--------------------------------------------------------------------------------------------
//  Construct: new
//  Initializes memory for new object
//
//  Parameters:
//  name - slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_driver_proxy::new(string name = "slave_driver_proxy", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  Slave_driver_bfm congiguration is obtained in build phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

//  if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",slave_agent_cfg_h))
//		`uvm_fatal("CONFIG","cannot get() slave_agent_cfg_h")
  		
  if(!uvm_config_db #(virtual slave_driver_bfm)::get(this,"","slave_driver_bfm",slave_drv_bfm_h)) begin
    `uvm_fatal("FATAL_SDP_CANNOT_GET_SLAVE_DRIVER_BFM","cannot get() slave_drv_bfm_h");
  end

  //  slave_spi_seq_item_conv_h = slave_spi_seq_item_converter::type_id::create("slave_spi_seq_item_conv_h");
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  Connects driver_proxy and driver_bfm
//
//  Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
//  slave_drv_bfm_h = slave_agent_cfg_h.slave_drv_bfm_h;
endfunction : connect_phase

//-------------------------------------------------------
//Function: end_of_elaboration_phase
//Description: connects driver_proxy and driver_bfm
//
// Parameters:
//  phase - stores the current phase
//-------------------------------------------------------
function void slave_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
//  slave_drv_bfm_h.s_drv_proxy_h = this;
endfunction : end_of_elaboration_phase


//--------------------------------------------------------------------------------------------
//  Task: run_phase
//  Tasks for driving data to dut from transaction
//--------------------------------------------------------------------------------------------
task slave_driver_proxy::run_phase(uvm_phase phase);

  forever begin
    seq_item_port.get_next_item(req);
    
    drive_to_dut();
    
    seq_item_port.item_done();
  end

endtask : run_phase 

task slave_driver_proxy::drive_to_dut();
//  foreach(req.slave_spi_seq_item_conv_h.output_conv_h.master_out_slave_in[i]) begin
  foreach(req.master_out_slave_in[i]) begin
    bit [7:0] data;

//data = req.slave_spi_seq_item_conv_h.output_conv_h.master_out_slave_in[i];
  data = req.master_out_slave_in[i];
    
//case ({tx.cpol,tx.cpha})
    case (slave_agent_cfg_h.spi_mode)
      CPOL0_CPHA0:
        if (slave_agent_cfg_h.shift_dir == MSB_FIRST) begin
          slave_drv_bfm_h.drive_msb_first_pos_edge(data);
          slave_drv_bfm_h.drive_msb_first_neg_edge(data);
        end
        
        else if (slave_agent_cfg_h.shift_dir == LSB_FIRST) begin
          slave_drv_bfm_h.drive_lsb_first_pos_edge(data);
          slave_drv_bfm_h.drive_lsb_first_neg_edge(data);
        end
  
      CPOL0_CPHA1:
        if (slave_agent_cfg_h.shift_dir == MSB_FIRST) begin
          slave_drv_bfm_h.drive_msb_first_pos_edge(data);
          slave_drv_bfm_h.drive_msb_first_neg_edge(data);
        end
        
        else if (slave_agent_cfg_h.shift_dir == LSB_FIRST) begin
          slave_drv_bfm_h.drive_lsb_first_pos_edge(data);
          slave_drv_bfm_h.drive_lsb_first_neg_edge(data);
        end
  
      CPOL1_CPHA0:
        if (slave_agent_cfg_h.shift_dir == MSB_FIRST) begin
          slave_drv_bfm_h.drive_msb_first_pos_edge(data);
          slave_drv_bfm_h.drive_msb_first_neg_edge(data);
        end
        
        else if (slave_agent_cfg_h.shift_dir == LSB_FIRST) begin
          slave_drv_bfm_h.drive_lsb_first_pos_edge(data);
          slave_drv_bfm_h.drive_lsb_first_neg_edge(data);
        end
  
      CPOL1_CPHA1:
        if (slave_agent_cfg_h.shift_dir == MSB_FIRST) begin
          slave_drv_bfm_h.drive_msb_first_pos_edge(data);
          slave_drv_bfm_h.drive_msb_first_neg_edge(data);
        end
        
        else if (slave_agent_cfg_h.shift_dir == LSB_FIRST) begin
          slave_drv_bfm_h.drive_lsb_first_pos_edge(data);
          slave_drv_bfm_h.drive_lsb_first_neg_edge(data);
        end
  
//   CPOL0_CPHA0: drive_cpol_0_cpha_0(data);
//   CPOL0_CPHA1: drive_cpol_0_cpha_1(data);
//   CPOL1_CPHA0: drive_cpol_1_cpha_0(data);
//   CPOL1_CPHA1: drive_cpol_1_cpha_1(data);
    endcase
  end

endtask : drive_to_dut

////--------------------------------------------------------------------------------------------
//// Task for driving miso0 signal for condition cpol==0,cpha==0
////--------------------------------------------------------------------------------------------
//
//task slave_driver_proxy::drive_cpol_0_cpha_0 (bit [7:0] data);
//  slave_drv_bfm_h.drive_msb_first_pos_edge(data);
//  slave_drv_bfm_h.drive_lsb_first_pos_edge(data);
//  slave_drv_bfm_h.drive_msb_first_neg_edge(data);
//  slave_drv_bfm_h.drive_lsb_first_neg_edge(data);
//
//  tx.miso0 <= data;
//endtask : drive_cpol_0_cpha_0
//
////--------------------------------------------------------------------------------------------
//// Task for sampling mosi signal and driving miso signal for condition cpol==0,cpha==1
////--------------------------------------------------------------------------------------------
//task slave_driver_proxy::drive_cpol_0_cpha_1 (bit [7:0] data);
//  slave_drv_bfm_h.drive_msb_first_pos_edge(data);
//  slave_drv_bfm_h.drive_lsb_first_pos_edge(data);
//  slave_drv_bfm_h.drive_msb_first_neg_edge(data);
//  slave_drv_bfm_h.drive_lsb_first_neg_edge(data);
//  
//  tx.miso0 <= data;
//endtask : drive_cpol_0_cpha_1
//
////--------------------------------------------------------------------------------------------
//// Task for sampling mosi signal and driving miso signal for condition cpol==1,cpha==0
////--------------------------------------------------------------------------------------------
//task slave_driver_proxy::drive_cpol_1_cpha_0 (bit [7:0] data);
//  slave_drv_bfm_h.drive_msb_first_pos_edge(data);
//  slave_drv_bfm_h.drive_lsb_first_pos_edge(data);
//  slave_drv_bfm_h.drive_msb_first_neg_edge(data);
//  slave_drv_bfm_h.drive_lsb_first_neg_edge(data);
//  
//  tx.miso0 <= data;
//endtask : drive_cpol_1_cpha_0
//
////--------------------------------------------------------------------------------------------
//// Task for sampling mosi signal and driving miso signal for condition cpol==1,cpha==0
////--------------------------------------------------------------------------------------------
//task slave_driver_proxy::drive_cpol_1_cpha_1 (bit [7:0] data);
//  slave_drv_bfm_h.drive_msb_first_pos_edge(data);
//  slave_drv_bfm_h.drive_lsb_first_pos_edge(data);
//  slave_drv_bfm_h.drive_msb_first_neg_edge(data);
//  slave_drv_bfm_h.drive_lsb_first_neg_edge(data);
//  
//  tx.miso0 <= data;
//endtask : drive_cpol_1_cpha_1

`endif
