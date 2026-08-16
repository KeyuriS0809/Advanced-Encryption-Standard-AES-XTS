class virtual_sequence extends uvm_sequence #(my_item);
  `uvm_object_utils(virtual_sequence)
  `uvm_declare_p_sequencer(my_sequencer)
  
  my_item         m_trans;
  reset_seq       m_r_seq;
  my_seq_1        m_seq1;
  my_seq_2        m_seq2;
  my_seq_3        m_seq3;
  random_seq      m_rand_seq;

  function new(string name = "virtual_sequence");
    super.new(name);
  endfunction

  task body();
    m_r_seq = reset_seq::type_id::create("m_r_seq");
    
    // ------- Start Reset Sequence ---------
    m_r_seq.start(p_sequencer);
  endtask
endclass

class Multi_Test_seq extends virtual_sequence;
  `uvm_object_utils(Multi_Test_seq)

  function new (string name = "Multi_Test_seq");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    m_seq1 = my_seq_1::type_id::create("m_seq1");
    m_seq2 = my_seq_2::type_id::create("m_seq2");
    m_seq3 = my_seq_3::type_id::create("m_seq3");
    
    fork
      m_seq1.start(p_sequencer);
      m_seq2.start(p_sequencer);
      m_seq3.start(p_sequencer);
    join
    
  endtask
endclass

class Random_Test_seq extends virtual_sequence;
  `uvm_object_utils(Random_Test_seq)

  function new (string name = "Random_Test_seq");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    m_rand_seq = random_seq::type_id::create("m_rand_seq");   
    m_rand_seq.start(p_sequencer);   
  endtask
endclass
