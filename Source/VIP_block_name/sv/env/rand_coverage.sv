class random_coverage extends uvm_subscriber #(my_item);
  `uvm_component_utils(random_coverage)

  random_cg m_rand_cg;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_rand_cg = new();
  endfunction

  virtual function void write(my_item t);

    m_rand_cg.sample(t);
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    `uvm_info(get_type_name(), $sformatf("SECTOR     = %0.2f%%", m_rand_cg.sector_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("KEY1       = %0.2f%%", m_rand_cg.key1_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("KEY2       = %0.2f%%", m_rand_cg.key2_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("PLAINTEXT   = %0.2f%%", m_rand_cg.plaintext_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("CIPHERTEXT  = %0.2f%%", m_rand_cg.ciphertext_cp.get_coverage()), UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("OVERALL     = %0.2f%%", m_rand_cg.get_coverage()), UVM_LOW)
  endfunction

endclass
