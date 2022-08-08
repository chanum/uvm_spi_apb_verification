

class spi_driver2 extends spi_driver;
  // UVM Factory Registration Macro.
  `uvm_component_utils(spi_driver2)

  // Virtual Interface
  // local virtual spi_driver_bfm m_bfm;

  // Handle to the agent's configuration object.
  // spi_agent_config m_config;

  // Driver's constructor.
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  // Method used during build phase.
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  // Method used during connect phase.
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Set virtual interface in configuration object.
    // m_bfm = m_config.drv_bfm;
  endfunction

  // Main task executed during run phase.
  task run_phase(uvm_phase phase);
    spi_seq_item req;

    m_bfm.wait_cs_isknown();

    forever begin
      seq_item_port.get_next_item(req);

      `uvm_info(get_name, "FROM SPI_DRIVER2 ", UVM_NONE);

      m_bfm.drive(req);
      seq_item_port.item_done();
    end
  endtask: run_phase

endclass: spi_driver2
