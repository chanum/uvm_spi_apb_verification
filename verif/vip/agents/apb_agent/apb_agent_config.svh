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
// Class Description:
//
//
class apb_agent_config extends uvm_object;
  // UVM Factory Registration Macro
  `uvm_object_utils(apb_agent_config)

  localparam string s_my_config_id = "apb_agent_config";
  localparam string s_no_config_id = "no config";
  localparam string s_my_config_type_error_id = "config type error";

  // BFM Virtual Interfaces
  virtual apb_monitor_bfm mon_bfm;
  virtual apb_driver_bfm  drv_bfm;

  // Is the agent active or passive
  uvm_active_passive_enum active = UVM_ACTIVE;
  // Include the APB functional coverage monitor
  bit has_functional_coverage = 0;
  // Include the APB RAM based scoreboard
  bit has_scoreboard = 0;

  // Address decode for the select lines:
  int no_select_lines = 1;
  int apb_index = 0; // Which PSEL is the monitor connected to
  logic[31:0] start_address[15:0];
  logic[31:0] range[15:0];

   // Standard constructor for a config object, transaction, or sequence.
  function new(string name = "apb_agent_config");
    super.new(name);
  endfunction

endclass: apb_agent_config
