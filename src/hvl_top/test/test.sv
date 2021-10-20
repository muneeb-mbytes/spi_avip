class test extends uvm_test;
`uvm_component_utils(test)
 
uvm_table_printer printer;
//env env_h;

function new(input string inst = "TEST", uvm_component c);
  super.new(inst, c);
endfunction
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
printer = new();
//env_h = env::type_id::create("env_h",this);
endfunction
  
  task run();
      
  endtask
                     
endclass


class spi_fd_8b_test extends test;
  
 `uvm_component_utils(spi_fd_8b_test)
  spi_fd_8b_seq  m_spi_fd_8b;
  spi_fd_8b_seq  s_spi_fd_8b;

function new(input string inst = "TEST1", uvm_component c);
  super.new(inst, c);
endfunction
 
function void build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction

 function void end_of_elaboration_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $psprintf("SPI VIP hierarchy is %s", this.sprint(printer)), UVM_NONE);
   endfunction


 task run_phase(uvm_phase phase);
   
m_spi_fd_8b=spi_fd_8b_seq::type_id::create("m_spi_fd_8b");
s_spi_fd_8b=spi_fd_8b_seq::type_id::create("s_spi_fd_8b");
         phase.raise_objection(this);
  //    assert(seq.randomize());
  //    seq.print();
   fork
 //  m_spi_fd_8b.start(env_h.ma_h.m_sqr_h);
  // s_spi_fd_8b.start(env_h.sa_h.s_sqr_h);
   join  
     
        phase.drop_objection(this);
  endtask
endclass
    
        
