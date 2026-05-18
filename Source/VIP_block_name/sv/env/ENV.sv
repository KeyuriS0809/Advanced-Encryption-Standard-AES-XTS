class ENV;
  generator gen;
  driver dri;
  monitor mon;
  scoreboard sb;

  mailbox #(transaction) gen2dri;
  mailbox #(transaction) mon2soc;

  virtual intf vif;

  function new (virtual intf vif);
    this.vif = vif;
    gen2dri = new();
    mon2soc = new();

    gen = new(gen2dri);
    dri = new(gen2dri, vif);
    mon = new(mon2soc, vif);
    sb  = new(mon2soc);
  endfunction

  task test_run;
    fork 
      dri.main();
      mon.main();
      sb.main();
    join_none
  endtask
endclass
