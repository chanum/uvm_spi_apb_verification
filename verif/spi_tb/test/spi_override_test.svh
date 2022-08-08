
class spi_override_test extends spi_test_base;
  // UVM Factory Registration Macro
  `uvm_component_utils(spi_override_test)

  // Standard UVM Methods:
  extern function new(string name = "spi_override_test", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass: spi_override_test

function spi_override_test::new(string name = "spi_override_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build the env, create the env configuration
// including any sub configurations and assigning virtural interfaces
function void spi_override_test::build_phase(uvm_phase phase);
  uvm_reg::include_coverage("*", UVM_CVR_ADDR_MAP, this);
  super.build_phase(phase);

  // verride spi_config_rand_order_seq by spi_config_x32_order_seq
  set_type_override_by_type(spi_config_rand_order_seq::get_type(), spi_config_x32_order_seq::get_type());
  // override spi_rand_seq by spi_bits_32_seq
  set_type_override_by_type(spi_rand_seq::get_type(), spi_bits_32_seq::get_type());

endfunction: build_phase

function void spi_override_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  
  // print factory
  this.print();
  factory.print();
  // Output:
  //   #### Factory Configuration (*)
  // # 
  // # No instance overrides are registered with this factory
  // # 
  // # Type Overrides:
  // # 
  // #   Requested Type             Override Type           
  // #   -------------------------  ------------------------
  // #   spi_config_rand_order_seq  spi_config_x32_order_seq
  // #   spi_rand_seq               spi_bits_32_seq
endfunction: end_of_elaboration_phase

task spi_override_test::run_phase(uvm_phase phase);
  config_interrupt_test t_seq = config_interrupt_test::type_id::create("t_seq");
  set_seqs(t_seq);

  phase.raise_objection(this, "Test Started");

  // config_interrupt_test sends spi_config_rand_order_seq & spi_rand_seq sequences by default
  // but with set_type_override_by_type, in this test we override those sequences
  // with spi_config_x32_order_seq & spi_bits_32_seq respectively
  t_seq.start(null);


  #100;
  phase.drop_objection(this, "Test Finished");

endtask: run_phase
