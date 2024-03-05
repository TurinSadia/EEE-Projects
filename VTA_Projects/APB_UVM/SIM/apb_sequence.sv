class apb_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(apb_seq)
    
 //virtual apb_interface INTF;
  
 OPERATION opp;
 rand DATA_VAL pwdata;
  //READ_VAL prdata;
 rand ADDR_VAL paddr;
apb_seq_item item;
  function new(string name="apb_seq");
    super.new(name);
  endfunction
 
  
  
//   virtual task body();
    
//   endtask:body

endclass:apb_seq



//-------------CLASS: RESET SEQUENCE-----------------------


class reset_seq extends apb_seq;
   `uvm_object_utils(reset_seq)
   apb_seq_item item;
  
    function new(string name="reset_seq");
    super.new(name);
  endfunction

  virtual task body();
    item= apb_seq_item::type_id::create("item");
    
    start_item(item);
	item.opp=RESET;
    finish_item(item);
    
  endtask:body
  
endclass:reset_seq


//-------------CLASS: IDLE SEQUENCE-----------------------

class idle_seq extends apb_seq;
  `uvm_object_utils(idle_seq)
   apb_seq_item item;
  
  function new(string name="idle_seq");
    super.new(name);
  endfunction

  virtual task body();
    item= apb_seq_item::type_id::create("item");
    
    start_item(item);
	item.opp=IDLE;
    finish_item(item);
    
  endtask:body
  
endclass:idle_seq


//-------------CLASS: WRITE SEQUENCE-----------------------

class write_seq extends apb_seq;
  `uvm_object_utils(write_seq)
   apb_seq_item item;
  
  function new(string name="write_seq");
    super.new(name);
  endfunction

  virtual task body();
    item= apb_seq_item::type_id::create("item");
    
    start_item(item);
    item.paddr=paddr;
    item.pwdata=pwdata;
	item.opp=WRITE;
    finish_item(item);
    
  endtask:body
  
endclass:write_seq


//-------------CLASS: READ SEQUENCE-----------------------

class read_seq extends apb_seq;
  `uvm_object_utils(read_seq)
   apb_seq_item item;
  
  
  function new(string name="write_seq");
    super.new(name);
  endfunction

  virtual task body();
    item= apb_seq_item::type_id::create("item");
    
    start_item(item);
    item.paddr=paddr;
	item.opp=READ;
    finish_item(item);
    
  endtask:body
  
endclass:read_seq