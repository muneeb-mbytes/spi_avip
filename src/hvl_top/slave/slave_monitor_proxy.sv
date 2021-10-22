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
  //uvm_analysis_port #(slave_txn) ap;

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
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task read_from_mon_bfm(bit CPOL,bit CPHA,bit mosi);
  extern virtual task write(bit [DATA_LENGTH-1:0]data);

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
  //ap = new("ap",this);
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

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Calls tasks defined in Slave_Monitor_BFM 
//--------------------------------------------------------------------------------------------
task slave_monitor_proxy::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Inside the slave_monitor_proxy"), UVM_LOW)
  
  //Will be using this when transaction object in connected
  //forever begin 
  //end

  
  repeat(1) begin
    
    //Variable : CPOL
    //Clock Polarity 
    bit CPOL=0;

    //Signal : CPHA
    //Clock Phase
    bit CPHA=0;
    
    //Signal : Mosi
    //Master-in Slave-Out
    bit mosi;

    //Signal : Miso
    //Master-in Slave-out
    //bit miso;
    
    //Signal : CS
    //Chip Select
    //bit cs;
    


    //-------------------------------------------------------
    // Calling the tasks from monitor bfm
    //-------------------------------------------------------
    read_from_mon_bfm(CPOL,CPHA,mosi);    
  end

endtask : run_phase 


//-------------------------------------------------------
// Task : read_from_mon_bfm
// Used to call the tasks from moitor bfm
//-------------------------------------------------------
task slave_monitor_proxy::read_from_mon_bfm(bit CPOL,bit CPHA,bit mosi);
    case({CPOL,CPHA})
      2'b00 : begin
                  s_mon_bfm_h.sample_mosi_pos_00(mosi);
                  $display("data_mosi=%d",s_mon_bfm_h.data_mosi);
                  write(s_mon_bfm_h.data_mosi);
              end
      2'b01 : begin 
                  s_mon_bfm_h.sample_mosi_neg_01(mosi);
                  write(s_mon_bfm_h.data_mosi);
              end
      2'b10 : begin                  
                  s_mon_bfm_h.sample_mosi_pos_10(mosi);
                  write(s_mon_bfm_h.data_mosi);
              end
      2'b11 : begin
                  s_mon_bfm_h.sample_mosi_neg_11(mosi);
                  write(s_mon_bfm_h.data_mosi);
              end
    endcase
endtask : read_from_mon_bfm

//-------------------------------------------------------
// Task : Write
// Captures the 8 bit MOSI data sampled.
//-------------------------------------------------------
task slave_monitor_proxy::write(bit [DATA_LENGTH-1:0]data);

  data_mosi = data;
  $display("WRITE__data_mosi=%0d",data_mosi);
  data_mosi_q.push_front(data_mosi);
  //ap.write(data_mosi_q);
  foreach(data_mosi_q[i])
  begin
    $display(data_mosi_q[i]);
  end

endtask


`endif
