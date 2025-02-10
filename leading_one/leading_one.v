module leading_one #(
  parameter width = 8
) (
  input             reset_n,
  input [width-1:0] a,
  output reg [3:0]  index
);

integer i;

always @* begin
  if (~reset_n) begin
    index = -1;
  end else begin
    for (i = 0; i < width; i = i + 1) begin
      if (a[i] == 1) index = i - 1;
      else index = index;
    end
  end
end

endmodule

