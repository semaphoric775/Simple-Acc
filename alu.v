module alu(A, B, opALU, Rout);
input[15:0] A;
input[15:0] B;
input[1:0] opALU;
output reg[15:0] Rout;

always @(*)
case(opALU)
    2'b00: Rout = A | B;
    2'b01: Rout = A + B;
    2'b10: Rout = 16'b0;
    //ACC_reg is connected to port B
    2'b11: Rout = ~B;
    default: Rout = 16'b0;
endcase
endmodule
