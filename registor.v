module register (
	input reg_write,clk,
	input [4:0] rd,
	input [4:0] rs1,
	input [4:0] rs2,
	input [31:0] rslt_data,
	output reg [31:0] a1,a2
	);
	
reg [31:0] mem[31:0];
always@(posedge clk) begin
	if(reg_write) begin
		mem[rd]=rslt_data;
		end
	end
	
always@(*) begin
	a1=mem[rs1];
	a2=mem[rs2];
	end
	
endmodule

module register_tb;
	reg reg_write;
	reg clk;
	reg [4:0]rd;
	reg [4:0]rs1;
	reg [4:0]rs2;
	reg [31:0] rslt_data;
	wire [31:0] a1;
	wire [31:0] a2;
	
	
register uut  (.reg_write(reg_write),
		.clk(clk),
		.rd(rd),
		.rs1(rs1),
		.rs2(rs2),
		.rslt_data(rslt_data),
		.a1(a1),
		.a2(a2));
		
initial begin
	clk=0;
	end 
	
always #5 clk=~clk;
initial begin
rd=5'd2;
rslt_data=32'b2;
reg_write=1;

#20;

rs1=5'b00001;
rs2=5'b00101;
rd=5'b00111;
$monitor("rs1=%d,rs2=%d,rd=%d",a1,a2);
#10;
$finish;
end 
endmodule	
	
