class my_item extends uvm_sequence_item;
  `uvm_object_utils(my_item)
  
  bit                         i_XTS_START;
  bit [`BLOCK_NUMBER-1:0]     i_J;
  
  rand bit [`CIPHERTEXT_WIDTH-1:0] i_SECTOR;
  rand bit [`PLAINTEXT_WIDTH-1:0]  i_XTS_PLAINTEXT;
  rand bit [`KEY_WIDTH-1:0]        i_KEY_1;
  rand bit [`KEY_WIDTH-1:0]        i_KEY_2;

  bit [`PLAINTEXT_WIDTH-1:0] o_XTS_CIPHERTEXT;
  bit                        o_XTS_DONE;

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("i_XTS_START", i_XTS_START, $bits(i_XTS_START), UVM_HEX);
    printer.print_field_int("i_J", i_J, $bits(i_J), UVM_HEX);
    printer.print_field_int("i_SECTOR", i_SECTOR, $bits(i_SECTOR), UVM_HEX);
    printer.print_field_int("i_XTS_PLAINTEXT", i_XTS_PLAINTEXT, $bits(i_XTS_PLAINTEXT), UVM_HEX);
    printer.print_field_int("i_KEY_1", i_KEY_1, $bits(i_KEY_1), UVM_HEX);
    printer.print_field_int("i_KEY_2", i_KEY_2, $bits(i_KEY_2), UVM_HEX);
    printer.print_field_int("o_XTS_CIPHERTEXT", o_XTS_CIPHERTEXT, $bits(o_XTS_CIPHERTEXT), UVM_HEX);
    printer.print_field_int("o_XTS_DONE", o_XTS_DONE, $bits(o_XTS_DONE), UVM_HEX);
  endfunction
  
  function new(string name = "my_item");
    super.new(name);
  endfunction
endclass
