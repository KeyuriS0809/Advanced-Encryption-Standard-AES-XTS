class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)
  
  my_item m_trans;
  virtual my_intf vif;
  uvm_analysis_port #(my_item) m_ap;   

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_ap = new("m_ap", this);

    if (!uvm_config_db #(virtual my_intf)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "No virtual interface in config_db!")
  endfunction

  task run_phase(uvm_phase phase);
    
  forever begin
    if (vif.i_reset) begin
      wait (!vif.i_reset);
    end
    else begin
      @(posedge vif.i_clk iff vif.i_XTS_START);   
      
      m_trans = my_item::type_id::create("m_trans");
      m_trans.i_J             = vif.i_J;
      m_trans.i_SECTOR         = vif.i_SECTOR;
      m_trans.i_XTS_PLAINTEXT  = vif.i_XTS_PLAINTEXT;
      m_trans.i_KEY_1          = vif.i_KEY_1;
      m_trans.i_KEY_2          = vif.i_KEY_2;

      wait(vif.o_XTS_DONE);    // capture output at DONE
      m_trans.o_XTS_CIPHERTEXT = vif.o_XTS_CIPHERTEXT;
      m_trans.o_XTS_DONE       = vif.o_XTS_DONE;

      m_ap.write(m_trans);
     end
   end
 endtask
endclass
