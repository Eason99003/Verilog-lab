`timescale 1ns/1ps
module testbench;

parameter CYCLE = 10;
parameter LARGE_NUMBER = 10000;

localparam N = 8;

reg clk;
reg reset_n;
reg A;
reg [N-1:0] test[0:511];
reg parity_test[0:511];
reg parity_tmp;
wire parity;

integer i, j, k, m, error;


parity_generator #(
  .width(N)
) parity_generator (
  .a(A),
  .reset_n(reset_n),
  .parity(parity)
);

initial begin
  $dumpfile("testbench.vcd");
  $dumpfile("+mda");
end

initial begin
  for (i = 0; i < 512; i = i + 1) begin
    parity_tmp = 0;
    test[i] = i;
    for (j = 0; j < 8; j = j + 1) begin
      parity_tmp = parity_tmp ^ test[i][j];
    end
    parity_test[i] = parity_tmp;
  end
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
  A = 0;
  wait(reset_n == 0);
  wait(reset_n == 1);

  for (k = 0; k < 512; k = k + 1) begin
    @(negedge clk) A = test[k];
  end
end

initial begin
  error = 0;
  wait(reset_n == 0);
  wait(reset_n == 1);

  #(CYCLE*2);

  for (m = 0; m < 512; m = m + 1) begin
    @(posedge clk);
    if (parity != parity_test[m]) begin
      error = error + 1;
      $display("************* Pattern No.%d is wrong at %t ************", m, $time);
      $display("A = %b", test[m]);  
      $display("golden = %b, but your answer is %b QQ Orz ", parity_test[m], parity); 
    end
  end

  if (error == 0) $display("All Correct!!!");
  else $display("Error!");

  #(CYCLE) $finish;
end

endmodule
