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

class spi_agent_config extends uvm_object;
  // UVM Factory Registration Macro.
  `uvm_object_utils(spi_agent_config)

  localparam string s_my_config_id = "spi_agent_config";
  localparam string s_no_config_id = "no config";
  localparam string s_my_config_type_error_id = "config type error";

  // BFM Virtual Interfaces
  virtual spi_monitor_bfm mon_bfm;
  virtual spi_driver_bfm  drv_bfm;

  // Variable used to store the agent's activation status.
  uvm_active_passive_enum active = UVM_ACTIVE;

  bit has_functional_coverage = 0;

  // Standard constructor for a config object, transaction, or sequence.
  function new (string name = "spi_agent_config");
    super.new(name);
  endfunction: new

endclass: spi_agent_config
