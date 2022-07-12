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

class apb_driver extends uvm_driver #(apb_seq_item, apb_seq_item);
  // UVM Factory Registration Macro
  `uvm_component_utils(apb_driver)

  // Virtual Interface
  virtual apb_driver_bfm m_bfm;

  // Handle to the agent's configuration object.
  apb_agent_config m_config;

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
   m_bfm = m_config.drv_bfm;
  endfunction

  // Main task executed during run phase.
  task run_phase(uvm_phase phase);
    apb_seq_item req;
    int psel_index;

    m_bfm.m_config = m_config;
    forever
    begin
      m_bfm.clear_sigs();
      seq_item_port.get_next_item(req);
      m_bfm.drive(req);
      seq_item_port.item_done();
    end
  endtask: run_phase

endclass: apb_driver

