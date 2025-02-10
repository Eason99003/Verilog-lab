module edge__detector (
  input reset_n,
  input clk,
  input in,
  output reg rising_edge, falling_edge
);

reg signal, next_signal;
reg next_rising, next_falling;

always @(posedge clk) begin
  if (~reset_n) begin
    signal <= 0;
    rising_edge <= 0;
    falling_edge <= 0;
  end else begin
    signal <= next_signal;
    rising_edge <= next_rising;
    falling_edge <= next_falling;
  end
end

always @* begin
  next_signal = in;
  if (in == 1 && signal == 0) begin
    next_rising = 1;
    next_falling = 0;
  end else if (in == 0 && signal == 1) begin
    next_rising = 0;
    next_falling = 1;
  end else begin
    next_rising = 0;
    next_falling = 0;
  end
end

endmodule
