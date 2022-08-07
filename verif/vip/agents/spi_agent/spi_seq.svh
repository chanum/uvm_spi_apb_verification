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

class spi_seq extends uvm_sequence #(spi_seq_item);
  // UVM Factory Registration Macro.
  `uvm_object_utils(spi_seq)

  // Standard UVM Methods:
  extern function new(string name = "spi_seq");
  extern task body;

  endclass:spi_seq

  function spi_seq::new(string name = "spi_seq");
    super.new(name);
  endfunction

task spi_seq::body;
  spi_seq_item req;

  begin
    req = spi_seq_item::type_id::create("req");
    start_item(req);
    if(!req.randomize()) begin
      `uvm_error("body", "req randomization failure")
    end
    finish_item(req);
  end
endtask:body

class spi_rand_seq extends uvm_sequence #(spi_seq_item);
  `uvm_object_utils(spi_rand_seq)

  function new(string name = "spi_rand_seq");
    super.new(name);
  endfunction

  rand int unsigned bits;
  rand logic rx_edge;

  task body;
    spi_seq_item req = spi_seq_item::type_id::create("req");

    start_item(req);
    if (!req.randomize() with {req.no_bits == bits; req.RX_NEG == rx_edge;}) begin
      `uvm_error("body", "req randomization failure")
    end
    finish_item(req);

  endtask:body

endclass: spi_rand_seq
