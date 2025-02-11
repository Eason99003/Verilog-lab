module edge_detector (
  input reset_n,                                // reset
  input clk,                                    // clock
  input in,                                     // input signal
  output reg rising_edge, falling_edge          // detection of rising and falling edge
); 

reg signal, next_signal;                        // store input signal
reg next_rising, next_falling;                  // store rising and falling signal

always @(posedge clk) begin
  if (~reset_n) begin                           // reset all signals
    signal <= 0;
    rising_edge <= 0;
    falling_edge <= 0;
  end else begin                                // update FF
    signal <= next_signal;
    rising_edge <= next_rising;
    falling_edge <= next_falling;
  end
end

always @* begin
  next_signal = in;
  if (in == 1 && signal == 0) begin             // detect the rising edge of input
    next_rising = 1;                                
    next_falling = 0;
  end else if (in == 0 && signal == 1) begin    // detect the falling edge of input
    next_rising = 0;
    next_falling = 1;
  end else begin
    next_rising = 0;
    next_falling = 0;
  end
end

endmodule
