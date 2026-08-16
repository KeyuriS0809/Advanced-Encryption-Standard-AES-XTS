class my_coverage extends uvm_subscriber #(my_item);
  `uvm_component_utils(my_coverage)
  
  my_item m_trans;
  aes_xts_cg m_cg;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_cg = new();
  endfunction
  
  virtual function void write(my_item t);
    m_trans = t;
    m_cg.sample(m_trans);
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    `uvm_info(get_type_name(),"============================= COVERAGE SUMMURY ===============================", UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("J        = %0.2f%%", m_cg.block_j_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("SECTOR   = %0.2f%%", m_cg.sector_i_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("KEY1     = %0.2f%%", m_cg.Key1_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("KEY2     = %0.2f%%", m_cg.Key2_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("PLAINTEXT = %0.2f%%", m_cg.plaintext_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("CIPHERTEXT = %0.2f%%", m_cg.ciphertext_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("OVERALL = %0.2f%%", m_cg.get_coverage()), UVM_LOW)
  endfunction

endclass
