`ifndef MASTER_COVERAGE_INCLUDED_
`define MASTER_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_coverage
// master_coverage determines the how much code is covered for better functionality of the TB.
//--------------------------------------------------------------------------------------------
class master_coverage extends uvm_subscriber#(master_tx);
  `uvm_component_utils(master_coverage)

  // Variable: master_agent_cfg_h
  // Declaring handle for master agent configuration class 
    master_agent_config master_agent_cfg_h;
 
  //-------------------------------------------------------
  // Covergroup
  // // TODO(mshariff): Add comments
  // Covergroup consists of the various coverpoints based on the no. of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup master_covergroup with function sample (master_agent_config cfg, master_tx packet);
    option.per_instance = 1;

    // Mode of the operation

    // {cpol,cpha} = operation_modes_e'(cfg.spi_mode);
    OPERATION_MODE_CP : coverpoint operation_modes_e'(cfg.spi_mode) {
      option.comment = "Operation mode SPI. CPOL and CPHA";
      // TODO(mshariff): 
       bins MODE[] = {[0:3]};
      // bins cpol0_cpha0 = 0;
      // bins cpol0_cpha1 = 1;
      // bins cpol1_cpha0 = 2;
      // bins cpol1_cpha1 = 3;
    }

    // Chip-selcet to first SCLK-edge delay
    C2T_DELAY_CP : coverpoint cfg.c2tdelay {
      option.comment = "Delay betwen CS assertion to first SCLK edge";
      // TODO(mshariff): 
       bins DELAY_1 = {1};
       bins DELAY_2 = {2};
       bins DELAY_3 = {3};
       bins DELAY_4_to_10 = {[4:10]};
    
       illegal_bins illegal_bin = {0};
     } 
//     // Chip-selcet to first SCLK-edge delay 
    T2C_DELAY_CP : coverpoint cfg.t2cdelay {
      option.comment = "Delay betwen last SCLK to the CS assertion";
      // TODO(mshariff): 
       bins DELAY_1 = {1};
       bins DELAY_2 = {2};
       bins DELAY_3 = {3};
       bins DELAY_4_TO_10 = {[4:10]};
    
     }

    W_DELAY_CP : coverpoint cfg.wdelay {
      option.comment = "Delay between two transfer";
      bins W_DELAY_1 = {1}; 
      bins W_DELAY_2 = {2}; 
      bins W_DELAY_3 = {3}; 
      bins W_DELAY_MAX = {[4:MAXIMUM_BITS]}; 
    } 
     // direction = shift_direction_e'(cfg.spi_mode); 
    SHIFT_DIRECTION_CP : coverpoint shift_direction_e'(cfg.shift_dir) {
      option.comment = "Shift direction SPI. MSB and LSB";
      bins LSB_FIRST = {0};
      bins MSB_FIRST = {1};
    } 
    
    CS_CP : coverpoint packet.cs{
      option.comment = "Chip select assign one slave based on config"; 
      bins SLAVE_0 = {0};
      //bins SLAVE_1 ={1};
      //bins SLAVE_2 ={2};
      //bins SLAVE_3 ={3};
    }
    
    
    
    MOSI_DATA_TRANSFER_CP : coverpoint packet.master_out_slave_in.size()*CHAR_LENGTH {
      option.comment = "Data size of the packet transfer";
      bins TRANSFER_8BIT = {8};
      bins TRANSFER_16BIT = {16};
      bins TRANSFER_24BIT = {24};
      bins TRANSFER_32BIT = {32};
      bins TRANSFER_64BIT = {64};
      bins TRANSFER_MANY_BITS = {[72:MAXIMUM_BITS]};
    } 
    MISO_DATA_TRANSFER_CP : coverpoint packet.master_in_slave_out.size()*CHAR_LENGTH {
      option.comment = "Data size of the packet transfer";
      bins TRANSFER_8BIT = {8};
      bins TRANSFER_16BIT = {16};
      bins TRANSFER_24BIT = {24};
      bins TRANSFER_32BIT = {32};
      bins TRANSFER_64BIT = {64};
      bins TRANSFER_MANY_BITS = {[72:MAXIMUM_BITS]};
    } 



    //If the pclk is 10mhz and the baudrate_divisor is 2 then the sclk will be 5mhz.
    
      BAUD_RATE_CP : coverpoint cfg.get_baudrate_divisor() {
      option.comment = "it control the rate of transfer in communication channel";
     
      bins BAUDRATE_DIVISOR_1 = {2}; 
      bins BAUDRATE_DIVISOR_2 = {4}; 
      bins BAUDRATE_DIVISOR_3 = {6}; 
      bins BAUDRATE_DIVISOR_4 = {8}; 
      bins BAUDRATE_DIVISOR_5 = {[8:$]}; 

       illegal_bins illegal_bin = {0};

//      // need to add bins for baud rate
//      TODO
//      to have a bins for the baud rate for the 4,6,8,and more
//
    }

    //CROSS OF THE CFG AND THE PACKET WITH MULTIPLE COVERPOINT.
    //Cross of the OPERATION_MODE with and the CS,DATA_WIDTH,master_out_slave_in,master_in_slave_out
    //cross of the operation mode with the all type of the delays
      OPERATION_MODE_CP_X_C2T_DELAY_CP : cross OPERATION_MODE_CP,C2T_DELAY_CP;
      OPERATION_MODE_CP_X_T2C_DELAY_CP : cross OPERATION_MODE_CP,T2C_DELAY_CP;
      OPERATION_MODE_CP_X_W_DELAY_CP : cross OPERATION_MODE_CP,W_DELAY_CP;

      //cross of the mosi_data_trasfer_cp with shift direction and the operation mode  and the delays
      MOSI_DATA_TRANSFER_CP_X_SHIFT_DIRECTION_CP : cross MOSI_DATA_TRANSFER_CP,SHIFT_DIRECTION_CP;
      MOSI_DATA_TRANSFER_CP_X_OPERATION_MODE_CP : cross MOSI_DATA_TRANSFER_CP,OPERATION_MODE_CP;
      MOSI_DATA_TRANSFER_CP_X_C2T_DELAY_CP_X_T2C_DELAY_CP : cross MOSI_DATA_TRANSFER_CP,C2T_DELAY_CP,T2C_DELAY_CP;
      MOSI_DATA_TRANSFER_CP_X_W_DELAY_CP : cross MOSI_DATA_TRANSFER_CP,W_DELAY_CP;
      
      //Cross of the mosi_data_transfer_cp with teh baudrate
      MOSI_DATA_TRANSFER_CP_X_BAUD_RATE_CP : cross MOSI_DATA_TRANSFER_CP,BAUD_RATE_CP;
    
      //cross of the cs_cp with mosi_data_transfer_cp, shift_direction, operation_modeand the delays
      CS_CP_X_MOSI_DATA_TRANSFER_CP : cross CS_CP,MOSI_DATA_TRANSFER_CP;
      CS_CP_X_SHIFT_DIRECTION_CP : cross CS_CP,SHIFT_DIRECTION_CP;
      CS_CP_X_OPERATION_MODE_CP : cross CS_CP,OPERATION_MODE_CP;
      CS_CP_X_C2T_DELAY_CP_X_T2C_DELAY_CP_X_W_DELAY_CP : cross CS_CP,C2T_DELAY_CP,T2C_DELAY_CP,W_DELAY_CP;
    

  endgroup : master_covergroup

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_coverage", uvm_component parent = null);
  //extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);
  extern virtual function void write(master_tx t);
  extern virtual function void report_phase(uvm_phase phase);

endclass : master_coverage


//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_coverage::new(string name = "master_coverage", uvm_component parent = null);
  super.new(name, parent);
  // TODO(mshariff): Create the covergroup
//`uvm_info(get_type_name(),$sformatf(master_cg),UVM_LOW);
//
     master_covergroup = new(); 
//  `uvm_info(get_type_name(),$sformatf(master_cg),UVM_LOW); 
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: write
// // TODO(mshariff): Add comments
// sampiling is done
//--------------------------------------------------------------------------------------------
function void master_coverage::write(master_tx t);
//  // TODO(mshariff): 
  `uvm_info("MUNEEB_DEBUG", $sformatf("Config values = \n %0s", master_agent_cfg_h.sprint()), UVM_HIGH);
   master_covergroup.sample(master_agent_cfg_h,t);     
//   `uvm_info(get_type_name(),$sformatf("master_cg=%0d",master_cg),UVM_LOW);
//
//   `uvm_info(get_type_name(),$sformatf(master_cg),UVM_LOW);
//
endfunction: write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function void master_coverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Master Agent Coverage = %0.2f %%",master_covergroup.get_coverage()), UVM_NONE);
//  `uvm_info(get_type_name(), $sformatf("Master Agent Coverage") ,UVM_NONE);
endfunction: report_phase
`endif

