class my_driver extends uvm_driver #(my_item);
  `uvm_component_utils(my_driver)
  virtual my_intf vif;
  my_item m_trans;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual my_intf)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "No virtual interface in config_db!")
  endfunction

  task run_phase(uvm_phase phase);
    
    forever begin
      seq_item_port.get_next_item(m_trans);
      
      if (vif.i_reset) begin
        `uvm_info(get_type_name(), $sformatf("Reset = %0d detected HIGH in driver",vif.i_reset), UVM_LOW)
        vif.i_XTS_START      <= 0;
        vif.i_J              <= 0;
        vif.i_SECTOR         <= 0;
        vif.i_XTS_PLAINTEXT  <= 0;
        vif.i_KEY_1          <= 0;
        vif.i_KEY_2          <= 0;
        
        m_trans.print();      // Print all
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("--- Driver Starts & RESET = %0d ----", vif.i_reset), UVM_LOW)       
        @(posedge vif.i_clk);
        vif.i_XTS_START     <= m_trans.i_XTS_START;
        vif.i_J             <= m_trans.i_J;
        vif.i_SECTOR        <= m_trans.i_SECTOR;
        vif.i_XTS_PLAINTEXT <= m_trans.i_XTS_PLAINTEXT;
        vif.i_KEY_1         <= m_trans.i_KEY_1;
        vif.i_KEY_2         <= m_trans.i_KEY_2;

        m_trans.print();      // Print all
        
        @(posedge vif.i_clk);
        vif.i_XTS_START <= 0;
        
         wait(vif.o_XTS_DONE);
      end
      
      seq_item_port.item_done(m_trans);  
      `uvm_info(get_type_name(), "------ Driver Ends -----", UVM_LOW)
    end
  endtask
endclass
