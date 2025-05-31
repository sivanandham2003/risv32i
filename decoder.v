module decoder2 (
	input wire [31:0]inst,
	output reg [4:0] rd,
	output reg [4:0] rs1,
	output reg [4:0] rs2,
	output reg [2:0] funct3,
	output reg [6:0] funct7,
	output reg [1:0] alu_sel,
	output reg [1:0] ld_sel,
	output reg [11:0]imm,
	output reg       mem_enb,
	output reg 	 reg_write,
	output reg 	 alu_scr2,
	output reg	 imm_scr
);

wire [6:0] opcode ;
assign opcode = inst[6:0];

localparam load    =7'b0000011;		//load
localparam r_type  =7'b0110011;		//add,sub,or,and
localparam r_imm   =7'b0010011;		//addi,ori,andi

localparam add     ={3'b000,7'b0000000};
localparam sub     ={3'b000,7'b0100000};
localparam or1     ={3'b110,7'b0000000};
localparam and1    ={3'b111,7'b0000000};


always @(*) begin
	
	case (opcode) 
	
	r_type: begin
		rd	=inst[11:7];
		funct3  =inst[14:12];
		rs1	=inst[19:15];
		rs2	=inst[24:20];
		funct7	=inst[31:25];
		alu_scr2=1'b0;				//select alu's second input whether that is immediate or from registor
		reg_write=1'b1;				//it enable the permission of register to write a data into it
		mem_enb	=1'b0;	
		imm_scr =2'b00;			// it control the memory accsess
		case ({funct3,funct7}) 
			{3'b000, 7'b0000000}: alu_sel	= 2'b00;	//add
			{3'b000, 7'b0100000} : alu_sel	= 2'b01;	//xor
			{3'b110, 7'b0000000} : alu_sel	= 2'b10;	//or
			{3'b111, 7'b0000000}: alu_sel	= 2'b11;	//and
			 
		endcase
		end
	
	load: begin
		rd	=inst[11:7];
		funct3	=inst[14:12];
		rs1	=inst[19:15];
		imm 	=inst[31:20];
		reg_write=1'b1;
		mem_enb=1'b0;
		imm_scr=2'b00;
		case (funct3) 
			3'b010 : ld_sel	= 2'b00;	//load word 
			3'b001 : ld_sel = 2'b01;	//load half word
			
		endcase
		end
		
	r_imm: begin
		rd	=inst[11:7];
		funct3	=inst[14:12];
		rs1	=inst[19:15];
		imm 	=inst[31:20];
		reg_write=1'b1;
		mem_enb	=1'b0;
		alu_scr2=1'b1;
		imm_scr	=2'b00;
		
		case (funct3) 
			3'b000 : alu_sel=2'b00;	//addi
			3'b100 : alu_sel=2'b01;	//xori
			3'b110 : alu_sel=2'b10;	//ori
			3'b111 : alu_sel=2'b11;	//andi
			
		endcase
		
	end
	endcase
end	
endmodule	
			
			
		
			
			
