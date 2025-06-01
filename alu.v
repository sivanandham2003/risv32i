module alu(
  input wire [31:0] a1,
  input wire [31:0] mux_scr2,
  input wire [1:0] alu_sel,
  output reg [31:0] alu_rslt
	
);

always@(*) begin
 	case(alu_sel) 
 	
 		2'b00:alu_rslt = a1 + mux_scr2;
 		2'b01:alu_rslt = a1 - mux_scr2;
 		2'b10:alu_rslt = a1 & mux_scr2;
 		2'b11:alu_rslt = a1 | mux_scr2;
 		
 	endcase
 	end 
 endmodule
 
 module alu_tb;
   reg [31:0]a1;
   reg [31:0] mux_scr2;
   reg [1:0] alu_sel;
	 wire [31:0] alu_rslt;
   
   alu uut(
        .a1(a1),
        .mux_scr2(mux_scr2),
        .alu_sel(alu_sel),
        .alu_rslt(alu_rslt)
    );
initial begin

a1=32'd2;
mux_scr2=32'd1;
alu_sel=00;
#10;
  $display("alu_rslt=%d",alu_rslt);
#10;
alu_sel=01;
#10;
  $display("alu_rslt=%d",alu_rslt);
$finish;
end 
endmodule

