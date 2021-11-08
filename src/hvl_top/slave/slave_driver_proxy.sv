`ifndef SLAVE_DRIVER_PROXY_INCLUDED_
`define SLAVE_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: slave_driver_proxy
//  This is the proxy driver on the HVL side
//  It receives the transactions and converts them to task calls for the HDL driver
//--------------------------------------------------------------------------------------------
class slave_driver_proxy extends uvm_driver#(slave_tx);
  `uvm_component_utils(slave_driver_proxy)
//  slave_tx tx;

  // Variable: slave_driver_bfm_h;
  // Handle for slave driver bfm
  virtual slave_driver_bfm slave_drv_bfm_h;

  //  slave_spi_seq_item_converter  slave_spi_seq_item_conv_h;

  // Variable: slave_agent_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config slave_agent_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive_to_bfm(spi_transfer_char_s packet, spi_transfer_cfg_s struct_cfg);
  extern virtual function void reset_detected();

endclass : slave_driver_proxy

//--------------------------------------------------------------------------------------------
//  Construct: new
//  Initializes memory for new object
//
//  Parameters:
//  name - slave_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_driver_proxy::new(string name = "slave_driver_proxy", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//  Slave_driver_bfm congiguration is obtained in build phase
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(virtual slave_driver_bfm)::get(this,"","slave_driver_bfm",slave_drv_bfm_h)) begin
    `uvm_fatal("FATAL_SDP_CANNOT_GET_SLAVE_DRIVER_BFM","cannot get() slave_drv_bfm_h");
  end

  //  slave_spi_seq_item_conv_h = slave_spi_seq_item_converter::type_id::create("slave_spi_seq_item_conv_h");
endfunction : build_phase

//--------------------------------------------------------------------------------------------
//  Function: connect_phase
//  Connects driver_proxy and driver_bfm
//
//  Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
//  slave_drv_bfm_h = slave_agent_cfg_h.slave_drv_bfm_h;
endfunction : connect_phase

//-------------------------------------------------------
//Function: end_of_elaboration_phase
//Description: connects driver_proxy and driver_bfm
//
// Parameters:
//  phase - stores the current phase
//-------------------------------------------------------
function void slave_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  slave_drv_bfm_h.slave_drv_proxy_h = this;
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
//  Function: start_of_simulation_phase
//  <Description_here>
//
//  Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void slave_driver_proxy::start_of_simulation_phase(uvm_phase phase);
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
task slave_driver_proxy::run_phase(uvm_phase phase);
  bit cpol, cpha;

  super.run_phase(phase);

  // TODO(mshariff): Decide one among this
  // $cast(cpol_cpha, slave_agent_cfg_h.spi_mode);
  {cpol,cpha} = operation_modes_e'(slave_agent_cfg_h.spi_mode);

  // Wait for system reset
  slave_drv_bfm_h.wait_for_reset();

//  // Drive the IDLE state for SPI interface
//  slave_drv_bfm_h.drive_idle_state(cpol);

  // Driving logic
  forever begin
    spi_transfer_char_s struct_packet;
    spi_transfer_cfg_s struct_cfg;

    seq_item_port.get_next_item(req);
    `uvm_info(get_type_name(),$sformatf("Received packet from slave seqeuncer : , \n %s",
                                        req.sprint()),UVM_LOW)

//  // Wait for IDLE state on SPI interface
//    slave_drv_bfm_h.wait_for_idle_state();

    slave_spi_seq_item_converter::from_class(req, struct_packet); 
    drive_to_bfm(struct_packet, struct_cfg);
    slave_spi_seq_item_converter::to_class(struct_packet, req);
    `uvm_info(get_type_name(),$sformatf("STRUCT PACKET : , \n %p",
                                        struct_packet),UVM_LOW)

    seq_item_port.item_done();
  end
endtask : run_phase

//--------------------------------------------------------------------------------------------
// Task: drive_to_bfm
// This task converts the transcation data packet to struct type and send
// it to the slave_driver_bfm
//--------------------------------------------------------------------------------------------
task slave_driver_proxy::drive_to_bfm(spi_transfer_char_s packet, spi_transfer_cfg_s struct_cfg);

  // TODO(mshariff): Have a way to print the struct values
  // slave_spi_seq_item_converter::display_struct(packet);
  // string s;
  // s = slave_spi_seq_item_converter::display_struct(packet);
  // `uvm_info(get_type_name(), $sformatf("Packet to drive : \n %s", s), UVM_HIGH);

//  case ({slave_agent_cfg_h.spi_mode, slave_agent_cfg_h.shift_dir})

   // {CPOL0_CPHA0,MSB_FIRST}: slave_drv_bfm_h.drive_the_miso_data(packet,struct_cfg);
    
   slave_drv_bfm_h.drive_the_miso_data(packet,struct_cfg);

//  endcase

endtask: drive_to_bfm

//--------------------------------------------------------------------------------------------
// Function reset_detected
// This task detect the system reset appliction
//--------------------------------------------------------------------------------------------
function void slave_driver_proxy::reset_detected();
  `uvm_info(get_type_name(), "System reset is detected", UVM_NONE);

  // TODO(mshariff): 
  // Clear the data queues and kill the required threads
endfunction: reset_detected

`endif

