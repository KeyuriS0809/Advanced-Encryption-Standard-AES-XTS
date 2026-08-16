class Multi_Test extends uvm_test;
  `uvm_component_utils(Multi_Test)
  
  Env_config        m_env_cfg;
  my_env            m_env;
  virtual my_intf   vif;
  reset_seq         m_r_seq;
  Multi_Test_seq    m_multi_seq;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    m_env_cfg = Env_config::type_id::create("m_env_cfg");
    
    m_env_cfg.scoreboard_enable = 1;
    m_env_cfg.coverage_enable = 1;
    m_env_cfg.rand_coverage_enable = 0;
    
    uvm_config_db #(Env_config)::set(this, "m_env", "m_env_cfg", m_env_cfg);
      
    if (!uvm_config_db #(virtual my_intf)::get(this, "", "vif", vif))
      `uvm_fatal("TEST", "No virtual interface in config_db!")
      
    m_env = my_env::type_id::create("m_env", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    m_multi_seq = Multi_Test_seq::type_id::create("m_multi_seq");
    
    phase.raise_objection(this); 
    
    m_multi_seq.start(m_env.m_agt.m_seqr);
    
    phase.drop_objection(this);
  endtask
endclass
