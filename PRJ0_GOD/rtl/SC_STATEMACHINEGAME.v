//=======================================================
//  MODULE Definition
//=======================================================
module SC_STATEMACHINEGAME (
	//////////// INPUTS //////////
	SC_STATEMACHINEGAME_CLOCK_50,
	SC_STATEMACHINEGAME_RESET_InHigh,
	SC_STATEMACHINEGAME_startButton_InLow,
	//////////// OURS //////////
	
	SC_STATEMACHINEGAME_WinF_InLow,
	SC_STATEMACHINEGAME_WinL_InLow,
	SC_STATEMACHINEGAME_Lose_InLow,
	//////////// OUTPUTS //////////
	SC_STATEMACHINEGAME_Level_Out,
	SC_STATEMACHINEGAME_RESET_FromGame_Point,
	SC_STATEMACHINEGAME_SET_FrogGame,
	SC_STATEMACHINEGAME_Change_BACKG,
	STATE_Signal

);	
//=======================================================
//  PARAMETER declarations
//=======================================================
// states declaration
localparam STATE_RESET_0									= 0;
localparam STATE_RESET_1									= 1;
localparam STATE_RESET_2									= 2;
localparam STATE_RESET_3									= 3;

localparam STATE_CHECK_0									= 4;
localparam STATE_CHECK_1									= 5;
localparam STATE_CHECK_2									= 6;
localparam STATE_CHECK_3									= 7;

localparam STATE_LOSE_0									= 8;
localparam STATE_LOSE_1									= 9;
localparam STATE_LOSE_2									= 10;
localparam STATE_LOSE_3									= 11;

localparam STATE_START_00									= 12;
localparam STATE_START_01									= 13;
localparam STATE_START_02									= 14;
localparam STATE_START_03									= 15;

localparam STATE_WIN_00									= 16;
localparam STATE_WIN_01									= 17;
localparam STATE_WIN_02									= 18;
localparam STATE_WIN_03									= 19;

localparam STATE_LOAD_0									= 20;
localparam STATE_LOAD_1									= 21;
localparam STATE_LOAD_2									= 22;
localparam STATE_LOAD_3									= 23;
localparam STATE_LOAD_WIN								= 24;

localparam STATE_INIT 									= 25;





//=======================================================
//  PORT declarations
//=======================================================
input				SC_STATEMACHINEGAME_CLOCK_50;
input 			SC_STATEMACHINEGAME_RESET_InHigh;
input				SC_STATEMACHINEGAME_startButton_InLow;

// Ours

output reg		[3:0] SC_STATEMACHINEGAME_Level_Out;
output reg		[1:0] SC_STATEMACHINEGAME_RESET_FromGame_Point;
output reg		[1:0] SC_STATEMACHINEGAME_SET_FrogGame;
output reg		[1:0] SC_STATEMACHINEGAME_Change_BACKG;

input				SC_STATEMACHINEGAME_WinF_InLow;
input				SC_STATEMACHINEGAME_WinL_InLow;
input				SC_STATEMACHINEGAME_Lose_InLow;


//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [5:0] STATE_Register;
output reg [5:0] STATE_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
// NEXT STATE LOGIC : COMBINATIONAL
always @(*)
begin
	case (STATE_Register)
	
		STATE_RESET_0: STATE_Signal = STATE_CHECK_0; //reinicio n1
		STATE_RESET_1: STATE_Signal = STATE_CHECK_1; //reinicio n2
		STATE_RESET_2: STATE_Signal = STATE_CHECK_2; //reinicio n3
		STATE_RESET_3: STATE_Signal = STATE_CHECK_3; //reinicio n4
		
		STATE_LOSE_0: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_CHECK_0;// perdí n1 + :c
						else STATE_Signal = STATE_LOSE_0;
		STATE_LOSE_1: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_CHECK_1;// perdí n2 + :c
						else STATE_Signal = STATE_LOSE_1;
		STATE_LOSE_2: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_CHECK_2;// perdí n3 + :c
						else STATE_Signal = STATE_LOSE_2;
		STATE_LOSE_3: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_CHECK_3;// perdí n4 + :c
						else STATE_Signal = STATE_LOSE_3;
		
		STATE_START_00: STATE_Signal = STATE_CHECK_0; // reinicio con nuevo nido n1
		STATE_START_01: STATE_Signal = STATE_CHECK_1; // reinicio con nuevo nido n2
		STATE_START_02: STATE_Signal = STATE_CHECK_2; // reinicio con nuevo nido n3
		STATE_START_03: STATE_Signal = STATE_CHECK_3; // reinicio con nuevo nido n4
		
		STATE_WIN_00: STATE_Signal = STATE_START_00; // anide n1	
		STATE_WIN_01: STATE_Signal = STATE_START_01; // anide n2	
		STATE_WIN_02: STATE_Signal = STATE_START_02; // anide n3	
		STATE_WIN_03: STATE_Signal = STATE_START_03; // anide n4	
						
		STATE_LOAD_0: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_RESET_0; // pantalla de carga n1
						else STATE_Signal = STATE_LOAD_0;				
		STATE_LOAD_1: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_RESET_1; // pantalla de carga n2
						else STATE_Signal = STATE_LOAD_1;
		STATE_LOAD_2: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_RESET_2; // pantalla de carga n3
						else STATE_Signal = STATE_LOAD_2;
		STATE_LOAD_3: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_RESET_3; // pantalla de carga n4
						else STATE_Signal = STATE_LOAD_3;
		
		STATE_LOAD_WIN: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_LOAD_0; // pantalla de carga gane todo
						else STATE_Signal = STATE_LOAD_WIN;
		
		
		STATE_CHECK_0: if (SC_STATEMACHINEGAME_Lose_InLow == 1'b1) STATE_Signal = STATE_LOSE_0; //PERDI
						else  if (SC_STATEMACHINEGAME_WinF_InLow == 1'b0) STATE_Signal = STATE_WIN_00; //ANIDE
						else if (SC_STATEMACHINEGAME_WinL_InLow == 1'b1) STATE_Signal = STATE_LOAD_1; //GANE NIVEL
						else STATE_Signal = STATE_CHECK_0;
		
		STATE_CHECK_1: if (SC_STATEMACHINEGAME_Lose_InLow == 1'b1) STATE_Signal = STATE_LOSE_1; //PERDI
						else  if (SC_STATEMACHINEGAME_WinF_InLow == 1'b0) STATE_Signal = STATE_WIN_01; //ANIDE
						else if (SC_STATEMACHINEGAME_WinL_InLow == 1'b1) STATE_Signal = STATE_LOAD_2; //GANE NIVEL
						else STATE_Signal = STATE_CHECK_1;
						
		STATE_CHECK_2: if (SC_STATEMACHINEGAME_Lose_InLow == 1'b1) STATE_Signal = STATE_LOSE_2; //PERDI
						else  if (SC_STATEMACHINEGAME_WinF_InLow == 1'b0) STATE_Signal = STATE_WIN_02; //ANIDE
						else if (SC_STATEMACHINEGAME_WinL_InLow == 1'b1) STATE_Signal = STATE_LOAD_3; //GANE NIVEL
						else STATE_Signal = STATE_CHECK_2;
						
		STATE_CHECK_3: if (SC_STATEMACHINEGAME_Lose_InLow == 1'b1) STATE_Signal = STATE_LOSE_3; //PERDI
						else  if (SC_STATEMACHINEGAME_WinF_InLow == 1'b0) STATE_Signal = STATE_WIN_03; //ANIDE
						else if (SC_STATEMACHINEGAME_WinL_InLow == 1'b1) STATE_Signal = STATE_LOAD_WIN; //GANE NIVEL
						else STATE_Signal = STATE_CHECK_3;
				
		STATE_INIT: if (SC_STATEMACHINEGAME_startButton_InLow == 1'b0) STATE_Signal = STATE_LOAD_0;
						else STATE_Signal = STATE_INIT;
						
		
		default : 		STATE_Signal = STATE_INIT;
	endcase
end
// STATE REGISTER : SEQUENTIAL
always @ ( posedge SC_STATEMACHINEGAME_CLOCK_50 , posedge SC_STATEMACHINEGAME_RESET_InHigh)
begin
	if (SC_STATEMACHINEGAME_RESET_InHigh == 1'b1)
		STATE_Register <= STATE_RESET_0;
	else
		STATE_Register <= STATE_Signal;
	
	//$display ("Register = %d", STATE_Register);
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
always @ (*)
begin
	case (STATE_Register)
//=========================================================
// STATE_RESET
//=========================================================
	STATE_RESET_0 :	
		begin 
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b1;
			SC_STATEMACHINEGAME_Level_Out = 4'b0000;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
	STATE_RESET_1 :	
		begin 
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b1;
			SC_STATEMACHINEGAME_Level_Out = 4'b0001;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
	STATE_RESET_2 :	
		begin 
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b1;
			SC_STATEMACHINEGAME_Level_Out = 4'b0010;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
	STATE_RESET_3 :	
		begin 
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b1;
			SC_STATEMACHINEGAME_Level_Out = 4'b0011;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
//=========================================================
// STATE_START
//=========================================================
	STATE_START_00 :	
		begin
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Level_Out = 4'b0000;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
		
	STATE_START_01 :	
		begin
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Level_Out = 4'b0001;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
	STATE_START_02 :	
		begin
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Level_Out = 4'b0010;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
	STATE_START_03 :	
		begin
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Level_Out = 4'b0011;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
//=========================================================
// STATE_CHECK
//=========================================================
	STATE_CHECK_0 :
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0000;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
	STATE_CHECK_1 :
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0001;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
	STATE_CHECK_2 :
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0010;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
	STATE_CHECK_3 :
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0011;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end

//=========================================================
// STATE_LOSE_0
//=========================================================
	STATE_LOSE_0 :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b1000;//8
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b1;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
	STATE_LOSE_1 :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b1000;//8
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b1;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
	STATE_LOSE_2 :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b1000;//8
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b1;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
	STATE_LOSE_3 :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b1000;//8
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b1;
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
	
//=========================================================
// STATE_WIN
//=========================================================
	STATE_WIN_00 :	
		begin
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b1;
			SC_STATEMACHINEGAME_Level_Out = 4'b0000;//n1
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
	STATE_WIN_01 :	
		begin
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b1;
			SC_STATEMACHINEGAME_Level_Out = 4'b0001;//n2
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
	STATE_WIN_02 :	
		begin
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b1;
			SC_STATEMACHINEGAME_Level_Out = 4'b0010;//n3
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end
	STATE_WIN_03 :	
		begin
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b1;
			SC_STATEMACHINEGAME_Level_Out = 4'b0011;//n4
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b0;
		end

//=========================================================
// STATE_LOAD
//=========================================================

	STATE_LOAD_0 :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0100;//4
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
		
		STATE_LOAD_1 :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0101;//5
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
		
		STATE_LOAD_2 :	
		
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0110;//6
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
		
		STATE_LOAD_3 :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0111;//7
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
		
		STATE_LOAD_WIN :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b1001;//9
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
		
		STATE_INIT :	
		begin
			SC_STATEMACHINEGAME_Level_Out = 4'b0100;//4
			SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
			SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
			SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end

//=========================================================
// DEFAULT
//=========================================================
	default :
		begin
		SC_STATEMACHINEGAME_SET_FrogGame = 1'b0;
		SC_STATEMACHINEGAME_Level_Out = 4'b0100;
		SC_STATEMACHINEGAME_RESET_FromGame_Point = 1'b0;
		SC_STATEMACHINEGAME_Change_BACKG = 1'b1;
		end
	endcase
end
endmodule
