`timescale 1ns/1ps;
module testbench;

parameter CYCLE = 10;
parameter LARGE_NUMBER = 1000;

reg clk;
reg reset_n;
reg in;

wire rising_edge, falling_edge;

integer i, j, error;

edge_detector edge_detector(
  .reset_n(reset_n),
  .clk(clk),
  .in(in),
  .rising_edge(rising_edge),
  .falling_edge(falling_edge)
);

initial begin
  $dumpfile("testbench.vcd");
  $dumpvars("+mda");
end

always #(CYCLE/2) clk = ~clk;

initial begin
  clk = 1;
  reset_n = 1;
  #(CYCLE) reset_n = 0;
  #(CYCLE) reset_n = 1;
  #(CYCLE * LARGE_NUMBER) $finish;
end

initial begin
  in = 0;
  wait(reset_n == 0);
  wait(reset_n == 1);
  
  for (i = 1; i <= 10; i = i + 1) begin
    @(negedge clk);
    in = 1;
    #(CYCLE*i);
    in = 0;
    #(CYCLE/2);
  end
end

initial begin
  error = 0;
  wait(reset_n == 0);
  wait(reset_n == 1);
  #(CYCLE);
  for (j = 1; j <= 10; j = j + 1) begin
    @(negedge clk);
    if (rising_edge == 0 || falling_edge == 1) error = error + 1;
    #(CYCLE*j);
    if (rising_edge == 1 || falling_edge == 0) error = error + 1;
    #(CYCLE/2);
  end

  if (error == 0) $display("All Correct!!");
  else $display("error!");

  #(CYCLE) $finish;

end

endmodule

