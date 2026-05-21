class generator;

  mailbox #(transaction) gen2drv;
  transaction trans;

  function new(mailbox #(transaction) gen2drv);
    this.gen2drv  = gen2drv;
  endfunction

  task send(transaction tr);
    tr.display("GENERATOR");
    gen2drv.put(tr);
  endtask

endclass
