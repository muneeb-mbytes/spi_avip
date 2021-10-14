 package test_pkg;

  import uvm_pkg::*;
    `include "uvm_macros.svh"    
    `include "../master/master_xtn.sv"
  // `include "master_agent_config.sv"
  // `include "../env/env_config.sv"             
    `include "../master/master_driver_proxy.sv"
    `include "../master/master_monitor_proxy.sv"    
    `include "../master/master_sequencer.sv"
    `include "../master/master_agent_dup.sv"
  //`include "top.sv"
  //`include "master_sequence.sv"                                
    `include "../env/virtual_sequencer.sv"
  //`include "../env/virtual_sequence.sv"
  //`include "dut_wrapper.sv";
  //`include "../master/master_agent.sv"                                                      
    `include "../env/env.sv"                                                        
    `include "test_dup.sv"
 endpackage


