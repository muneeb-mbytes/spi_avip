`ifndef SLAVE_MONITOR_PROXY_INCLUDED_
`define SLAVE_MONITOR_PROXY_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: slave_monitor_proxy
// This is the HVL slave monitor proxy
// It gets the sampled data from the HDL slave monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class slave_monitor_proxy extends uvm_monitor;

  //Parameter : Data length
  //Data length of Data_MOSI
  parameter DATA_LENGTH = 8;

  `uvm_component_utils(slave_monitor_proxy)
  
  //Declaring Monitor Analysis Import
  uvm_analysis_port #(slave_tx) ap;

  //Declaring Virtual Monitor BFM Handle
  virtual slave_monitor_bfm s_mon_bfm_h;

  //Signal : MOSI Data-Input
  bit [DATA_LENGTH-1:0]data_mosi;

  //Queue : data_mosi_q
  //Sets of Data_mosi data
  bit [DATA_LENGTH-1:0]data_mosi_q[$];

  // Variable: sa_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config sa_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task read(bit [DATA_LENGTH-1:0]data);

endclass : slave_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_monitor_proxy::new(string name = "slave_monitor_proxy",uvm_component parent = null);
  super.new(name, parent);
  ap = new("ap",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual slave_monitor_bfm)::get(this,"","slave_monitor_bfm",s_mon_bfm_h)) begin
    `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in Slave_Monitor_proxy"));
  end

  if(!uvm_config_db#(slave_agent_config)::get(this,"","slave_agent_config",sa_cfg_h)) begin
    `uvm_fatal("FATAL_S_AGENT_CFG",$sformatf("Couldn't get S_AGENT_CFG in Slave_Monitor_proxy"));
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function : End of Elobaration Phase
// Used to connect the slave_monitor_proxy defined in slave_monitor_bfm
//--------------------------------------------------------------------------------------------
function void slave_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  s_mon_bfm_h.s_mon_proxy_h = this;
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Calls tasks defined in Slave_Monitor_BFM 
//--------------------------------------------------------------------------------------------
task slave_monitor_proxy::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Inside the slave_monitor_proxy"), UVM_LOW)
  $display("SPI Mode is = %b",sa_cfg_h.spi_mode);
  //Will be using this when transaction object in connected
  //forever begin
  repeat(1) begin
    case(sa_cfg_h.spi_mode)
      2'b00 : s_mon_bfm_h.sample_cpol_0_cpha_0();
      2'b01 : s_mon_bfm_h.sample_cpol_0_cpha_1();
      2'b10 : s_mon_bfm_h.sample_cpol_1_cpha_0();
      2'b11 : s_mon_bfm_h.sample_cpol_1_cpha_1();
    endcase
  end

endtask : run_phase 


//-------------------------------------------------------
// Task : Read
// Captures the 8 bit MOSI data sampled.
//-------------------------------------------------------
task slave_monitor_proxy::read(bit [DATA_LENGTH-1:0]data);
  
  //Uncomment the below three lines when we use slave_tx object.
  slave_tx slave_tx_h;
  slave_tx_h = slave_tx::type_id::create("slave_tx_h");
  slave_tx_h.data_master_out_slave_in = data;
  
  data_mosi = data;
  $display("WRITE__data_mosi=%0d",data_mosi);
  
  //Uncomment the below three lines when we use slave_tx object.
  slave_tx_h.master_out_slave_in.push_front(data);
  data_mosi_q.push_front(data_mosi);
  ap.write(slave_tx_h);
  
  foreach(data_mosi_q[i])
  begin
    $display(data_mosi_q[i]);
  end

endtask : read


`endif
