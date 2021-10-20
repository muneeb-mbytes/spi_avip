`ifndef SLAVE_DRIVER_PROXY_INCLUDED_
`define SLAVE_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_driver_proxy
// This is the proxy driver on the HVL side
// It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class slave_driver_proxy extends uvm_driver#(slave_tx);
  `uvm_component_utils(slave_driver_proxy)

  //-------------------------------------------------------
  // Creating the handle for driver bfm
  //-------------------------------------------------------
  virtual slave_driver_bfm v_drv_bfm;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
//  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : slave_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
// // TODO(mshariff): add comments
// Parameters:
//  name - slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_driver_proxy::new(string name = "slave_driver_proxy", uvm_component parent = null);
  super.new(name, parent);
  v_drv_bfm.drv_proxy = this;
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// // TODO(mshariff): COmments
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
//  if(!uvm_config_db #(slave_agent_config)::get(this,"","sa_cfg_h",sa_cfg_h))
//		`uvm_fatal("CONFIG","cannot get() sa_cfg_h")
    
//  if(!uvm_config_db #(slave_driver_bfm)::get(this,"","v_drv_bfm",v_drv_bfm))
//  	`uvm_fatal("CONFIG","cannot get() v_drv_bfm")
endfunction : build_phase

/*
//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connects driver_proxy and driver_bfm
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
 // v_drv_bfm = sa_cfg_h.v_drv_bfm;

endfunction : connect_phase
*/

//--------------------------------------------------------------------------------------------
// Task: run_phase
// // TODO(mshariff): 
//--------------------------------------------------------------------------------------------
task slave_driver_proxy::run_phase(uvm_phase phase);

//  slave_tx tx = new();
//  repeat(2) begin
//    tx.randomize();
//    v_drv_bfm.drive_mosi_pos_miso_neg();
//    tx.print();
//  end

  forever begin
    seq_item_port.get_next_item(req);
    v_drv_bfm.mosi_pos_miso_neg (req);
    seq_item_port.item_done();
  end

endtask : run_phase 

/*
task slave_driver_proxy::over_all_task;
  repeat(2) begin
    if (cs == 0) begin
      case: {cpol,cpha}
        2'b00: v_drv_bfm.drive_mosi_pos_miso_neg();
        2'b01: v_drv_bfm.drive_mosi_neg_miso_pos();
        2'b10: v_drv_bfm.drive_mosi_pos_miso_neg();
        2'b11: v_drv_bfm.drive_mosi_neg_miso_pos();
      endcase
    end
end
*/
    
`endif
