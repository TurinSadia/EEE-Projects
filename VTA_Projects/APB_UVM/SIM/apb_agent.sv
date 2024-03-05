class apb_agnt extends uvm_agent;
  `uvm_component_utils(apb_agnt)
  
  apb_drvr drvr;
  apb_mntr mntr;
  apb_sqncr sqncr;
  
 
   


  function new(string name="apb_agnt", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    drvr=apb_drvr::type_id::create("drvr",this);
    mntr=apb_mntr::type_id::create("mntr",this);
    sqncr= apb_sqncr::type_id::create("sqncr",this);
  endfunction


  //connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    drvr.seq_item_port.connect(sqncr.seq_item_export);
    
  endfunction


  //run phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask


endclass:apb_agnt