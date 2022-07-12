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

class apb_monitor extends uvm_component;
  // UVM Factory Registration Macro
  `uvm_component_utils(apb_monitor);

  // Virtual Interface
  virtual apb_monitor_bfm m_bfm;

  // Handle to the agent's configuration object.
  apb_agent_config m_config;

  // Monitor's analysis port.
  uvm_analysis_port #(apb_seq_item) seq_item_aport;

  // Monitor's constructor.
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  // Method used during build phase.
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq_item_aport = new("seq_item_aport", this);
  endfunction

  // Method used during connect phase.
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_bfm = m_config.mon_bfm;
    m_bfm.proxy = this;
    set_apb_index(m_config.apb_index);
  endfunction

  // Main task executed during run phase.
  task run_phase(uvm_phase phase);
    m_bfm.run();
  endtask: run_phase

  function void report_phase(uvm_phase phase);
    // Might be a good place to do some reporting on no of analysis transactions sent etc
  endfunction: report_phase

  // Proxy Methods:
  function void notify_transaction(apb_seq_item item);
    seq_item_aport.write(item);
  endfunction

  // Helper Methods:
  function void set_apb_index(int index = 0);
    m_bfm.apb_index = index;
  endfunction : set_apb_index

endclass: apb_monitor
