class test extends uvm_test;
`uvm_component_utils(test)
 
uvm_table_printer printer;

function new(input string inst = "TEST", uvm_component c);
  super.new(inst, c);
endfunction
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
printer = new();
endfunction
  
  task run();
      
  endtask
                     
endclass


class M_SPI_FD_8b_tst extends test;
  
 `uvm_component_utils(M_SPI_FD_8b_tst)


function new(input string inst = "TEST1", uvm_component c);
  super.new(inst, c);
endfunction
 
function void build_phase(uvm_phase phase);
super.build_phase(phase);
  endfunction

 function void end_of_elaboration_phase(uvm_phase phase);
//  `uvm_info(get_type_name(), $psprintf("SPI VIP hierarchy is %s", this.sprint(printer)), UVM_NONE);
   endfunction


 task run_phase(uvm_phase phase);
   M_SPI_FD_8b seq;
       seq = M_SPI_FD_8b::type_id::create("seq");
         phase.raise_objection(this);
      assert(seq.randomize());
                   phase.drop_objection(this);
  endtask
endclass
    
        
