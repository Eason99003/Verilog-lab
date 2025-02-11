module parity_generator (
  input [7:0] a,               
  input reset_n,
  output reg parity
);

integer i;                           // for loop variable

always @* begin
  if (~reset_n) begin                           // reset the output to 0
    parity = 0;
  end else begin                                // calculate the parity
    parity = parity ^ a[0] ^ a[1] ^ a[2] ^ a[3] ^ a[4] ^ a[5] ^ a[6] ^ a[7];
  end
end

endmodule

