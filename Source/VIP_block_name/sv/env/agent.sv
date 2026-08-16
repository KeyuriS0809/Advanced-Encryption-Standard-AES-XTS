class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent)
  my_driver                        m_drv;
  my_monitor                       m_mon;
  my_sequencer                     m_seqr;
  uvm_analysis_port #(my_item)     m_ap;   // forwards monitor.ap up to env

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_ap = new("m_ap", this);
    m_seqr = my_sequencer::type_id::create("m_seqr", this);
    m_drv  = my_driver::type_id::create("m_drv",  this);
    m_mon  = my_monitor::type_id::create("m_mon",  this);
  endfunction

  function void connect_phase(uvm_phase phase);
    m_drv.seq_item_port.connect(m_seqr.seq_item_export); // driver & sequencer
    m_mon.m_ap.connect(m_ap);   
  endfunction
endclass
