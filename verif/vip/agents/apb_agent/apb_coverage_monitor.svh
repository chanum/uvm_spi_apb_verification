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
// Functional coverage monitor for the APB agent
//
// Collects basic coverage information
//
class apb_coverage_monitor extends uvm_subscriber #(apb_seq_item);
  // UVM Factory Registration Macro
  `uvm_component_utils(apb_coverage_monitor);

  //------------------------------------------
  // Cover Group(s)
  //------------------------------------------
  covergroup apb_cov;
  OPCODE: coverpoint analysis_txn.we {
    bins write = {1};
    bins read = {0};
  }
  // To do:
  // Monitor is not returning delay info
  endgroup

  apb_seq_item analysis_txn;

  // Monitor's constructor.
  function new(string name, uvm_component parent);
    super.new(name, parent);
    apb_cov = new();
  endfunction

  function void write(T t);
    analysis_txn = t;
    apb_cov.sample();
  endfunction:write

  function void report_phase(uvm_phase phase);
    // Might be a good place to do some reporting on no of analysis transactions sent etc
  endfunction: report_phase

endclass: apb_coverage_monitor
