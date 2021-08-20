`timescale 1ns/1ns
// Simple AND gate DUT
module simple_calc 
  //( parameter SIZE = 8)
  (
    input logic [3: 0]bus,
  	output logic allzeros, allones, anyzeros, anyones);
  
  assign allzeros = ~(|bus);
  assign allones = (&bus);
  assign anyzeros = ~(&bus);
  assign anyones = (|bus);

endmodule
