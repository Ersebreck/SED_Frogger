/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
//# Copyright (C) 2018. F.E.Segura-Quijano (FES) fsegura@uniandes.edu.co
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>
//####################################################################*/
//=======================================================
//  MODULE Definition 
//=======================================================
module BB_SYSTEM (
//////////// OUTPUTS /////////

	BB_SYSTEM_display_OutBUS,
	BB_SYSTEM_max7219DIN_Out,
	BB_SYSTEM_max7219NCS_Out,
	BB_SYSTEM_max7219CLK_Out,

	BB_SYSTEM_state,
	BB_SYSTEM_point_1,
	BB_SYSTEM_back_1,
	BB_SYSTEM_point_6,
	BB_SYSTEM_point_7,
	BB_SYSTEM_back_7,
	
	BB_SYSTEM_COMP_perdi,
	BB_SYSTEM_COMP_anidado,
	BB_SYSTEM_COMP_nivel,
	
	BB_SYSTEM_COUNT_LEVEL,
	BB_SYSTEM_LEVEL,

//////////// INPUTS //////////
	BB_SYSTEM_CLOCK_50,
	BB_SYSTEM_RESET_InHigh,
	BB_SYSTEM_startButton_InLow, 
	BB_SYSTEM_upButton_InLow,
	BB_SYSTEM_downButton_InLow,
	BB_SYSTEM_leftButton_InLow,
	BB_SYSTEM_rightButton_InLow
);
//=======================================================
//  PARAMETER declarations
//=======================================================
 parameter DATAWIDTH_BUS = 8;
 parameter PRESCALER_DATAWIDTH = 23;
 parameter DISPLAY_DATAWIDTH = 12;
 
 parameter DATA_FIXED_INITREGPOINT_7 = 8'b00000000;
 parameter DATA_FIXED_INITREGPOINT_6 = 8'b00000000;
 parameter DATA_FIXED_INITREGPOINT_5 = 8'b00000000;
 parameter DATA_FIXED_INITREGPOINT_4 = 8'b00000000;
 parameter DATA_FIXED_INITREGPOINT_3 = 8'b00000000;
 parameter DATA_FIXED_INITREGPOINT_2 = 8'b00000000;
 parameter DATA_FIXED_INITREGPOINT_1 = 8'b00000000;
 parameter DATA_FIXED_INITREGPOINT_0 = 8'b00010000;
 
 parameter N1_7 = 8'b11010111;
 parameter N1_6 = 8'b00000000;
 parameter N1_5 = 8'b10010010;
 parameter N1_4 = 8'b00000000;
 parameter N1_3 = 8'b10000111;
 parameter N1_2 = 8'b00000000;
 parameter N1_1 = 8'b11100001;
 parameter N1_0 = 8'b00000000;
 
 parameter N2_7 = 8'b11101111;
 parameter N2_6 = 8'b00000000;
 parameter N2_5 = 8'b11100011;
 parameter N2_4 = 8'b00000000;
 parameter N2_3 = 8'b10011001;
 parameter N2_2 = 8'b00000000;
 parameter N2_1 = 8'b10001010;
 parameter N2_0 = 8'b00000000;
 
 parameter N3_7 = 8'b11110111;
 parameter N3_6 = 8'b00000000;
 parameter N3_5 = 8'b11000111;
 parameter N3_4 = 8'b00000000;
 parameter N3_3 = 8'b00100111;
 parameter N3_2 = 8'b00000000;
 parameter N3_1 = 8'b01100110;
 parameter N3_0 = 8'b00000000;
 
 parameter N4_7 = 8'b11101111;
 parameter N4_6 = 8'b00000000;
 parameter N4_5 = 8'b00100111;
 parameter N4_4 = 8'b00000000;
 parameter N4_3 = 8'b11100111;
 parameter N4_2 = 8'b00000000;
 parameter N4_1 = 8'b10100100;
 parameter N4_0 = 8'b00000000;
 
 parameter CN1_7 = 8'b00000000;
 parameter CN1_6 = 8'b00011000;
 parameter CN1_5 = 8'b00111000;
 parameter CN1_4 = 8'b00011000;
 parameter CN1_3 = 8'b00011000;
 parameter CN1_2 = 8'b00011000;
 parameter CN1_1 = 8'b00111100;
 parameter CN1_0 = 8'b00000000;

parameter  CN2_7 = 8'b00000000;
parameter  CN2_6 = 8'b00111100;
parameter  CN2_5 = 8'b00100100;
parameter  CN2_4 = 8'b00000100;
parameter  CN2_3 = 8'b00001000;
parameter  CN2_2 = 8'b00010000;
parameter  CN2_1 = 8'b00111100;
parameter  CN2_0 = 8'b00000000;
 
parameter  CN3_7 = 8'b00000000;
parameter  CN3_6 = 8'b00111100;
parameter  CN3_5 = 8'b00100100;
parameter  CN3_4 = 8'b00001100;
parameter  CN3_3 = 8'b00000100;
parameter  CN3_2 = 8'b00100100;
parameter  CN3_1 = 8'b00111100;
parameter  CN3_0 = 8'b00000000;

parameter  CN4_7 = 8'b00000000;
parameter  CN4_6 = 8'b00001000;
parameter  CN4_5 = 8'b00011000;
parameter  CN4_4 = 8'b00101000;
parameter  CN4_3 = 8'b01111110;
parameter  CN4_2 = 8'b00001000;
parameter  CN4_1 = 8'b00001000;
parameter  CN4_0 = 8'b00000000;

parameter  P_7 = 8'b01111110;
parameter  P_6 = 8'b10011001;
parameter  P_5 = 8'b10011001;
parameter  P_4 = 8'b11111111;
parameter  P_3 = 8'b11000011;
parameter  P_2 = 8'b11011011;
parameter  P_1 = 8'b11011011;
parameter  P_0 = 8'b11111111;

parameter  G_7 = 8'b11111111;
parameter  G_6 = 8'b10011001;
parameter  G_5 = 8'b10011001;
parameter  G_4 = 8'b11111111;
parameter  G_3 = 8'b11011011;
parameter  G_2 = 8'b11011011;
parameter  G_1 = 8'b11000011;
parameter  G_0 = 8'b11111111;
 
parameter N=0;
 
//=======================================================
//  PORT declarations
//=======================================================
output		[DISPLAY_DATAWIDTH-1:0] BB_SYSTEM_display_OutBUS;

output		BB_SYSTEM_max7219DIN_Out;
output		BB_SYSTEM_max7219NCS_Out;
output		BB_SYSTEM_max7219CLK_Out;

output	[5:0] BB_SYSTEM_state;
output	[7:0] BB_SYSTEM_point_6;
output	[7:0] BB_SYSTEM_point_7;
	
output	[7:0] BB_SYSTEM_back_7;

output 	[7:0]	BB_SYSTEM_COMP_anidado;
output 	BB_SYSTEM_COMP_perdi;
output	BB_SYSTEM_COMP_nivel;

output	BB_SYSTEM_point_1;
output	BB_SYSTEM_back_1;

output   [3:0] BB_SYSTEM_COUNT_LEVEL;
output   [7:0] BB_SYSTEM_LEVEL;

input		BB_SYSTEM_CLOCK_50;
input		BB_SYSTEM_RESET_InHigh;
input		BB_SYSTEM_startButton_InLow;
input		BB_SYSTEM_upButton_InLow;
input		BB_SYSTEM_downButton_InLow;
input		BB_SYSTEM_leftButton_InLow;
input		BB_SYSTEM_rightButton_InLow;


//=======================================================
//  REG/WIRE declarations
//=======================================================
// BUTTONs
wire 	BB_SYSTEM_startButton_InLow_cwire;
wire 	BB_SYSTEM_upButton_InLow_cwire;
wire 	BB_SYSTEM_downButton_InLow_cwire;
wire 	BB_SYSTEM_leftButton_InLow_cwire;
wire 	BB_SYSTEM_rightButton_InLow_cwire;

//POINT
wire	STATEMACHINEPOINT_clear_cwire;
wire	STATEMACHINEPOINT_load0_cwire;
wire	STATEMACHINEPOINT_load1_cwire;
wire	[1:0] STATEMACHINEPOINT_shiftselection_cwire;

wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data7_Out;
wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data6_Out;
wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data5_Out;
wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data4_Out;
wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data3_Out;
wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data2_Out;
wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data1_Out;
wire [DATAWIDTH_BUS-1:0] RegPOINTTYPE_2_POINTMATRIX_data0_Out;

//BACKGROUNG
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data7_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data6_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data5_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data4_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data3_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data2_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data1_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKGTYPE_2_BACKGMATRIX_data0_Out;

wire [PRESCALER_DATAWIDTH-1:0] upSPEEDCOUNTER_data_BUS_wire;
wire SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire;
wire STATEMACHINEBACKG_clear_cwire;
wire STATEMACHINEBACKG_load_cwire;
wire [1:0] STATEMACHINEBACKG_shiftselection_cwire;
wire STATEMACHINEBACKG_upcount_cwire;

//BOTTOMSIDE COMPARATOR
wire BOTTOMSIDECOMPARATOR_2_STATEMACHINEBACKG_bottomside_cwire;

// GAME
wire [DATAWIDTH_BUS-1:0] regGAME_data7_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data6_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data5_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data4_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data3_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data2_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data1_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data0_wire;

wire 	[7:0] data_max;
wire 	[2:0] add;

wire [DATAWIDTH_BUS-1:0] upCOUNTER_2_BIN2BCD1_data_BUS_wire;
wire [DISPLAY_DATAWIDTH-1:0] BIN2BCD1_2_SEVENSEG1_data_BUS_wire;

// OURS

wire STATEMACHINEGAME_clear_cwire;
wire STATEMACHINEGAME_load_cwire;
wire STATEMACHINEGAME_upcount_cwire;
wire STATEMACHINEGAME_shiftselection_cwire;
wire COUNT_LEVEL_IN;
wire [3:0] COUNT_LEVEL_OUT;
wire GAME_RESET_P;
wire GAME_RESET_B;
wire STATE_GAME;

// comparador
wire COMP_LOSE;
wire [7:0] COMP_WIN_FROG;
wire COMP_WIN_LEVEL;
wire [7:0] COMP_anidado;
// estados
wire [3:0] GAME_Signal;
wire [3:0] BACK_Signal;
wire [3:0] POINT_Signal;
// muxs
wire [7:0] mux_0;
wire [7:0] mux_1;
wire [7:0] mux_2;
wire [7:0] mux_3;
wire [7:0] mux_4;
wire [7:0] mux_5;
wire [7:0] mux_6;
wire [7:0] mux_7;
wire [1:0] change_backg;

wire [5:0] estado;


//=======================================================
//  Structural coding
//=======================================================

//######################################################################
//#	INPUTS
//######################################################################
SC_DEBOUNCE1 SC_DEBOUNCE1_u0 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_startButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_startButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE1_u1 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_upButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_upButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE1_u2 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_downButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_downButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE1_u3 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_leftButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_leftButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE1_u4 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_rightButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_rightButton_InLow)
);

//######################################################################
//#	POINT
//######################################################################
SC_RegPOINTTYPE #(.RegPOINTTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGPOINT(DATA_FIXED_INITREGPOINT_7)) SC_RegPOINTTYPE_u7 (
// port map - connection between master ports and signals/registers   
	.SC_RegPOINTTYPE_data_OutBUS(RegPOINTTYPE_2_POINTMATRIX_data7_Out), //SALIDA
	.SC_RegPOINTTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegPOINTTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegPOINTTYPE_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegPOINTTYPE_load0_InLow(STATEMACHINEPOINT_load0_cwire),
	.SC_RegPOINTTYPE_load1_InLow(STATEMACHINEPOINT_load1_cwire),
	.SC_RegPOINTTYPE_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegPOINTTYPE_data0_InBUS(RegPOINTTYPE_2_POINTMATRIX_data6_Out),
	.SC_RegPOINTTYPE_data1_InBUS(RegPOINTTYPE_2_POINTMATRIX_data0_Out)
);
SC_RegPOINTTYPE #(.RegPOINTTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGPOINT(DATA_FIXED_INITREGPOINT_6)) SC_RegPOINTTYPE_u6 (
// port map - connection between master ports and signals/registers   
	.SC_RegPOINTTYPE_data_OutBUS(RegPOINTTYPE_2_POINTMATRIX_data6_Out),
	.SC_RegPOINTTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegPOINTTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegPOINTTYPE_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegPOINTTYPE_load0_InLow(STATEMACHINEPOINT_load0_cwire),
	.SC_RegPOINTTYPE_load1_InLow(STATEMACHINEPOINT_load1_cwire),
	.SC_RegPOINTTYPE_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegPOINTTYPE_data0_InBUS(RegPOINTTYPE_2_POINTMATRIX_data5_Out),
	.SC_RegPOINTTYPE_data1_InBUS(RegPOINTTYPE_2_POINTMATRIX_data7_Out)
);
SC_RegPOINTTYPE #(.RegPOINTTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGPOINT(DATA_FIXED_INITREGPOINT_5)) SC_RegPOINTTYPE_u5 (
// port map - connection between master ports and signals/registers   
	.SC_RegPOINTTYPE_data_OutBUS(RegPOINTTYPE_2_POINTMATRIX_data5_Out),
	.SC_RegPOINTTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegPOINTTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegPOINTTYPE_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegPOINTTYPE_load0_InLow(STATEMACHINEPOINT_load0_cwire),
	.SC_RegPOINTTYPE_load1_InLow(STATEMACHINEPOINT_load1_cwire),
	.SC_RegPOINTTYPE_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegPOINTTYPE_data0_InBUS(RegPOINTTYPE_2_POINTMATRIX_data4_Out),
	.SC_RegPOINTTYPE_data1_InBUS(RegPOINTTYPE_2_POINTMATRIX_data6_Out)
);
SC_RegPOINTTYPE #(.RegPOINTTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGPOINT(DATA_FIXED_INITREGPOINT_4)) SC_RegPOINTTYPE_u4 (
// port map - connection between master ports and signals/registers   
	.SC_RegPOINTTYPE_data_OutBUS(RegPOINTTYPE_2_POINTMATRIX_data4_Out),
	.SC_RegPOINTTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegPOINTTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegPOINTTYPE_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegPOINTTYPE_load0_InLow(STATEMACHINEPOINT_load0_cwire),
	.SC_RegPOINTTYPE_load1_InLow(STATEMACHINEPOINT_load1_cwire),
	.SC_RegPOINTTYPE_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegPOINTTYPE_data0_InBUS(RegPOINTTYPE_2_POINTMATRIX_data3_Out),
	.SC_RegPOINTTYPE_data1_InBUS(RegPOINTTYPE_2_POINTMATRIX_data5_Out)
);
SC_RegPOINTTYPE #(.RegPOINTTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGPOINT(DATA_FIXED_INITREGPOINT_3)) SC_RegPOINTTYPE_u3 (
// port map - connection between master ports and signals/registers   
	.SC_RegPOINTTYPE_data_OutBUS(RegPOINTTYPE_2_POINTMATRIX_data3_Out),
	.SC_RegPOINTTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegPOINTTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegPOINTTYPE_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegPOINTTYPE_load0_InLow(STATEMACHINEPOINT_load0_cwire),
	.SC_RegPOINTTYPE_load1_InLow(STATEMACHINEPOINT_load1_cwire),
	.SC_RegPOINTTYPE_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegPOINTTYPE_data0_InBUS(RegPOINTTYPE_2_POINTMATRIX_data2_Out),
	.SC_RegPOINTTYPE_data1_InBUS(RegPOINTTYPE_2_POINTMATRIX_data4_Out)
);
SC_RegPOINTTYPE #(.RegPOINTTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGPOINT(DATA_FIXED_INITREGPOINT_2)) SC_RegPOINTTYPE_u2 (
// port map - connection between master ports and signals/registers   
	.SC_RegPOINTTYPE_data_OutBUS(RegPOINTTYPE_2_POINTMATRIX_data2_Out),
	.SC_RegPOINTTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegPOINTTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegPOINTTYPE_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegPOINTTYPE_load0_InLow(STATEMACHINEPOINT_load0_cwire),
	.SC_RegPOINTTYPE_load1_InLow(STATEMACHINEPOINT_load1_cwire),
	.SC_RegPOINTTYPE_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegPOINTTYPE_data0_InBUS(RegPOINTTYPE_2_POINTMATRIX_data1_Out),
	.SC_RegPOINTTYPE_data1_InBUS(RegPOINTTYPE_2_POINTMATRIX_data3_Out)
);
SC_RegPOINTTYPE #(.RegPOINTTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGPOINT(DATA_FIXED_INITREGPOINT_1)) SC_RegPOINTTYPE_u1 (
// port map - connection between master ports and signals/registers   
	.SC_RegPOINTTYPE_data_OutBUS(RegPOINTTYPE_2_POINTMATRIX_data1_Out),
	.SC_RegPOINTTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegPOINTTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegPOINTTYPE_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegPOINTTYPE_load0_InLow(STATEMACHINEPOINT_load0_cwire),
	.SC_RegPOINTTYPE_load1_InLow(STATEMACHINEPOINT_load1_cwire),
	.SC_RegPOINTTYPE_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegPOINTTYPE_data0_InBUS(RegPOINTTYPE_2_POINTMATRIX_data0_Out),
	.SC_RegPOINTTYPE_data1_InBUS(RegPOINTTYPE_2_POINTMATRIX_data2_Out)
);
SC_RegPOINTTYPE #(.RegPOINTTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGPOINT(DATA_FIXED_INITREGPOINT_0)) SC_RegPOINTTYPE_u0 (
// port map - connection between master ports and signals/registers   
	.SC_RegPOINTTYPE_data_OutBUS(RegPOINTTYPE_2_POINTMATRIX_data0_Out),
	.SC_RegPOINTTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegPOINTTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegPOINTTYPE_clear_InLow(STATEMACHINEPOINT_clear_cwire),
	.SC_RegPOINTTYPE_load0_InLow(STATEMACHINEPOINT_load0_cwire),
	.SC_RegPOINTTYPE_load1_InLow(STATEMACHINEPOINT_load1_cwire),
	.SC_RegPOINTTYPE_shiftselection_In(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_RegPOINTTYPE_data0_InBUS(RegPOINTTYPE_2_POINTMATRIX_data7_Out),
	.SC_RegPOINTTYPE_data1_InBUS(RegPOINTTYPE_2_POINTMATRIX_data1_Out)
);

//#STATEMACHINEPOINT
SC_STATEMACHINEPOINT SC_STATEMACHINEPOINT_u0 (
// port map - connection between master ports and signals/registers   
	.SC_STATEMACHINEPOINT_clear_OutLow(STATEMACHINEPOINT_clear_cwire), 
	.SC_STATEMACHINEPOINT_load0_OutLow(STATEMACHINEPOINT_load0_cwire), 
	.SC_STATEMACHINEPOINT_load1_OutLow(STATEMACHINEPOINT_load1_cwire), 
	.SC_STATEMACHINEPOINT_shiftselection_Out(STATEMACHINEPOINT_shiftselection_cwire),
	.SC_STATEMACHINEPOINT_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEPOINT_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEPOINT_startButton_InLow(BB_SYSTEM_startButton_InLow_cwire), 
	.SC_STATEMACHINEPOINT_upButton_InLow(BB_SYSTEM_upButton_InLow_cwire), 
	.SC_STATEMACHINEPOINT_downButton_InLow(BB_SYSTEM_downButton_InLow_cwire), 
	.SC_STATEMACHINEPOINT_leftButton_InLow(BB_SYSTEM_leftButton_InLow_cwire), 
	.SC_STATEMACHINEPOINT_rightButton_InLow(BB_SYSTEM_rightButton_InLow_cwire), 
	.SC_STATEMACHINEPOINT_bottomsidecomparator_InLow(BOTTOMSIDECOMPARATOR_2_STATEMACHINEBACKG_bottomside_cwire),
	.SC_STATEMACHINEPOINT_RESET_FromGame(GAME_RESET_P),
	.SC_STATEMACHINEPOINT_WINF(COMP_anidado),
	.STATE_Signal(POINT_Signal)
);

//######################################################################
//#	BACKGROUND
//######################################################################
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGBACKG()) SC_RegBACKGTYPE_u7 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS(RegBACKGTYPE_2_BACKGMATRIX_data7_Out),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(STATEMACHINEBACKG_load_cwire),
	.SC_RegBACKGTYPE_shiftselection_In(), // se deja la ultima fila fija
	.SC_RegBACKGTYPE_data_InBUS(mux_7),
	
	
	.SC_RegBACKGTYPE_NN(COMP_WIN_FROG),
	.SC_RegBACKGTYPE_SET_NN(COMP_anidado)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGBACKG()) SC_RegBACKGTYPE_u6 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS(RegBACKGTYPE_2_BACKGMATRIX_data6_Out),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(STATEMACHINEBACKG_load_cwire),
	.SC_RegBACKGTYPE_shiftselection_In(STATEMACHINEBACKG_shiftselection_cwire),
	.SC_RegBACKGTYPE_data_InBUS(mux_6)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGBACKG()) SC_RegBACKGTYPE_u5 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS(RegBACKGTYPE_2_BACKGMATRIX_data5_Out),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(STATEMACHINEBACKG_load_cwire),
	.SC_RegBACKGTYPE_shiftselection_In(STATEMACHINEBACKG_shiftselection_cwire),
	.SC_RegBACKGTYPE_data_InBUS(mux_5)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGBACKG()) SC_RegBACKGTYPE_u4 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS(RegBACKGTYPE_2_BACKGMATRIX_data4_Out),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(STATEMACHINEBACKG_load_cwire),
	.SC_RegBACKGTYPE_shiftselection_In(STATEMACHINEBACKG_shiftselection_cwire),
	.SC_RegBACKGTYPE_data_InBUS(mux_4)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGBACKG()) SC_RegBACKGTYPE_u3 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS(RegBACKGTYPE_2_BACKGMATRIX_data3_Out),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(STATEMACHINEBACKG_load_cwire),
	.SC_RegBACKGTYPE_shiftselection_In(STATEMACHINEBACKG_shiftselection_cwire),
	.SC_RegBACKGTYPE_data_InBUS(mux_3)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGBACKG(N1_2)) SC_RegBACKGTYPE_u2 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS(RegBACKGTYPE_2_BACKGMATRIX_data2_Out),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(STATEMACHINEBACKG_load_cwire),
	.SC_RegBACKGTYPE_shiftselection_In(STATEMACHINEBACKG_shiftselection_cwire),
	.SC_RegBACKGTYPE_data_InBUS(mux_2)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGBACKG()) SC_RegBACKGTYPE_u1 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS(RegBACKGTYPE_2_BACKGMATRIX_data1_Out),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(STATEMACHINEBACKG_load_cwire),
	.SC_RegBACKGTYPE_shiftselection_In(STATEMACHINEBACKG_shiftselection_cwire),
	.SC_RegBACKGTYPE_data_InBUS(mux_1)
);
SC_RegBACKGTYPE #(.RegBACKGTYPE_DATAWIDTH(DATAWIDTH_BUS), .DATA_FIXED_INITREGBACKG()) SC_RegBACKGTYPE_u0 (
// port map - connection between master ports and signals/registers   
	.SC_RegBACKGTYPE_data_OutBUS(RegBACKGTYPE_2_BACKGMATRIX_data0_Out),
	.SC_RegBACKGTYPE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKGTYPE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKGTYPE_clear_InLow(STATEMACHINEBACKG_clear_cwire),	
	.SC_RegBACKGTYPE_load_InLow(STATEMACHINEBACKG_load_cwire),
	.SC_RegBACKGTYPE_shiftselection_In(STATEMACHINEBACKG_shiftselection_cwire),
	.SC_RegBACKGTYPE_data_InBUS(mux_0)
);
SC_STATEMACHINEBACKG SC_STATEMACHINEBACKG_u0 (
// port map - connection between master ports and signals/registers   
	.SC_STATEMACHINEBACKG_clear_OutLow(STATEMACHINEBACKG_clear_cwire), 
	.SC_STATEMACHINEBACKG_load_OutLow(STATEMACHINEBACKG_load_cwire), 
	.SC_STATEMACHINEBACKG_shiftselection_Out(STATEMACHINEBACKG_shiftselection_cwire),
	.SC_STATEMACHINEBACKG_upcount_out(STATEMACHINEBACKG_upcount_cwire),
	.SC_STATEMACHINEBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEBACKG_startButton_InLow(BB_SYSTEM_startButton_InLow_cwire),
	.SC_STATEMACHINEBACKG_T0_InLow(SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire),
	.SC_STATEMACHINEBACKG_WINF(COMP_anidado),
	.SC_STATEMACHINEBACKG_WINL(COMP_WIN_LEVEL),
	.SC_STATEMACHINEBACKG_Change_BACKG(change_backg)
);

//-----OURS----
SC_STATEMACHINEGAME SC_STATEMACHINEGAME_u0 (
// port map - connection between master ports and signals/registers   

	.SC_STATEMACHINEGAME_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEGAME_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEGAME_startButton_InLow(BB_SYSTEM_startButton_InLow_cwire),
	
	.SC_STATEMACHINEGAME_WinF_InLow(COMP_WIN_FROG),
	.SC_STATEMACHINEGAME_WinL_InLow(COMP_WIN_LEVEL),
	.SC_STATEMACHINEGAME_Lose_InLow(COMP_LOSE),
	.SC_STATEMACHINEGAME_Level_Out(COUNT_LEVEL_OUT),
	.SC_STATEMACHINEGAME_RESET_FromGame_Point(GAME_RESET_P),
	.SC_STATEMACHINEGAME_SET_FrogGame(WIN_FROG),
	.SC_STATEMACHINEGAME_Change_BACKG(change_backg),
	.STATE_Signal(estado)
	
);
//#COMPARATION
CC_REGISTERCOMPARATOR CC_REGISTERCOMPARATOR_1 (
// PORT MAP
	.CC_REGISTERCOMPARATOR_WinF_OutLow(COMP_WIN_FROG),
	.CC_REGISTERCOMPARATOR_WinL_OutLow(COMP_WIN_LEVEL),	
	.CC_REGISTERCOMPARATOR_Lose_OutLow(COMP_LOSE),
	.CC_REGISTERCOMPARATOR_NN_Outlow(COMP_anidado),

	.CC_BACKREG_0(RegBACKGTYPE_2_BACKGMATRIX_data0_Out),
	.CC_BACKREG_1(RegBACKGTYPE_2_BACKGMATRIX_data1_Out),
	.CC_BACKREG_2(RegBACKGTYPE_2_BACKGMATRIX_data2_Out),
	.CC_BACKREG_3(RegBACKGTYPE_2_BACKGMATRIX_data3_Out),
	.CC_BACKREG_4(RegBACKGTYPE_2_BACKGMATRIX_data4_Out),
	.CC_BACKREG_5(RegBACKGTYPE_2_BACKGMATRIX_data5_Out),
	.CC_BACKREG_6(RegBACKGTYPE_2_BACKGMATRIX_data6_Out),
	.CC_BACKREG_7(RegBACKGTYPE_2_BACKGMATRIX_data7_Out),
	
	.CC_POINTREG_0(RegPOINTTYPE_2_POINTMATRIX_data0_Out),
	.CC_POINTREG_1(RegPOINTTYPE_2_POINTMATRIX_data1_Out),
	.CC_POINTREG_2(RegPOINTTYPE_2_POINTMATRIX_data2_Out),
	.CC_POINTREG_3(RegPOINTTYPE_2_POINTMATRIX_data3_Out),
	.CC_POINTREG_4(RegPOINTTYPE_2_POINTMATRIX_data4_Out),
	.CC_POINTREG_5(RegPOINTTYPE_2_POINTMATRIX_data5_Out),
	.CC_POINTREG_6(RegPOINTTYPE_2_POINTMATRIX_data6_Out),
	.CC_POINTREG_7(RegPOINTTYPE_2_POINTMATRIX_data7_Out)
);
//#COMPARADORES
//PERDI
//CC_PERDICOMPARATOR CC_PERDICOMPARATOR_u0(	
//	.CC_PERDICOMPARATOR_Lose_OutLow(COMP_LOSE),
//	.CC_PERDICOMPARATOR_NN_Inlow(COMP_anidado),

//	.CC_BACKREG_1(RegBACKGTYPE_2_BACKGMATRIX_data1_Out),
//	.CC_BACKREG_3(RegBACKGTYPE_2_BACKGMATRIX_data3_Out),
//	.CC_BACKREG_5(RegBACKGTYPE_2_BACKGMATRIX_data5_Out),
//	.CC_BACKREG_7(RegBACKGTYPE_2_BACKGMATRIX_data7_Out),
	
//	.CC_POINTREG_0(RegPOINTTYPE_2_POINTMATRIX_data0_Out),
//	.CC_POINTREG_1(RegPOINTTYPE_2_POINTMATRIX_data1_Out),
//	.CC_POINTREG_3(RegPOINTTYPE_2_POINTMATRIX_data3_Out),
//	.CC_POINTREG_5(RegPOINTTYPE_2_POINTMATRIX_data5_Out),
//	.CC_POINTREG_7(RegPOINTTYPE_2_POINTMATRIX_data7_Out)

//);
//ANIDE
//CC_ANIDECOMPARATOR CC_ANIDECOMPARATOR_u0(
//	.CC_ANIDECOMPARATOR_WinF_OutLow(COMP_WIN_FROG),	
//	.CC_ANIDECOMPARATOR_Lose_inLow(COMP_LOSE),
//	.CC_ANIDECOMPARATOR_NN_Outlow(COMP_anidado),
	
//	.CC_BACKREG_7(RegBACKGTYPE_2_BACKGMATRIX_data7_Out),
//	.CC_POINTREG_7(RegPOINTTYPE_2_POINTMATRIX_data7_Out)

//);
//GANE
//CC_GANECOMPARATOR CC_GANECOMPARATOR_u0(
//	.CC_GANECOMPARATOR_WinL_OutLow(COMP_WIN_LEVEL),
//	.CC_BACKREG_7(RegBACKGTYPE_2_BACKGMATRIX_data7_Out)
//);
//#MUX's
CC_MUX CC_MUX_r0(
	//////////// OUTPUTS //////////
	.CC_MUX_z_Out(mux_0),
	//////////// INPUTS //////////
	.CC_MUX_select_InBUS(COUNT_LEVEL_OUT),
	.CC_MUX_data_InBUS_0(N1_0),
	.CC_MUX_data_InBUS_1(N2_0),
	.CC_MUX_data_InBUS_2(N3_0),
	.CC_MUX_data_InBUS_3(N4_0),
	.CC_MUX_data_InBUS_4(CN1_0),
	.CC_MUX_data_InBUS_5(CN2_0),
	.CC_MUX_data_InBUS_6(CN3_0),
	.CC_MUX_data_InBUS_7(CN4_0),
	.CC_MUX_data_InBUS_8(P_0),
	.CC_MUX_data_InBUS_9(G_0)
);
CC_MUX CC_MUX_r1(
	//////////// OUTPUTS //////////
	.CC_MUX_z_Out(mux_1),
	//////////// INPUTS //////////
	.CC_MUX_select_InBUS(COUNT_LEVEL_OUT),
	.CC_MUX_data_InBUS_0(N1_1),
	.CC_MUX_data_InBUS_1(N2_1),
	.CC_MUX_data_InBUS_2(N3_1),
	.CC_MUX_data_InBUS_3(N4_1),
	.CC_MUX_data_InBUS_4(CN1_1),
	.CC_MUX_data_InBUS_5(CN2_1),
	.CC_MUX_data_InBUS_6(CN3_1),
	.CC_MUX_data_InBUS_7(CN4_),
	.CC_MUX_data_InBUS_8(P_1),
	.CC_MUX_data_InBUS_9(G_1)
);

CC_MUX CC_MUX_r2(
	//////////// OUTPUTS //////////
	.CC_MUX_z_Out(mux_2),
	//////////// INPUTS //////////
	.CC_MUX_select_InBUS(COUNT_LEVEL_OUT),
	.CC_MUX_data_InBUS_0(N1_2),
	.CC_MUX_data_InBUS_1(N2_2),
	.CC_MUX_data_InBUS_2(N3_2),
	.CC_MUX_data_InBUS_3(N4_2),
	.CC_MUX_data_InBUS_4(CN1_2),
	.CC_MUX_data_InBUS_5(CN2_2),
	.CC_MUX_data_InBUS_6(CN3_2),
	.CC_MUX_data_InBUS_7(CN4_2),
	.CC_MUX_data_InBUS_8(P_2),
	.CC_MUX_data_InBUS_9(G_2)
);
CC_MUX CC_MUX_r3(
	//////////// OUTPUTS //////////
	.CC_MUX_z_Out(mux_3),
	//////////// INPUTS //////////
	.CC_MUX_select_InBUS(COUNT_LEVEL_OUT),
	.CC_MUX_data_InBUS_0(N1_3),
	.CC_MUX_data_InBUS_1(N2_3),
	.CC_MUX_data_InBUS_2(N3_3),
	.CC_MUX_data_InBUS_3(N4_3),
	.CC_MUX_data_InBUS_4(CN1_3),
	.CC_MUX_data_InBUS_5(CN2_3),
	.CC_MUX_data_InBUS_6(CN3_3),
	.CC_MUX_data_InBUS_7(CN4_3),
	.CC_MUX_data_InBUS_8(P_3),
	.CC_MUX_data_InBUS_9(G_3)
);
CC_MUX CC_MUX_r4(
	//////////// OUTPUTS //////////
	.CC_MUX_z_Out(mux_4),
	//////////// INPUTS //////////
	.CC_MUX_select_InBUS(COUNT_LEVEL_OUT),
	.CC_MUX_data_InBUS_0(N1_4),
	.CC_MUX_data_InBUS_1(N2_4),
	.CC_MUX_data_InBUS_2(N3_4),
	.CC_MUX_data_InBUS_3(N4_4),
	.CC_MUX_data_InBUS_4(CN1_4),
	.CC_MUX_data_InBUS_5(CN2_4),
	.CC_MUX_data_InBUS_6(CN3_4),
	.CC_MUX_data_InBUS_7(CN4_4),
	.CC_MUX_data_InBUS_8(P_4),
	.CC_MUX_data_InBUS_9(G_4)
);
CC_MUX CC_MUX_r5(
	//////////// OUTPUTS //////////
	.CC_MUX_z_Out(mux_5),
	//////////// INPUTS //////////
	.CC_MUX_select_InBUS(COUNT_LEVEL_OUT),
	.CC_MUX_data_InBUS_0(N1_5),
	.CC_MUX_data_InBUS_1(N2_5),
	.CC_MUX_data_InBUS_2(N3_5),
	.CC_MUX_data_InBUS_3(N4_5),
	.CC_MUX_data_InBUS_4(CN1_5),
	.CC_MUX_data_InBUS_5(CN2_5),
	.CC_MUX_data_InBUS_6(CN3_5),
	.CC_MUX_data_InBUS_7(CN4_5),
	.CC_MUX_data_InBUS_8(P_5),
	.CC_MUX_data_InBUS_9(G_5)
);
CC_MUX CC_MUX_r6(
	//////////// OUTPUTS //////////
	.CC_MUX_z_Out(mux_6),
	//////////// INPUTS //////////
	.CC_MUX_select_InBUS(COUNT_LEVEL_OUT),
	.CC_MUX_data_InBUS_0(N1_6),
	.CC_MUX_data_InBUS_1(N2_6),
	.CC_MUX_data_InBUS_2(N3_6),
	.CC_MUX_data_InBUS_3(N4_6),
	.CC_MUX_data_InBUS_4(CN1_6),
	.CC_MUX_data_InBUS_5(CN2_6),
	.CC_MUX_data_InBUS_6(CN3_6),
	.CC_MUX_data_InBUS_7(CN4_6),
	.CC_MUX_data_InBUS_8(P_6),
	.CC_MUX_data_InBUS_9(G_6)
);
CC_MUX CC_MUX_r7(
	//////////// OUTPUTS //////////
	.CC_MUX_z_Out(mux_7),
	//////////// INPUTS //////////
	.CC_MUX_select_InBUS(COUNT_LEVEL_OUT),
	.CC_MUX_data_InBUS_0(N1_7),
	.CC_MUX_data_InBUS_1(N2_7),
	.CC_MUX_data_InBUS_2(N3_7),
	.CC_MUX_data_InBUS_3(N4_7),
	.CC_MUX_data_InBUS_4(CN1_7),
	.CC_MUX_data_InBUS_5(CN2_7),
	.CC_MUX_data_InBUS_6(CN3_7),
	.CC_MUX_data_InBUS_7(CN4_7),
	.CC_MUX_data_InBUS_8(P_7),
	.CC_MUX_data_InBUS_9(G_7)
);

//#SPEED
SC_upSPEEDCOUNTER #(.upSPEEDCOUNTER_DATAWIDTH(PRESCALER_DATAWIDTH)) SC_upSPEEDCOUNTER_u0 (
// port map - connection between master ports and signals/registers   
	.SC_upSPEEDCOUNTER_data_OutBUS(upSPEEDCOUNTER_data_BUS_wire),
	.SC_upSPEEDCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_upSPEEDCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_upSPEEDCOUNTER_upcount_InLow(STATEMACHINEBACKG_upcount_cwire)
);

CC_SPEEDCOMPARATOR #(.SPEEDCOMPARATOR_DATAWIDTH(PRESCALER_DATAWIDTH)) CC_SPEEDCOMPARATOR_u0 (
	.CC_SPEEDCOMPARATOR_T0_OutLow(SPEEDCOMPARATOR_2_STATEMACHINEBACKG_T0_cwire),
	.CC_SPEEDCOMPARATOR_data_InBUS(upSPEEDCOUNTER_data_BUS_wire)
);

//######################################################################
//#	COMPARATOR END OF MATRIX (BOTTON SIDE)
//######################################################################
CC_BOTTOMSIDECOMPARATOR #(.BOTTOMSIDECOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_BOTTOMSIDECOMPARATOR_u0 (
	.CC_BOTTOMSIDECOMPARATOR_bottomside_OutLow(BOTTOMSIDECOMPARATOR_2_STATEMACHINEBACKG_bottomside_cwire),
	.CC_BOTTOMSIDECOMPARATOR_data_InBUS(RegPOINTTYPE_2_POINTMATRIX_data0_Out)
);
//######################################################################
//#	COMPARATOR END OF MATRIX (BOTTON SIDE)
//######################################################################




//######################################################################
//#	TO LED MATRIZ: VISUALIZATION
//######################################################################
assign regGAME_data0_wire = RegPOINTTYPE_2_POINTMATRIX_data0_Out | RegBACKGTYPE_2_BACKGMATRIX_data0_Out;
assign regGAME_data1_wire = RegPOINTTYPE_2_POINTMATRIX_data1_Out | RegBACKGTYPE_2_BACKGMATRIX_data1_Out;
assign regGAME_data2_wire = RegPOINTTYPE_2_POINTMATRIX_data2_Out | RegBACKGTYPE_2_BACKGMATRIX_data2_Out;
assign regGAME_data3_wire = RegPOINTTYPE_2_POINTMATRIX_data3_Out | RegBACKGTYPE_2_BACKGMATRIX_data3_Out;
assign regGAME_data4_wire = RegPOINTTYPE_2_POINTMATRIX_data4_Out | RegBACKGTYPE_2_BACKGMATRIX_data4_Out;
assign regGAME_data5_wire = RegPOINTTYPE_2_POINTMATRIX_data5_Out | RegBACKGTYPE_2_BACKGMATRIX_data5_Out;
assign regGAME_data6_wire = RegPOINTTYPE_2_POINTMATRIX_data6_Out | RegBACKGTYPE_2_BACKGMATRIX_data6_Out;
assign regGAME_data7_wire = RegPOINTTYPE_2_POINTMATRIX_data7_Out | RegBACKGTYPE_2_BACKGMATRIX_data7_Out;

assign data_max =(add==3'b000)?{regGAME_data0_wire[7],regGAME_data1_wire[7],regGAME_data2_wire[7],regGAME_data3_wire[7],regGAME_data4_wire[7],regGAME_data5_wire[7],regGAME_data6_wire[7],regGAME_data7_wire[7]}:
	       (add==3'b001)?{regGAME_data0_wire[6],regGAME_data1_wire[6],regGAME_data2_wire[6],regGAME_data3_wire[6],regGAME_data4_wire[6],regGAME_data5_wire[6],regGAME_data6_wire[6],regGAME_data7_wire[6]}:
	       (add==3'b010)?{regGAME_data0_wire[5],regGAME_data1_wire[5],regGAME_data2_wire[5],regGAME_data3_wire[5],regGAME_data4_wire[5],regGAME_data5_wire[5],regGAME_data6_wire[5],regGAME_data7_wire[5]}:
	       (add==3'b011)?{regGAME_data0_wire[4],regGAME_data1_wire[4],regGAME_data2_wire[4],regGAME_data3_wire[4],regGAME_data4_wire[4],regGAME_data5_wire[4],regGAME_data6_wire[4],regGAME_data7_wire[4]}:
	       (add==3'b100)?{regGAME_data0_wire[3],regGAME_data1_wire[3],regGAME_data2_wire[3],regGAME_data3_wire[3],regGAME_data4_wire[3],regGAME_data5_wire[3],regGAME_data6_wire[3],regGAME_data7_wire[3]}:
	       (add==3'b101)?{regGAME_data0_wire[2],regGAME_data1_wire[2],regGAME_data2_wire[2],regGAME_data3_wire[2],regGAME_data4_wire[2],regGAME_data5_wire[2],regGAME_data6_wire[2],regGAME_data7_wire[2]}:
	       (add==3'b110)?{regGAME_data0_wire[1],regGAME_data1_wire[1],regGAME_data2_wire[1],regGAME_data3_wire[1],regGAME_data4_wire[1],regGAME_data5_wire[1],regGAME_data6_wire[1],regGAME_data7_wire[1]}:
						{regGAME_data0_wire[0],regGAME_data1_wire[0],regGAME_data2_wire[0],regGAME_data3_wire[0],regGAME_data4_wire[0],regGAME_data5_wire[0],regGAME_data6_wire[0],regGAME_data7_wire[0]};
									 
matrix_ctrl matrix_ctrl_unit_0( 
.max7219_din(BB_SYSTEM_max7219DIN_Out),//max7219_din 
.max7219_ncs(BB_SYSTEM_max7219NCS_Out),//max7219_ncs 
.max7219_clk(BB_SYSTEM_max7219CLK_Out),//max7219_clk
.disp_data(data_max), 
.disp_addr(add),
.intensity(4'hA),
.clk(BB_SYSTEM_CLOCK_50),
.reset(BB_SYSTEM_RESET_InHigh) //~lowRst_System
 ); 
 
//~ imagen img1(
//~ .act_add(add), 
//~ .max_in(data_max) );

//~ SC_CTRLMATRIX SC_CTRLMATRIX_u0( 
//~ .SC_CTRLMATRIX_max7219DIN_Out(BB_SYSTEM_max7219DIN_Out),	//max7219_din 
//~ .SC_CTRLMATRIX_max7219NCS_out(BB_SYSTEM_max7219NCS_Out),	//max7219_ncs 
//~ .SC_CTRLMATRIX_max7219CLK_Out(BB_SYSTEM_max7219CLK_Out),	//max7219_clk
//~ .SC_CTRLMATRIX_dispdata(data_max), 
//~ .SC_CTRLMATRIX_dispaddr(add),
//~ .SC_CTRLMATRIX_intensity(4'hA),
//~ .SC_CTRLMATRIX_CLOCK_50(BB_SYSTEM_CLOCK_50),
//~ .SC_CTRLMATRIX_RESET_InHigh(~BB_SYSTEM_RESET_InHigh) 		//~lowRst_System
 //~ ); 
 
//~ SC_IMAGE SC_IMAGE_u0(
//~ .SC_IMAGE_actadd(add), 
//~ .SC_IMAGE_maxin(data_max) );

//######################################################################
//#	TO TEST
//######################################################################

assign BB_SYSTEM_state = estado;
assign BB_SYSTEM_point_6 = RegPOINTTYPE_2_POINTMATRIX_data6_Out;
assign BB_SYSTEM_point_7 = RegPOINTTYPE_2_POINTMATRIX_data7_Out;

assign BB_SYSTEM_back_7 = RegBACKGTYPE_2_BACKGMATRIX_data7_Out;


assign	BB_SYSTEM_ST_GAME_signal = GAME_Signal;
assign	BB_SYSTEM_ST_BACK_signal = BACK_Signal;
assign	BB_SYSTEM_ST_POINT_signal = POINT_Signal;


assign BB_SYSTEM_COMP_anidado = COMP_anidado;
assign BB_SYSTEM_COMP_perdi = COMP_LOSE;
assign	BB_SYSTEM_COMP_nivel = COMP_WIN_LEVEL;

assign BB_SYSTEM_COUNT_LEVEL = COUNT_LEVEL_OUT;
assign BB_SYSTEM_LEVEL = mux_7;

//######################################################################
//#	TO 7SEG
//######################################################################

CC_BIN2BCD1 CC_BIN2BCD1_u0 (
// port map - connection between master ports and signals/registers   
	.CC_BIN2BCD_bcd_OutBUS(BIN2BCD1_2_SEVENSEG1_data_BUS_wire),
	.CC_BIN2BCD_bin_InBUS(upCOUNTER_2_BIN2BCD1_data_BUS_wire)
);

CC_SEVENSEG1 CC_SEVENSEG1_u0 (
// port map - connection between master ports and signals/registers   
	.CC_SEVENSEG1_an(BB_SYSTEM_display_OutBUS[11:8]),
	.CC_SEVENSEG1_a(BB_SYSTEM_display_OutBUS[0]),
	.CC_SEVENSEG1_b(BB_SYSTEM_display_OutBUS[1]),
	.CC_SEVENSEG1_c(BB_SYSTEM_display_OutBUS[2]),
	.CC_SEVENSEG1_d(BB_SYSTEM_display_OutBUS[3]),
	.CC_SEVENSEG1_e(BB_SYSTEM_display_OutBUS[4]),
	.CC_SEVENSEG1_f(BB_SYSTEM_display_OutBUS[5]),
	.CC_SEVENSEG1_g(BB_SYSTEM_display_OutBUS[6]),
	.CC_SEVENSEG1_dp(BB_SYSTEM_display_OutBUS[7]),
	.CC_SEVENSEG1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.CC_SEVENSEG1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.CC_SEVENSEG1_in0(BIN2BCD1_2_SEVENSEG1_data_BUS_wire[3:0]),
	.CC_SEVENSEG1_in1(BIN2BCD1_2_SEVENSEG1_data_BUS_wire[7:4]),
	.CC_SEVENSEG1_in2(BIN2BCD1_2_SEVENSEG1_data_BUS_wire[11:8]),
	.CC_SEVENSEG1_in3(BIN2BCD1_2_SEVENSEG1_data_BUS_wire[11:8])
);

SC_upCOUNTER #(.upCOUNTER_DATAWIDTH(DATAWIDTH_BUS)) SC_upCOUNTER_u0 (
// port map - connection between master ports and signals/registers   
	.SC_upCOUNTER_data_OutBUS(upCOUNTER_2_BIN2BCD1_data_BUS_wire),
	.SC_upCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_upCOUNTER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_upCOUNTER_upcount_InLow(STATEMACHINEPOINT_load0_cwire)
);

endmodule
