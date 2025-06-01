module mux_alu2_sel(
	
	input wire [31:0] a2,
	input wire [31:0] imm_ext,
	input 		  alu_scr2,
	output wire [31:0]mux_scr2
);

assign mux_scr2=alu_scr2?imm_ext:a2;

endmodule

module mux_alu2_sel_tb;
	reg [31:0] a2;
	reg [31:0] imm_ext;
	reg 	   alu_scr2;
	wire [31:0]mux_scr2;
	
  mux_alu2_sel uut (
        .a2(a2),
        .imm_ext(imm_ext),
        .alu_scr2(alu_scr2),
        .mux_scr2(mux_scr2)
    );
	
initial begin
	#10;
	a2=32'd2;
	imm_ext=32'd4;
	#10;
	alu_scr2=0;
  #10;
	$display("mux_scr2=%d",mux_scr2);
	#10;
	alu_scr2=1;
  #10;
	$display("mux_scr2=%d",mux_scr2);
	$finish;
	end
	endmodule
	
	
