module ram(we, d, q, addr);
input we;
input[7:0] addr;
input [15:0] d;
output reg[15:0] q;
reg[15:0] mem256x16[0:255];

always @(*)
begin
    if(we) begin
        mem256x16[addr] <= d;
	q <= 16'h0000;
    end
    else
        q <= mem256x16[addr];
end

endmodule
