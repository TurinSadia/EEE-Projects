class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)
  apb_agnt agnt;
  apb_scb scb;

  function new(string name="apb_env", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
//     if (!uvm_config_db #(apb_env)::get(this, "", "env", env)) begin `uvm_fatal (get_name(),"No configuration object found");
//     end
    agnt=apb_agnt::type_id::create("agnt",this);
    scb=apb_scb::type_id::create("scb",this);
  endfunction


  //connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     agnt.mntr.mntr_port.connect(scb.scb_imp);
  endfunction


  //run phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
   
  endtask


endclass:apb_env