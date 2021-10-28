`ifndef SLAVE_MONITOR_PROXY_INCLUDED_
`define SLAVE_MONITOR_PROXY_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: slave_monitor_proxy
// This is the HVL slave monitor proxy
// It gets the sampled data from the HDL slave monitor and 
// converts them into transaction items
//--------------------------------------------------------------------------------------------
class slave_monitor_proxy extends uvm_monitor;

  `uvm_component_utils(slave_monitor_proxy)
  
  //Variable : Analysis Port
  //Declaring Monitor Analysis Import
  uvm_analysis_port #(slave_tx) ap;
  
  //Variable : Monitor Bfm Handle
  //Declaring Virtual Monitor BFM Handle
  virtual slave_monitor_bfm s_mon_bfm_h;

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
  extern virtual task read(bit [DATA_WIDTH-1:0]data_mosi,
  bit [DATA_WIDTH-1:0]data_miso, bit [DATA_WIDTH-1:0]count);

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
  `uvm_info(get_type_name(), $sformatf("SPI Mode is = %b",sa_cfg_h.spi_mode), UVM_LOW)
  //case(sa_cfg_h.spi_mode)
  //  2'b00 : forever begin s_mon_bfm_h.sample_cpol_0_cpha_0(); end
  //  2'b01 : forever begin s_mon_bfm_h.sample_cpol_0_cpha_1(); end
  //  2'b10 : forever begin s_mon_bfm_h.sample_cpol_1_cpha_0(); end
  //  2'b11 : forever begin s_mon_bfm_h.sample_cpol_1_cpha_1(); end
  //endcase

  case(sa_cfg_h.spi_mode)
    2'b00 : repeat(1) begin s_mon_bfm_h.sample_cpol_0_cpha_0(); end
    2'b01 : repeat(1) begin s_mon_bfm_h.sample_cpol_0_cpha_0(); end 
    2'b10 : repeat(1) begin s_mon_bfm_h.sample_cpol_0_cpha_0(); end
    2'b11 : repeat(1) begin s_mon_bfm_h.sample_cpol_0_cpha_0(); end
  endcase

endtask : run_phase 


//-------------------------------------------------------
// Task : Read
// Captures the MOSI and MISO data sampled.
//-------------------------------------------------------
task slave_monitor_proxy::read(bit [DATA_WIDTH-1:0]data_mosi,
                               bit [DATA_WIDTH-1:0]data_miso,
                               bit [DATA_WIDTH-1:0]count);
  
  if(count >= DATA_WIDTH && count >= DATA_WIDTH ) begin
    `uvm_info(get_type_name(), $sformatf("MOSI is = %d",data_mosi), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("MISO is = %d",data_miso), UVM_LOW);     
  end
  else begin
    `uvm_error(get_type_name(),"Either MOSI data or MISO data is less than the charachter length mentioned");
  end

  //slave_tx slave_tx_h;
  //slave_tx_h = slave_tx::type_id::create("slave_tx_h");
  //slave_spi_seq_item_converter slave_spi_seq_item_conv_h;
  //slave_spi_seq_item_conv_h = slave_spi_seq_item_converter::type_id::create("slave_spi_seq_item_conv_h");
  //slave_spi_seq_item_conv_h.to_class(slave_tx_h,data_mosi,data_miso);
  //ap.write(slave_tx_h);
                            
endtask : read


`endif
