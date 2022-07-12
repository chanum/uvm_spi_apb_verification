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

class spi_env_config extends uvm_object;
  // UVM Factory Registration Macro
  `uvm_object_utils(spi_env_config)

  localparam string s_my_config_id = "spi_env_config";
  localparam string s_no_config_id = "no config";
  localparam string s_my_config_type_error_id = "config type error";

  // Whether env analysis components are used:
  bit has_apb_agent = 1;
  bit has_spi_agent = 1;
  bit has_reg_model = 1;
  bit has_functional_coverage = 0;
  bit has_spi_functional_coverage = 1;
  bit has_reg_scoreboard = 0;
  bit has_spi_scoreboard = 1;

  // Agents' configuration objects.
  apb_agent_config m_apb_agent_config;
  spi_agent_config m_spi_agent_config;

  // SPI Register block
  spi_reg_block m_reg_model;

  // Interrupt Utility - used in the wait for interrupt task
  intr_util INTR;

  // Environment Configuration Object constructor.
  function new(string name = "spi_env_config");
    super.new(name);
  endfunction: new

  extern task wait_for_interrupt;
  extern function bit is_interrupt_cleared;

endclass: spi_env_config

// This task is a convenience method for sequences waiting for the interrupt signal
task spi_env_config::wait_for_interrupt;
  INTR.wait_for_interrupt();
endtask: wait_for_interrupt

// Check that interrupt has cleared:
function bit spi_env_config::is_interrupt_cleared;
  return INTR.is_interrupt_cleared();
endfunction: is_interrupt_cleared
