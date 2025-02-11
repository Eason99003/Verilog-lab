module parity_generator #(
  parameter width = 8                // the width of input
) (
  input [width-1:0] a,               
  input reset_n,
  output reg parity
);

integer i;                           // for loop variable

always @* begin
  if (~reset_n) begin                           // reset the output to 0
    parity = 0;
  end else begin
    for (i = 0; i < width; i = i + 1) begin     // calculate the parity
      parity =  parity ^ a[i];
    end
  end
end

endmodule
