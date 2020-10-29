`include "alu.v"
`include "registers.v"
`include "hw6.v"

module datapath(
           clk,
           rst,
           muxPC,
           muxMAR,
           muxACC,
           loadMAR,
           loadPC,
           loadACC,
           loadMDR,
           loadIR,
           opALU,
           zflag,
           opcode,
           MemAddr,
           MemD,
           MemQ,
	   mult_load,
	   mult_done,
           mult_reset);

          input clk;
          input  rst;
          input  muxPC;
          input  muxMAR;
          input[1:0]  muxACC;
          input  loadMAR;
          input  loadPC;
          input  loadACC;
          input  loadMDR;
          input  loadIR;
          input[1:0]  opALU; 
          output   zflag;
          output   [7:0]opcode;
          output   [7:0]MemAddr;
          output reg [15:0]MemD;
          input   [15:0]MemQ;

reg  [7:0]PC_next;
wire  [15:0]IR_next;  
reg  [15:0]ACC_next;  
wire  [15:0]MDR_next;  
reg  [7:0]MAR_next;  
reg zflag_next;

wire  [7:0]PC_reg;
wire  [15:0]IR_reg;  
wire  [15:0]ACC_reg;  
wire  [15:0]MDR_reg;  
wire  [7:0]MAR_reg;  
wire zflag_reg;

wire  [15:0]ALU_out;


assign zflag = (ACC_reg == 16'h0000);
assign opcode = IR_reg[7:0];
assign MemAddr = MAR_reg;
always @(*)
	MemD <= ACC_reg;

wire[15:0] mult_out;
wire mult_cout;
//carry in will always be zero
wire mult_cin;
assign mult_cin = 1'b0;
input mult_load, mult_reset;
output mult_done;

//multiplier
my8bitmultiplier mult(.O(mult_out), .Done(mult_done), .Cout(mult_cout), 
    .A(MDR_reg[7:0]), .B(ACC_reg[7:0]), .Load(mult_load),.Clk(clk), .Reset(mult_reset), .Cin(mult_cin));

//one instance of ALU
alu alu1(.A(MDR_reg), .B(ACC_reg), .opALU(opALU), .Rout(ALU_out));
//one instance of register
registers reg1(clk,
           rst,
           PC_reg, 
           PC_next,
           IR_reg,  
           IR_next,  
           ACC_reg,  
           ACC_next,  
           MDR_reg,  
           MDR_next,  
           MAR_reg,  
           MAR_next,  
           zflag_reg,
           zflag_next
		    );

always @(*)
	PC_next = loadPC ? (muxPC ? IR_reg[7:0] : PC_reg+1) : (PC_reg);

assign IR_next = loadIR ? MDR_reg : IR_reg;

always @(*)
	if(loadACC)
	case(muxACC)
	2'b00: ACC_next = ALU_out;
	2'b01: ACC_next = MDR_reg;
	2'b10: ACC_next = mult_out;
	2'b11: ACC_next = 16'b0;
	default: ACC_next = 16'b0;
	endcase
	else ACC_next = ACC_reg;

assign MDR_next = loadMDR ? MemQ : MDR_reg;

always @(*)
	MAR_next = loadMAR ? (muxMAR ? IR_reg[15:8] :PC_reg): MAR_reg;

always @(*)
	zflag_next = (ACC_reg == 16'h0000);

endmodule