`ifndef MASTER_DRIVER_PROXY_INCLUDED_
`define MASTER_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_driver_proxy
// <Description of the class
//Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
//Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
//uvm_driver is a parameterized class and it is parameterized with the type of the request 
//sequence_item and the type of the response sequence_item 
//--------------------------------------------------------------------------------------------
class master_driver_proxy extends uvm_driver;
  //register with factory so can use create uvm_method and
  //override in future if necessary 
  
  `uvm_component_utils(master_driver_proxy)
	
  master_tx tx;
  
  //-------------------------------------------------------
  // Creating the handle for driver bfm
  //-------------------------------------------------------
  
  virtual master_driver_bfm s_drv_bfm_h;
     
  //declaring handle for master agent config class 
  // master_agent_config m_cfg;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive_to_dut();

endclass : master_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_driver_proxy::new(string name = "master_driver_proxy",uvm_component parent = null);
  super.new(name, parent);
  m_drv_bfm_h.m_drv_proxy_h = this;
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::build_phase(uvm_phase phase);
  
      if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",ma_cfg_h))
      begin
      `uvm_fatal("TB CONFIG","cannot get() ma_cfg_h  from uvm_config");
      end 
if(!uvm_config_db #(virtual master_driver_bfm)::get(this,"","master_driver_bfm",m_drv_bfm_h))
    `uvm_fatal("CONFIG","cannot get() m_drv_bfm_h")

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connects driver_proxy and driver_bfm
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Tasks for driving data to dut from transaction
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task master_driver_proxy::run_phase(uvm_phase phase);
  
  
  forever begin
    seq_item_port.get_next_item(req);
    drive_to_dut();
    seq_item_port.item_done();
  end

endtask : run_phase

task master_driver_proxy::drive_to_dut();
  foreach(req.data_master_in_slave_out[i]) begin
    bit [7:0] data;
    data = req.data_master_out_slave_in[i];

    case ({tx.cpol,tx.cpha})
      2'b00: m_drv_bfm_h.drive_mosi_pos_miso_neg_cpol_0_cpha_0(data);
      2'b01: m_drv_bfm_h.drive_mosi_neg_miso_pos_cpol_0_cpha_1(data);
      2'b10: m_drv_bfm_h.drive_mosi_pos_miso_neg_cpol_1_cpha_0(data);
      2'b11: m_drv_bfm_h.drive_mosi_neg_miso_pos_cpol_1_cpha_1(data);
    endcase
  end
endtask : drive_to_dut

`endif


