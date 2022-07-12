//------------------------------------------------------------
//   Copyright 2010-2018 Mentor Graphics Corporation
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//------------------------------------------------------------

class spi_test_base extends uvm_test;
  // UVM Factory Registration Macro
  `uvm_component_utils(spi_test_base)

  // The environment class
  spi_env m_env;

  // The environment config class
  spi_env_config m_env_config;

  // Standard UVM Methods:
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  // Environment's build phase.
  function void build_phase(uvm_phase phase);
    virtual intr_bfm temp_intr_bfm;

    super.build_phase(phase);

    // Create environment and environment configuration object.
    m_env = spi_env::type_id::create("m_env", this);
    m_env_config = spi_env_config::type_id::create("m_env_config");

    // Configure APB agent
    m_env_config.m_apb_agent_config = apb_agent_config::type_id::create("m_apb_agent_config");
     configure_apb_agent(m_env_config.m_apb_agent_config);
    if (!uvm_config_db #(virtual apb_monitor_bfm)::get(this, "", "APB_mon_bfm", m_env_config.m_apb_agent_config.mon_bfm))
      `uvm_fatal("VIF CONFIG", "Cannot get() BFM interface APB_mon_bfm from uvm_config_db. Have you set() it?")
    if (!uvm_config_db #(virtual apb_driver_bfm) ::get(this, "", "APB_drv_bfm", m_env_config.m_apb_agent_config.drv_bfm))
      `uvm_fatal("VIF CONFIG", "Cannot get() BFM interface APB_drv_bfm from uvm_config_db. Have you set() it?")

    // The SPI is not configured as such
    m_env_config.m_spi_agent_config = spi_agent_config::type_id::create("m_spi_agent_config");
    m_env_config.m_spi_agent_config.has_functional_coverage = 1;
    if (!uvm_config_db #(virtual spi_monitor_bfm)::get(this, "", "SPI_mon_bfm", m_env_config.m_spi_agent_config.mon_bfm))
      `uvm_fatal("VIF CONFIG", "Cannot get() BFM interface SPI_mon_bfm from uvm_config_db. Have you set() it?")
    if (!uvm_config_db #(virtual spi_driver_bfm) ::get(this, "", "SPI_drv_bfm", m_env_config.m_spi_agent_config.drv_bfm))
      `uvm_fatal("VIF CONFIG", "Cannot get() BFM interface SPI_drv_bfm from uvm_config_db. Have you set() it?")

    // Insert the interrupt virtual interface into the env_config:
    m_env_config.INTR = intr_util::type_id::create("INTR");
    if (!uvm_config_db #(virtual intr_bfm)::get(this, "", "INTR_bfm", temp_intr_bfm) )
      `uvm_fatal("VIF CONFIG", "Cannot get() interface INTR_bfm from uvm_config_db. Have you set() it?")
    m_env_config.INTR.set_bfm(temp_intr_bfm);

    // Post configure and set configuration object to database
    configure_env(m_env_config);
    uvm_config_db #(spi_env_config)::set(this, "*", "config", m_env_config);

  endfunction: build_phase

  virtual function void configure_env(spi_env_config env_config);
    // Env post config here (if needed).
  endfunction: configure_env

  function void configure_apb_agent(apb_agent_config cfg);
    cfg.active = UVM_ACTIVE;
    cfg.has_functional_coverage = 1;
    cfg.has_scoreboard = 0;
    // SPI is on select line 0 for address range 0-18h
    cfg.no_select_lines = 1;
    cfg.start_address[0] = 32'h0;
    cfg.range[0] = 32'h18;
  endfunction: configure_apb_agent

  // Convenience method to assign virtual sequence's sequencers handlers.
  function void set_seqs(spi_vseq_base vseq);
    // Set vseq sequencer pointers to agent's sequencers.
    vseq.m_cfg = m_env_config;
    vseq.spi = m_env.m_spi_agent.m_sequencer;
  endfunction: set_seqs

endclass: spi_test_base