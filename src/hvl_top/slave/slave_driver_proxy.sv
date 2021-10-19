`ifndef SLAVE_DRIVER_PROXY_INCLUDED_
`define SLAVE_DRIVER_PROXY_INCLUDED_

`include "../../hdl_top/slave_agent_bfm/slave_driver_bfm.sv"

//--------------------------------------------------------------------------------------------
// Class: slave_driver_proxy
// <Description_here>
//--------------------------------------------------------------------------------------------
class slave_driver_proxy extends uvm_component #(slave_tx);
  `uvm_component_utils(slave_driver_proxy)

  virtual slave_driver_bfm sd_bfm_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  //extern virtual task run_phase();

endclass : slave_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_driver_proxy::new(string name = "slave_driver_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  sd_bfm_h.sd_proxy_h = this;

endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task run_phase();
 // req.print();
  sd_bfm_h.set_mode(1);
  slave_tx s_tx = new();

  repeat(100) begin
    s_tx.randomize();

    if(s_tx.is_read())
      sd_bfm_h.read(s_tx.cpol, s_tx.cphase, s_tx.data);
    else
      sd_bfm_h.write(s_tx.cpol, s_tx.cphase, s_tx.data);
    end

endtask

`endif

