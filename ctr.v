module ctr (
           clk,
           rst,
	       zflag,
           opcode,
           muxPC,
           muxMAR,
           muxACC,
           loadMAR,
           loadPC,
           loadACC,
           loadMDR,
           loadIR,
           opALU,
           MemRW,
           mult_load,
           mult_done,
           mult_reset,
);

input clk;
input rst;
input zflag;
input [7:0]opcode;
output reg muxPC;
output reg muxMAR;
output reg[1:0] muxACC;
output reg loadMAR;
output reg loadPC;
output reg loadACC;
output reg loadMDR;
output reg loadIR;
output reg[1:0] opALU;
output reg MemRW;
output reg mult_load;
output reg mult_reset;
input mult_done;

parameter op_add=8'b001;
parameter op_or= 8'b010;
parameter op_jump=8'b011;
parameter op_jumpz=8'b100;
parameter op_load=8'b101;
parameter op_store=8'b110;
parameter op_mull=8'b1001;
parameter op_neg=8'b1010;

parameter Fetch_1 = 5'b00000;
parameter Fetch_2 = 5'b00001;
parameter Fetch_3 = 5'b00010;
parameter Decode = 5'b00011;
parameter ExecADD_1 = 5'b00100;
parameter ExecOR_1 = 5'b00101;
parameter ExecLoad_1 = 5'b00110;
parameter ExecStore_1 = 5'b00111;
parameter ExecJump = 5'b01000;
parameter ExecADD_2 = 5'b01001;
parameter ExecOR_2 = 5'b01010;
parameter ExecLoad_2 = 5'b01011;
parameter ExecNEG_1 = 5'b01100;
parameter ExecNEG_2 = 5'b01101;
parameter ExecMUL_1 = 5'b01110; 
parameter ExecMUL_2 = 5'b01111;
parameter ExecMUL_3 = 5'b10000;
parameter ExecMUL_4 = 5'b10001;
parameter ExecMUL_5 = 5'b10010;
parameter ExecMUL_6 = 5'b10011;

reg[4:0] current_state;

always @(*)
case(current_state)
Fetch_1:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b1;
loadPC <= 1'b1;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
Fetch_2:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b1;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
Fetch_3:
begin 
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b1;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
Decode:
begin
muxPC <= 1'b0;
muxMAR <= 1'b1;
muxACC <= 2'b00;
loadMAR <= 1'b1;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecADD_1:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b1;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecOR_1: 
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b1;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecStore_1:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b1;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecLoad_1:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b1;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecJump:
begin
muxPC <= 1'b1;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b1;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecADD_2:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b1;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b01;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecOR_2:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b1;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecLoad_2:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b01;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b1;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecNEG_1:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b1;
loadIR <= 1'b0;
opALU <= 2'b11;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecNEG_2:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b1;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b11;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecMUL_1:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b1;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b1;
end
ExecMUL_2:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b1;
end
ExecMUL_3:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b1;
mult_reset <= 1'b0;
end
ExecMUL_4:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b1;
mult_reset <= 1'b0;
end
ExecMUL_5:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
ExecMUL_6:
begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b10;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b1;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
default: begin
muxPC <= 1'b0;
muxMAR <= 1'b0;
muxACC <= 2'b00;
loadMAR <= 1'b0;
loadPC <= 1'b0;
loadACC <= 1'b0;
loadMDR <= 1'b0;
loadIR <= 1'b0;
opALU <= 2'b00;
MemRW <= 1'b0;
mult_load <= 1'b0;
mult_reset <= 1'b0;
end
endcase

always @(posedge clk)
    if(rst)
        current_state <= Fetch_1;
    else 
    case(current_state)
    Fetch_1: current_state <= Fetch_2;
    Fetch_2: current_state <= Fetch_3;
    Fetch_3: current_state <= Decode;
    Decode: case(opcode)
    op_add: current_state <= ExecADD_1;
    op_or: current_state <= ExecOR_1;
    op_store: current_state <= ExecStore_1;
    op_load: current_state <= ExecLoad_1;
    op_jump: current_state <= ExecJump;
    op_jumpz: if(zflag) current_state <= ExecJump; else current_state <= Fetch_1;
    op_neg: current_state <= ExecNEG_1;
    op_mull: current_state <= ExecMUL_1;
    default: current_state <= Fetch_1;
    endcase
    ExecADD_1: current_state <= ExecADD_2;
    ExecOR_1: current_state <= ExecOR_2;
    ExecStore_1: current_state <= Fetch_1;
    ExecLoad_1: current_state <= ExecLoad_2;
    ExecADD_2: current_state <= Fetch_1;
    ExecOR_2: current_state <= Fetch_1;
    ExecLoad_2: current_state <= Fetch_1;
    ExecNEG_1: current_state <= ExecNEG_2;
    ExecNEG_2: current_state <= Fetch_1;
    ExecMUL_1: current_state <= ExecMUL_2;
    ExecMUL_2: current_state <= ExecMUL_3;
    ExecMUL_3: current_state <= ExecMUL_4;
    ExecMUL_4: current_state <= ExecMUL_5;
    ExecMUL_5: if(mult_done) current_state <= ExecMUL_6; else current_state <= ExecMUL_5;
    ExecMUL_6: current_state <= Fetch_1;
    default: current_state <= Fetch_1;
    endcase

endmodule