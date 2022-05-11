//
//=======================================================
//  MODULE Definition
//=======================================================
module SC_COUNTER (
	//////////// OUTPUTS //////////
	SC_COUNTER_out,
	//////////// INPUTS //////////
	SC_COUNTER_CLOCK_50,
	SC_COUNTER_RESET_InHigh,
	SC_COUNTER_data_in,
	SC_COUNTER_level
);
//=======================================================
//  PARAMETER declarations
//=======================================================
//=======================================================
//  PORT declarations
//=======================================================
output	SC_COUNTER_out;
input		SC_COUNTER_CLOCK_50;
input		SC_COUNTER_RESET_InHigh;
input		SC_COUNTER_data_in;
input		SC_COUNTER_level;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg signal;
reg registro;
//=======================================================
//  Structural coding
//=======================================================	
//INPUT LOGIC: COMBINATIONAL
//always @(*)
//begin
	//if (SC_COUNTER_data_in == 1'b1)
		//signal = SC_COUNTER_level + 1;
	//else
		//signal = registro;
	//end
//STATE REGISTER: SEQUENTIAL
always @(posedge SC_COUNTER_CLOCK_50, posedge SC_COUNTER_RESET_InHigh)
begin
	if (SC_COUNTER_RESET_InHigh == 1'b1)
		registro <= 2'b0;
	else if (SC_COUNTER_data_in == 1'b1)
		signal = SC_COUNTER_level + 1;
	else
		registro <= signal;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign SC_COUNTER_out = registro;
endmodule
