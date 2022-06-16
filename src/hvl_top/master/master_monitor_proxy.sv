`ifndef MASTER_MONITOR_PROXY_INCLUDED_
`define MASTER_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: master_monitor_proxy
//  
//  Monitor is written by extending uvm_monitor,uvm_monitor is inherited from uvm_component, 
//  A monitor is a passive entity that samples the DUT signals through virtual interface and 
//  converts the signal level activity to transaction level,monitor samples DUT signals but does not drive them.
//  Monitor should have analysis port (TLM port) and virtual interface handle that points to DUT signal
//--------------------------------------------------------------------------------------------
class master_monitor_proxy extends uvm_component; 
  `uvm_component_utils(master_monitor_proxy)
  
  // Variable: master_agent_cfg_h
  // Declaring handle for master agent config class 
  master_agent_config master_agent_cfg_h;
    
  //declaring analysis port for the monitor port
  uvm_analysis_port #(master_tx) master_analysis_port;
  
  //Declaring Virtual Monitor BFM Handle
  virtual master_monitor_bfm master_mon_bfm_h;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_monitor_proxy", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  // MSHA: extern virtual task sample_from_bfm(master_tx packet);
  //extern virtual task read_from_bfm(spi_transfer_char_s packet);
  extern virtual function void reset_detected();
  extern virtual task read(spi_transfer_char_s data_packet);

endclass : master_monitor_proxy

//--------------------------------------------------------------------------------------------
//  Construct: new
//
//  Parameters:
//  name - master_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_monitor_proxy::new(string name = "master_monitor_proxy",uvm_component parent);
  super.new(name, parent);
  
  master_analysis_port = new("master_analysis_port",this);

endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db#(virtual master_monitor_bfm)::get(this,"","master_monitor_bfm",master_mon_bfm_h)) begin
     `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in master_Monitor_proxy"));  
  end 
  
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
// MSHA:function void master_monitor_proxy::connect_phase(uvm_phase phase);
// MSHA:
// MSHA: 
// MSHA:endfunction : connect_phase

//--------------------------------------------------------------------------------------------
//  Function: end_of_elaboration_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  master_mon_bfm_h.master_mon_proxy_h = this;
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
//  Function: start_of_simulation_phase
//  <Description_here>
//
//  // TODO(mshariff): Have a way to print the struct values
//  // master_spi_seq_item_converter::display_struct(packet);
//  // string s;
//  // s = master_spi_seq_item_converter::display_struct(packet);
//  // `uvm_info(get_type_name(), $sformatf("Packet to drive : \n %s", s), UVM_HIGH);
//
//  case ({master_agent_cfg_h.spi_mode, master_agent_cfg_h.shift_dir})
//
//    {CPOL0_CPHA0,MSB_FIRST}: master_mon_bfm_h.drive_the_miso_data();
//
//  endcase
//
//endtask: read_from_bfm

//--------------------------------------------------------------------------------------------
// Function reset_detected
// This task detect the system reset appliction
//--------------------------------------------------------------------------------------------
function void master_monitor_proxy::reset_detected();
  `uvm_info(get_type_name(), $sformatf("System reset is detected"), UVM_NONE);

  // TODO(mshariff): 
  // Clear the data queues and kill the required threads
endfunction: reset_detected


//--------------------------------------------------------------------------------------------
// Task: run_phase
// Calls tasks defined in master_Monitor_BFM 
//--------------------------------------------------------------------------------------------
task master_monitor_proxy::run_phase(uvm_phase phase);
  master_tx master_packet;

  `uvm_info(get_type_name(), $sformatf("Inside the master_monitor_proxy"), UVM_LOW);

  master_packet = master_tx::type_id::create("master_packet");

  // Wait for system reset
  master_mon_bfm_h.wait_for_system_reset();

  // Wait for the IDLE state of SPI interface
  master_mon_bfm_h.wait_for_idle_state();

  // Driving logic
  forever begin
    spi_transfer_char_s struct_packet;
    spi_transfer_cfg_s struct_cfg;

    master_tx master_clone_packet;

    // Wait for transfer to start
    master_mon_bfm_h.wait_for_transfer_start();

    // TODO(mshariff): Have a way to print the struct values
    // master_spi_seq_item_converter::display_struct(packet);
    // string s;
    // s = master_spi_seq_item_converter::display_struct(packet);
    // `uvm_info(get_type_name(), $sformatf("Packet to drive : \n %s", s), UVM_HIGH);

    master_spi_cfg_converter::from_class(master_agent_cfg_h, struct_cfg); 

    master_mon_bfm_h.sample_data(struct_packet, struct_cfg);

    master_spi_seq_item_converter::to_class(struct_packet, master_packet);

   `uvm_info(get_type_name(),$sformatf("Received packet from MASTER MONITOR BFM : , \n %s",
                                        master_packet.sprint()),UVM_HIGH)

    // Clone and publish the cloned item to the subscribers
    $cast(master_clone_packet, master_packet.clone());
    `uvm_info(get_type_name(),$sformatf("Sending packet via analysis_port : , \n %s",
                                        master_clone_packet.sprint()),UVM_HIGH)
    master_analysis_port.write(master_clone_packet);

  end
endtask : run_phase 

//-------------------------------------------------------
// Task : Read
// Captures the MOSI and MISO data sampled.
//-------------------------------------------------------
//task master_monitor_proxy::read(bit [DATA_WIDTH-1:0]data_mosi,
//                               bit [DATA_WIDTH-1:0]data_miso,
//                               bit [DATA_WIDTH-1:0]count);
task master_monitor_proxy::read(spi_transfer_char_s data_packet);
  
 // if(count >= DATA_WIDTH && count >= DATA_WIDTH ) begin
 //   `uvm_info(get_type_name(), $sformatf("MOSI is = %d",data_mosi), UVM_LOW);
 //   `uvm_info(get_type_name(), $sformatf("MISO is = %d",data_miso), UVM_LOW);     
 // end
 // else begin
 //   `uvm_error(get_type_name(),"Either MOSI data or MISO data is less than the charachter length mentioned");
 // end
 

  //master_tx master_tx_h;
  //master_tx_h = master_tx::type_id::create("master_tx_h");
  master_spi_seq_item_converter master_spi_seq_item_conv_h;
  //master_spi_seq_item_conv_h = master_spi_seq_item_converter::type_id::create("master_spi_seq_item_conv_h");
  //master_spi_seq_item_conv_h.to_class(master_tx_h,data_packet);
  //ap.write(master_tx_h);
                            
endtask : read

`endif

