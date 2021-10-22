`ifndef SLAVE_DRIVER_PROXY_INCLUDED_
`define SLAVE_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_driver_proxy
// This is the proxy driver on the HVL side
// It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class slave_driver_proxy extends uvm_driver#(slave_tx);
  `uvm_component_utils(slave_driver_proxy)

  slave_tx tx;

  //-------------------------------------------------------
  // Creating the handle for driver bfm
  //-------------------------------------------------------
  virtual slave_driver_bfm s_drv_bfm_h;

  // Variable: sa_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config sa_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive_to_dut();;

endclass : slave_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name - slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_driver_proxy::new(string name = "slave_driver_proxy", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//   Slave_driver_bfm congiguration is obtained in build phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
//  if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",sa_cfg_h))
//		`uvm_fatal("CONFIG","cannot get() sa_cfg_h")
    
  if(!uvm_config_db #(virtual slave_driver_bfm)::get(this,"","slave_driver_bfm",s_drv_bfm_h))
  	`uvm_fatal("CONFIG","cannot get() s_drv_bfm_h")

  s_drv_bfm_h.s_drv_proxy_h = this;
endfunction : build_phase


//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connects driver_proxy and driver_bfm
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
//  s_drv_bfm_h = sa_cfg_h.s_drv_bfm_h;
endfunction : connect_phase


//--------------------------------------------------------------------------------------------
// Task: run_phase
//   Tasks for driving data to dut from transaction
//--------------------------------------------------------------------------------------------
task slave_driver_proxy::run_phase(uvm_phase phase);

//  bit cpol;
//  bit cpha;

  forever begin
    seq_item_port.get_next_item(req);
    
    drive_to_dut();
    
    seq_item_port.item_done();
  end

endtask : run_phase 

task slave_driver_proxy::drive_to_dut();
  foreach(req.data_master_in_slave_out[i]) begin
    bit [7:0] data;

    data = req.data_master_in_slave_out[i];
    
    case ({tx.cpol,tx.cpha})
      2'b00: s_drv_bfm_h.drive_mosi_pos_miso_neg_cpol_0_cpha_0(data);
      2'b01: s_drv_bfm_h.drive_mosi_neg_miso_pos_cpol_0_cpha_1(data);
      2'b10: s_drv_bfm_h.drive_mosi_pos_miso_neg_cpol_1_cpha_0(data);
      2'b11: s_drv_bfm_h.drive_mosi_neg_miso_pos_cpol_1_cpha_1(data);
    endcase
  end
endtask : drive_to_dut

`endif
