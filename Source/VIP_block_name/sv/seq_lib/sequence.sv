class reset_seq extends uvm_sequence #(my_item);
  `uvm_object_utils(reset_seq)
  my_item m_trans;
  virtual my_intf vif;
  
  function new(string name = "reset_seq");
    super.new(name);
  endfunction
  
  task body;
    if (!uvm_config_db #(virtual my_intf)::get(null, "", "vif", vif))
      `uvm_fatal(get_type_name(), "No virtual interface in config_db!")
      
     m_trans = my_item::type_id::create("m_trans");
    `uvm_info(get_type_name(), "------ RESET SEQUENCE STARTS ------", UVM_LOW);
    start_item(m_trans);
     vif.i_reset = 1;
    finish_item(m_trans);
    
    repeat(2) @(posedge vif.i_clk);
    vif.i_reset = 0;
    `uvm_info(get_type_name(), "------ Reset become low -----", UVM_LOW);
  endtask
endclass

class my_seq_1 extends uvm_sequence #(my_item);
  `uvm_object_utils(my_seq_1)
  my_item m_trans;
  
  function new(string name = "my_seq_1");
    super.new(name);
  endfunction
  
  task body;
    m_trans = my_item::type_id::create("m_trans");
    
    start_item(m_trans);
    m_trans.i_J = 4'd2;
    m_trans.i_XTS_START = 1;
    m_trans.i_SECTOR = 128'h00000000_00000000_00000000_00000000;
    m_trans.i_XTS_PLAINTEXT = 256'h00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000;
    m_trans.i_KEY_1 = 128'h00000000_00000000_00000000_00000000;
    m_trans.i_KEY_2 = 128'h00000000_00000000_00000000_00000000;
    
    finish_item(m_trans);
  endtask
endclass

class my_seq_2 extends uvm_sequence #(my_item);
  `uvm_object_utils(my_seq_2)
  my_item m_trans;
  
  function new(string name = "my_seq_2");
    super.new(name);
  endfunction
  
  task body;
    m_trans = my_item::type_id::create("m_trans");
    
    start_item(m_trans);
    
    m_trans.i_J = 4'd2;
    m_trans.i_XTS_START = 1;
    m_trans.i_SECTOR = 128'h33333333_33000000_00000000_00000000;
    m_trans.i_XTS_PLAINTEXT = 256'h44444444_44444444_44444444_44444444_44444444_44444444_44444444_44444444;
    m_trans.i_KEY_1 = 128'h11111111_11111111_11111111_11111111;
    m_trans.i_KEY_2 = 128'h22222222_22222222_22222222_22222222;
    
    finish_item(m_trans);
  endtask
endclass

class my_seq_3 extends uvm_sequence #(my_item);
  `uvm_object_utils(my_seq_3)
  my_item m_trans;
  
  function new(string name = "my_seq_3");
    super.new(name);
  endfunction
  
  task body;
    m_trans = my_item::type_id::create("m_trans");
    
    start_item(m_trans);
    
    m_trans.i_J = 4'd2;
    m_trans.i_XTS_START = 1;
    m_trans.i_SECTOR = 128'h33333333_33000000_00000000_00000000;
    m_trans.i_XTS_PLAINTEXT = 256'h44444444_44444444_44444444_44444444_44444444_44444444_44444444_44444444;
    m_trans.i_KEY_1 = 128'hfffefdfc_fbfaf9f8_f7f6f5f4_f3f2f1f0;
    m_trans.i_KEY_2 = 128'h22222222_22222222_22222222_22222222;
    
    finish_item(m_trans);
  endtask
endclass

class random_seq extends uvm_sequence #(my_item);
  `uvm_object_utils(random_seq)
  
  my_item m_trans;

  function new(string name = "random_seq");
    super.new(name);
  endfunction

  task body();
    repeat (100) begin
      m_trans = my_item::type_id::create("m_trans");
      
      start_item(m_trans);
      assert(m_trans.randomize());
      m_trans.i_J = 4'd2;
      m_trans.i_XTS_START = 1;
      finish_item(m_trans);
    end
  endtask
endclass
