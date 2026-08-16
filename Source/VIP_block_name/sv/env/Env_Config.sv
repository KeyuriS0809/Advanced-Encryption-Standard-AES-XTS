class Env_config extends uvm_object;
  `uvm_object_utils(Env_config)
  
  bit scoreboard_enable = 1;
  bit coverage_enable = 1;
  bit rand_coverage_enable = 0;
  
  function new(string name = "Env_config");
    super.new(name);
  endfunction
  
endclass
