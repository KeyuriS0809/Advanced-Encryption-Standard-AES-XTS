class TEST;

  virtual intf vif;
  ENV env;

  function new(virtual intf vif);
    this.vif = vif;
    env = new(vif);
  endfunction

  task reset();
    vif.i_reset = 1;
    $display("------ TIME = [%0t] RESET = %0b -------",$time,vif.i_reset);
    repeat (2)
      @(posedge vif.i_clk);
    vif.i_reset = 0;
    @(posedge vif.i_clk);
    $display("------ TIME = [%0t] RESET = %0b -------",$time,vif.i_reset);
  endtask

  virtual task run();
  endtask

endclass
