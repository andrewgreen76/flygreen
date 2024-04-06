module ControlLogic(
    input wire clk, // Clock signal
    output reg [31:0] instruction_address // Output instruction address
);

// Hardcoded reset vector address
parameter RESET_VECTOR_ADDRESS = 32'hFFFFFFF0;

// Sequential logic to load the reset vector address
always @(posedge clk) begin
    instruction_address <= RESET_VECTOR_ADDRESS;
end

endmodule
