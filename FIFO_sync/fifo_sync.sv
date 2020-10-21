// Code your design here
module fifo_sync #(
  parameter DEPTH = 8,
  parameter WIDTH = 32,
  parameter type T = logic [WIDTH - 1: 0]
  }{
    input logic clk,
    input logic rst,
    input logic we,
    input logic re,
    input logic [WIDTH - 1:0]wdata,
    
    output logic full,
    output logic almost_full,
    output logic empty,
    output logic [clogb2(DEPTH)-1:0] wptr,
    output logic [clogb2(DEPTH)-1:0] rptr,
    output logic [WIDTH -1:0] rdata
  };
  logic [WIDTH - 1: 0] n_rdata;
  logic [DEPTH - 1: 0] [WIDTH -1: 0] mem, n_mem;
  logic full_condition, empty_condition, almost_full_condition, n_wptr, n_rptr;
  
  //assign full = full_condition;
  assign full_condition = ((wptr - rptr) == DEPTH) ? 1'b1 : 1'b0;
  //assign almost_full = almost_full_condition;
  assign almost_full_condition = ((wptr - rptr) == (DEPTH - 1))? 1'b1 : 1'b0;
  //assign empty = empty_condition;
  assign empty_condition = (rptr == wptr)? 1'b1: 1'b0; 

  
  //assign rdata = mem[rptr];
  
  always_ff @(posedge clk,negedge rst)
    begin
      if(!rst) begin
        mem <= 'h0;
        wptr <= '0;
        rptr <= '0;
        rdata <= '0;
        full <= 0;
        almost_full <= 0;
        empty <= 0;
      end
      else begin
        mem <= n_mem;
        wptr <= n_wptr;
        rptr <= n_rptr;
        n_rdata <= rdata;
        full <= full_condition;
        almost_full <= almost_full_condition;
        empty <= empty_condition;
      end
    end
      
    always_comb 
      begin
      n_mem = mem;
      if (we && !full_condition)
        begin
          n_mem[wptr] = wdata;
          if((wptr + 1) == DEPTH)
            begin
              n_wptr == 0;
            end
          else 
            begin
              n_wptr = wptr + 1;
            end
        end
      if (re && !empty_condition)
        begin
          n_rdata = mem[rptr];
          if((rptr + 1) == DEPTH)
            begin
              n_rptr == 0;
            end
          else 
            begin
              n_rptr = rptr + 1;
            end
        end
      end
      
  endmodule    
    
    
    
    
    
    
    
    
    
  