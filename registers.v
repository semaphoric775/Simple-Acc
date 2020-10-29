module registers(
           clk,
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
           Zflag_reg,
           Zflag_next
		    );

input wire clk;
input wire rst;
output reg  [7:0]PC_reg; 
input wire  [7:0]PC_next;
 
output reg  [15:0]IR_reg;  
input wire  [15:0]IR_next;  

output reg  [15:0]ACC_reg;  
input wire  [15:0]ACC_next;  

output reg  [15:0]MDR_reg;  
input wire  [15:0]MDR_next;  

output reg  [7:0]MAR_reg;  
input wire  [7:0]MAR_next;  

output reg Zflag_reg;
input wire Zflag_next;

always @(posedge clk)
if(rst)
begin
PC_reg <= 8'b0;
IR_reg <= 16'b0;
ACC_reg <= 16'b0;
MDR_reg <= 16'b0;
MAR_reg <= 8'b0;
Zflag_reg <= 1'b0;
end
else
begin
//set registers to next values
PC_reg <= PC_next;
IR_reg <= IR_next;
ACC_reg <= ACC_next;
MDR_reg <= MDR_next;
MAR_reg <= MAR_next;
Zflag_reg <= Zflag_next;
end

endmodule