class my_env extends uvm_env;
  `uvm_component_utils(my_env);
  
  Env_config       m_env_cfg;
  my_agent         m_agt;
  my_scoreboard    m_scb;
  my_coverage      m_cov;
  random_coverage  m_r_cov;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(Env_config)::get(this, "", "m_env_cfg", m_env_cfg))
      `uvm_fatal(get_type_name(), "Env Config not get in env")
    
    // ---- Create ENV -----
      m_agt = my_agent::type_id::create("m_agt", this);

    //----- Create Scoreboard -------
    if (m_env_cfg.scoreboard_enable == 1)
      m_scb = my_scoreboard::type_id::create("m_scb", this);
    
    //----- Create Coverage -------
    if (m_env_cfg.coverage_enable == 1)
      m_cov = my_coverage::type_id::create("m_cov", this);
    
    //----- Create Random Coverage -------
    if (m_env_cfg.rand_coverage_enable == 1)
      m_r_cov = random_coverage::type_id::create("m_r_cov", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if (m_env_cfg.scoreboard_enable == 1)
      m_agt.m_ap.connect(m_scb.m_actual_export);
    
    if (m_env_cfg.coverage_enable == 1)
      m_agt.m_ap.connect(m_cov.analysis_export);
    
    if (m_env_cfg.rand_coverage_enable == 1)
      m_agt.m_ap.connect(m_r_cov.analysis_export);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_root::get().print_topology();
  endfunction
endclass
