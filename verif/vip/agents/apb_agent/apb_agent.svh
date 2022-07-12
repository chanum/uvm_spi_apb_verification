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
//

class apb_agent extends uvm_component;
  // UVM Factory Registration Macro
  `uvm_component_utils(apb_agent)

  // Agent's configuration object.
  apb_agent_config m_config;

  // Agent's subcomponents.
  apb_monitor           m_monitor;
  apb_sequencer         m_sequencer;
  apb_driver            m_driver;
  apb_coverage_monitor  m_fcov_monitor;

  // Agent's analysis port.
  uvm_analysis_port #(apb_seq_item) seq_item_aport;

  // Agent's constructor.
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Method used during build phase.
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Get configuration object from configuration database.
    if (!uvm_config_db #(apb_agent_config)::get(this, "", "m_config", m_config)) begin
      `uvm_fatal("APB Agent", "No agent config specified!")
    end

    // Create driver and sequencer only if agent is configured as active.
    if (m_config.active == UVM_ACTIVE) begin
      // Create agent's sequencer and driver.
      m_sequencer = apb_sequencer::type_id::create("m_sequencer", this);
      m_driver = apb_driver::type_id::create("m_driver", this);
      // Link agent's configuration object to driver's handle.
      m_driver.m_config = m_config;
    end

    // Create agent's monitor.
    m_monitor = apb_monitor::type_id::create("m_monitor", this);

    // Link agent's configuration object to monitor's handle.
    m_monitor.m_config = m_config;

    // Create Coverage Monitor
    if(m_config.has_functional_coverage) begin
      m_fcov_monitor = apb_coverage_monitor::type_id::create("m_fcov_monitor", this);
    end

    // Create analysis port
    seq_item_aport = new("seq_item_aport", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Connect sequencer with driver only if agent is configured as active.
    if (m_config.active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end

    // Connect monitor's analysis port to Coverage monitor's analysis export.
    if (m_config.has_functional_coverage) begin
      m_monitor.seq_item_aport.connect(m_fcov_monitor.analysis_export);
    end

    // Connect monitor's analysis port to agent's analysis port.
    m_monitor.seq_item_aport.connect(seq_item_aport);
  endfunction

endclass: apb_agent
