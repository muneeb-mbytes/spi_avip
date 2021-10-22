  `ifndef SLAVE_VIRTUAL_SEQUENCE_INCLUDED_
  `define SLAVE_VIRTUAL_SEQUENCE_INCLUDED_

  //--------------------------------------------------------------------------------------------
  // Class: slave_virtual_sequence
  // Description of the class
  // this class contains transactions
  //--------------------------------------------------------------------------------------------
  class slave_virtual_sequence extends uvm_sequence #(slave_tx);

  //register with factory so can use create uvm_methods
  //and override in future if neccessary

  `uvm_object_utils(slave_virtual_sequence)

   env_config e_cfg_h;

  //declaring handles for slave extended class
  slave_sequencer s_sqr_h[];
  slave_virtual_sequencer sv_sqr_h;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_virtual_sequence");
  extern task body();

  endclass : slave_virtual_sequence

  //--------------------------------------------------------------------------------------------
  // Construct: new
  // initialize the slave_mon class object
  //
  // Parameters:
  //  name - instance name of the  slave_virtual_sequence
  //  parent - parent under which this component is created
  //--------------------------------------------------------------------------------------------
  function slave_virtual_sequence::new(string name = "slave_virtual_sequence");
    super.new(name);
  endfunction : new
  
  //-------------------------------------------------------
  //task :body
  //creates the required ports
  //
  //parameters:
  //phase -stores the current phase
  //-------------------------------------------------------

  task slave_virtual_sequence::body();
    if(!uvm_config_db #(env_config)::get(null,get_full_name(),"ENV_CONFIG",e_cfg_h))
      `uvm_error("VSEQ","COULDNT GET")
      
      s_sqr_h = new[e_cfg_h.no_of_slaves];
      
      if(!$cast(sv_sqr_h,m_sequencer))  
        `uvm_error("VSEQ","COULDNT CAST")
        
          foreach(s_sqr_h[i])
            s_sqr_h[i]=sv_sqr_h.s_sqr_h[i];
    

  endtask:body



class seq_one extends slave_virtual_sequence;

  `uvm_object_utils(seq_one)

  slave_sequence s_seq;
  
  function new(string name="seq_one");
    super.new(name);
  endfunction
  
  task body;
    super.body;

s_seq = slave_sequence::type_id::create("s_seq");

s_seq.start(s_sqr_h[0]);

endtask


endclass



`endif






