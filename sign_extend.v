module sign_extend(
	input [31:0]inst,
	input [1:0] imm_scr,
	output reg [31:0] imm_ext

);

always@(*) begin

	case(imm_scr)
	
        	 2'b00 : imm_ext = {{20{inst[31]}},inst[31:20]};
        	 2'b01 : imm_ext = {{20{inst[31]}},inst[31:20]};
   		 default imm_ext ={{20{inst[31]}},inst[31:20]};
	endcase
	end
endmodule

module sign_extend_tb;
	reg [31:0]inst;
	reg [1:0] imm_scr;
	wire [31:0] imm_ext;
	
sign_extend uut(.inst(inst),
		.imm_scr(imm_scr),
		.imm_ext(imm_ext)
);

initial begin
	inst=32'b10000000000010000000000000000000;
	#10;
	imm_scr=2'b00;
	#10;
	$display("inst=%b,imm_scr=%b,imm_ext=%b",inst,imm_scr,imm_ext);
	$finish;
	end 
	endmodule
	
	
