class apb_seq_item extends uvm_sequence_item;
  `uvm_object_utils( apb_seq_item)


  bit rst_n;

  //For Input pins
  bit psel,pwrite,penable;
  logic [addrWidth-1:0] paddr;
  logic [dataWidth-1:0] pwdata;

  //For Output pins 
  logic pready,pslverr;
  logic [dataWidth-1:0] prdata;
  
  OPERATION opp;

  
  function new(string name="apb_seq_item");
    super.new(name);
  endfunction



endclass