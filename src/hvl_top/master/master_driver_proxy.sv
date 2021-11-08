`ifndef MASTER_DRIVER_PROXY_INCLUDED_
`define MASTER_DRIVER_PROXY_INCLUDED_
    
//--------------------------------------------------------------------------------------------
//  Class: master_driver_proxy
//  Description of the class
//  Driver is written by extending uvm_driver,uvm_driver is inherited from uvm_component, 
//  Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
//  uvm_driver is a parameterized class and it is parameterized with the type of the request 
//  sequence_item and the type of the response sequence_item 
//--------------------------------------------------------------------------------------------
class master_driver_proxy extends uvm_driver#(master_tx);
  `uvm_component_utils(master_driver_proxy)
  
  master_tx tx;

  virtual master_driver_bfm master_drv_bfm_h;
   
  // Variable: master_agent_cfg_h
  // Declaring handle for master agent config class 
  master_agent_config master_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_driver_proxy", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive_to_bfm(spi_transfer_char_s packet, spi_transfer_cfg_s packet1);
  extern virtual function void reset_detected();

endclass : master_driver_proxy

//--------------------------------------------------------------------------------------------
//  Construct: new
//
//  Parameters:
//  name - master_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_driver_proxy::new(string name = "master_driver_proxy",uvm_component parent);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual master_driver_bfm)::get(this,"","master_driver_bfm",master_drv_bfm_h)) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_MASTER_DRIVER_BFM","cannot get() master_drv_bfm_h");
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
//  Function: end_of_elaboration_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  master_drv_bfm_h.master_drv_proxy_h = this;
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
//  Function: start_of_simulation_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void master_driver_proxy::start_of_simulation_phase(uvm_phase phase);
//  super.start_of_simulation_phase(phase);
//endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Gets the sequence_item, converts them to struct compatible transactions
// and sends them to the BFM to drive the data over the interface
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task master_driver_proxy::run_phase(uvm_phase phase);

  bit cpol, cpha;

  super.run_phase(phase);
  //`uvm_info(get_type_name(),"Hey ! It's master dirver proxy-RUN PHASE",UVM_LOW)
  // TODO(mshariff): Decide one among this
  // $cast(cpol_cpha, master_agent_cfg_h.spi_mode);
  //{cpol,cpha} = operation_modes_e'(master_agent_cfg_h.spi_mode);
  cpol = operation_modes_e'(master_agent_cfg_h.spi_mode);

  // Wait for system reset
  master_drv_bfm_h.wait_for_reset();

  //`uvm_info(get_type_name(),"Waiting for Reset",UVM_LOW)
  // Drive the IDLE state for SPI interface
  master_drv_bfm_h.drive_idle_state(cpol);

  //`uvm_info(get_type_name(),"Driving Idle State",UVM_LOW)
  // Driving logic
  forever begin
    spi_transfer_char_s struc_packet;
    spi_transfer_cfg_s struct_cfg;

    //`uvm_info(get_type_name(),"Calling get next item",UVM_LOW)
    //tx = new();
    //tx.master_out_slave_in = new [2];
    //`uvm_info(get_type_name(),$sformatf("MASTER_TX = \n %s", tx.sprint),UVM_LOW)
    seq_item_port.get_next_item(req);
    //`uvm_info(get_type_name(),$sformatf("Received packet from master seqeuncer : , \n %s",
    //                                    req.sprint),UVM_LOW);

    // Wait for IDLE state on SPI interface
    master_drv_bfm_h.wait_for_idle_state();

    // MSHA:1010_1011 (AB)

    // MSHA:LSB first - 1 1 0 1 0 1 0 1 
    // MSHA:MSB FIrts - 1 0 1 0 1 0 1 1
    // MSHA:
    // MSHA:req.mosi_data = AB;

    // MSHA:converting to struct 

    // MSHA:bit[no_of_bits_transfer-1:0] mosi_s;

    // MSHA:if(MSB_FIRST)
    // MSHA:  D5
    // MSHA:  mosi_s = flip_version_of(req.mosi_data);

    // MSHA:// LSB First
    // MSHA:for(int i=0; i< no_of_mosi_bits_transfer; i++) begin
    // MSHA:  mosi_dat[i]
    // MSHA:end

    master_spi_seq_item_converter::from_class(req, struc_packet); 
    drive_to_bfm(struc_packet, struct_cfg);
    master_spi_seq_item_converter::to_class(struc_packet, req);
    
    
    `uvm_info(get_type_name(),$sformatf("STRUCT PACKET : , \n %p",struc_packet),UVM_LOW);

    seq_item_port.item_done();
  end
endtask : run_phase

//--------------------------------------------------------------------------------------------
// Task: drive_to_bfm
// This task converts the transcation data packet to struct type and send
// it to the master_driver_bfm
//--------------------------------------------------------------------------------------------
task master_driver_proxy::drive_to_bfm(spi_transfer_char_s packet,spi_transfer_cfg_s packet1);

  // TODO(mshariff): Have a way to print the struct values
  // master_spi_seq_item_converter::display_struct(packet);
  // string s;
  // s = master_spi_seq_item_converter::display_struct(packet);
  // `uvm_info(get_type_name(), $sformatf("Packet to drive : \n %s", s), UVM_HIGH);

  //case ({master_agent_cfg_h.spi_mode, master_agent_cfg_h.shift_dir})
    //{CPOL0_CPHA0,MSB_FIRST}: begin  
  master_drv_bfm_h.drive_msb_first_pos_edge(packet,packet1); 

      // MSHA:if (master_agent_cfg_h.shift_dir == MSB_FIRST) begin
      // MSHA:  master_drv_bfm_h.drive_msb_first_pos_edge(data);
      // MSHA:  master_drv_bfm_h.drive_msb_first_neg_edge(data);
      // MSHA:end
      // MSHA:
      // MSHA:else if (master_agent_cfg_h.shift_dir == LSB_FIRST) begin
      // MSHA:  master_drv_bfm_h.drive_lsb_first_pos_edge(data);
      // MSHA:  master_drv_bfm_h.drive_lsb_first_neg_edge(data);
      // MSHA:end

    // MSHA:CPOL0_CPHA1:
    // MSHA:  if (master_agent_cfg_h.shift_dir == MSB_FIRST) begin
    // MSHA:    master_drv_bfm_h.drive_msb_first_pos_edge(data);
    // MSHA:    master_drv_bfm_h.drive_msb_first_neg_edge(data);
    // MSHA:  end
    // MSHA:  
    // MSHA:  else if (master_agent_cfg_h.shift_dir == LSB_FIRST) begin
    // MSHA:    master_drv_bfm_h.drive_lsb_first_pos_edge(data);
    // MSHA:    master_drv_bfm_h.drive_lsb_first_neg_edge(data);
    // MSHA:  end

    // MSHA:CPOL1_CPHA0:
    // MSHA:  if (master_agent_cfg_h.shift_dir == MSB_FIRST) begin
    // MSHA:    master_drv_bfm_h.drive_msb_first_pos_edge(data);
    // MSHA:    master_drv_bfm_h.drive_msb_first_neg_edge(data);
    // MSHA:  end
    // MSHA:  
    // MSHA:  else if (master_agent_cfg_h.shift_dir == LSB_FIRST) begin
    // MSHA:    master_drv_bfm_h.drive_lsb_first_pos_edge(data);
    // MSHA:    master_drv_bfm_h.drive_lsb_first_neg_edge(data);
    // MSHA:  end

    // MSHA:CPOL1_CPHA1:
    // MSHA:  if (master_agent_cfg_h.shift_dir == MSB_FIRST) begin
    // MSHA:    master_drv_bfm_h.drive_msb_first_pos_edge(data);
    // MSHA:    master_drv_bfm_h.drive_msb_first_neg_edge(data);
    // MSHA:  end
    // MSHA:  
    // MSHA:  else if (master_agent_cfg_h.shift_dir == LSB_FIRST) begin
    // MSHA:    master_drv_bfm_h.drive_lsb_first_pos_edge(data);
    // MSHA:    master_drv_bfm_h.drive_lsb_first_neg_edge(data);
    // MSHA:  end

//   CPOL0_CPHA0: drive_cpol_0_cpha_0(data);
//   CPOL0_CPHA1: drive_cpol_0_cpha_1(data);
//   CPOL1_CPHA0: drive_cpol_1_cpha_0(data);
//   CPOL1_CPHA1: drive_cpol_1_cpha_1(data);
  //endcase

endtask: drive_to_bfm

//--------------------------------------------------------------------------------------------
// Function reset_detected
// This task detect the system reset appliction
//--------------------------------------------------------------------------------------------
function void master_driver_proxy::reset_detected();
  `uvm_info(get_type_name(), $sformatf("System reset is detected"), UVM_NONE);

  // TODO(mshariff): 
  // Clear the data queues and kill the required threads
endfunction: reset_detected

`endif
