class apb_sqncr extends uvm_sequencer #( apb_seq_item);
  `uvm_component_utils(apb_sqncr)
  
   //apb_seq_item item;
 

  function new(string name="apb_sqncr", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //item= apb_seq_item::type_id::create("item");
    $display($time,"ns ||[SEQUENCER] SEQUENCER READY TO DRIVE SEQ_ITEM ");

  endfunction

  //connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction


  //run phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask


endclass:apb_sqncr