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

class spi_env extends uvm_env;
  // UVM Factory Registration macro.
  `uvm_component_utils(spi_env)

  // Environment configuration object.
  spi_env_config  m_config;

  // Environment agents instantiation.
  apb_agent m_apb_agent;
  spi_agent m_spi_agent;

  // Register layer adapter
  reg2apb_adapter m_reg2apb;
  // Register predictor
  uvm_reg_predictor#(apb_seq_item) m_apb2reg_predictor;

  // Scoreboard
  spi_scoreboard m_scoreboard;

  // Environment's constructor.
  function new(string name = "spi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Standard UVM build phase.
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Get environment configuration from database
    if (!uvm_config_db #(spi_env_config)
        ::get(this, "", "config", m_config)) begin
      `uvm_fatal("SPI Env", "No config object specified!")
    end

    // Create register model
    if (m_config.has_reg_model) begin
      // Enable all types of coverage available in the register model
      uvm_reg::include_coverage("*", UVM_CVR_ALL);
      m_config.m_reg_model = spi_reg_block::type_id::create("spi_rb");
      // Build and configure the register model
      m_config.m_reg_model.build();
      // Disable the register models auto-prediction
      m_config.m_reg_model.spi_reg_block_map.set_auto_predict(0);
    end

    // Create APB agent
    if (m_config.has_apb_agent) begin
      m_apb_agent = apb_agent::type_id::create("m_apb_agent", this);
      uvm_config_db #(apb_agent_config)::set(this, "m_apb_agent", "m_config",
              m_config.m_apb_agent_config);

      // Build the register model predictor
      if (m_config.m_apb_agent_config.active == UVM_ACTIVE && m_config.has_reg_model) begin
        m_apb2reg_predictor = uvm_reg_predictor#(apb_seq_item)
            ::type_id::create("m_apb2reg_predictor", this);
        // m_reg2apb = reg2apb_adapter::type_id::create("m_reg2apb");
      end
    end

    // Create SPI agent
    if (m_config.has_apb_agent) begin
      m_spi_agent = spi_agent::type_id::create("m_spi_agent", this);
      uvm_config_db #(spi_agent_config)::set(this, "m_spi_agent", "m_config",
              m_config.m_spi_agent_config);
    end

    // Create scoreboard
    if(m_config.has_spi_scoreboard) begin
      m_scoreboard = spi_scoreboard::type_id::create("m_scoreboard", this);
    end

  endfunction:build_phase

  // Standard UVM Connect Phase.
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (m_config.m_apb_agent_config.active == UVM_ACTIVE) begin
      m_reg2apb = reg2apb_adapter::type_id::create("m_reg2apb");
      if (m_config.m_reg_model.get_parent() == null) begin
        m_config.m_reg_model.spi_reg_block_map.set_sequencer(m_apb_agent.m_sequencer, m_reg2apb);
      end
      // Set the predictor map
      m_apb2reg_predictor.map = m_config.m_reg_model.spi_reg_block_map;
      // Set the predictor adapter
      m_apb2reg_predictor.adapter = m_reg2apb;
      // Connect the predictor to the bus agent monitor analysis port
      m_apb_agent.seq_item_aport.connect(m_apb2reg_predictor.bus_in);
    end

    if (m_config.has_spi_scoreboard) begin
      m_spi_agent.seq_item_aport.connect(m_scoreboard.spi.analysis_export);
      m_scoreboard.spi_rb = m_config.m_reg_model;
    end

  endfunction: connect_phase

endclass: spi_env
