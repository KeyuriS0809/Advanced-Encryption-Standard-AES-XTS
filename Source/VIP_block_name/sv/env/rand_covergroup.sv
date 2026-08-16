covergroup random_cg with function sample(my_item trans);

  sector_cp : coverpoint trans.i_SECTOR { option.auto_bin_max = 64;}
  
  key1_cp : coverpoint trans.i_KEY_1 { option.auto_bin_max = 64;}
  
  key2_cp : coverpoint trans.i_KEY_2 {option.auto_bin_max = 64;}

  plaintext_cp : coverpoint trans.i_XTS_PLAINTEXT { option.auto_bin_max = 64;}

  ciphertext_cp : coverpoint trans.o_XTS_CIPHERTEXT { option.auto_bin_max = 64;}

endgroup
