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
module CC_REGISTERCOMPARATOR (
//////////// OUTPUTS //////////
	CC_REGISTERCOMPARATOR_WinF_OutLow,
	CC_REGISTERCOMPARATOR_WinL_OutLow,
	CC_REGISTERCOMPARATOR_Lose_OutLow,
	CC_REGISTERCOMPARATOR_NN_Outlow,
//////////// INPUTS //////////
	CC_BACKREG_0,
	CC_BACKREG_1,
	CC_BACKREG_2,
	CC_BACKREG_3,
	CC_BACKREG_4,
	CC_BACKREG_5,
	CC_BACKREG_6,
	CC_BACKREG_7,
	
	CC_POINTREG_0,
	CC_POINTREG_1,
	CC_POINTREG_2,
	CC_POINTREG_3,
	CC_POINTREG_4,
	CC_POINTREG_5,
	CC_POINTREG_6,
	CC_POINTREG_7
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output	reg [7:0] CC_REGISTERCOMPARATOR_WinF_OutLow;
output	reg CC_REGISTERCOMPARATOR_WinL_OutLow;
output	reg CC_REGISTERCOMPARATOR_Lose_OutLow;
output	reg [7:0] CC_REGISTERCOMPARATOR_NN_Outlow;

input 	[7:0] CC_BACKREG_0;
input 	[7:0] CC_BACKREG_1;
input 	[7:0] CC_BACKREG_2;
input 	[7:0] CC_BACKREG_3;
input 	[7:0] CC_BACKREG_4;
input 	[7:0] CC_BACKREG_5;
input 	[7:0] CC_BACKREG_6;
input 	[7:0] CC_BACKREG_7;


input 	[7:0] CC_POINTREG_0;
input 	[7:0] CC_POINTREG_1;
input 	[7:0] CC_POINTREG_2;
input 	[7:0] CC_POINTREG_3;
input 	[7:0] CC_POINTREG_4;
input 	[7:0] CC_POINTREG_5;
input 	[7:0] CC_POINTREG_6;
input 	[7:0] CC_POINTREG_7;
//=======================================================
//  REG/WIRE declarations
//=======================================================
//=======================================================
//  Structural coding
//=======================================================
always @(*)
begin
	
	// perdí
	
	if (|(CC_BACKREG_1 & CC_POINTREG_1 | CC_BACKREG_3 & CC_POINTREG_3 | CC_BACKREG_5 & CC_POINTREG_5 | CC_BACKREG_7 & CC_POINTREG_7) && CC_REGISTERCOMPARATOR_NN_Outlow == 1'b0)
		CC_REGISTERCOMPARATOR_Lose_OutLow = 1'b1;
	
	// no he perdido
	
	else
		CC_REGISTERCOMPARATOR_Lose_OutLow = 1'b0;
		
	// anidé
	
	if (|CC_POINTREG_7 && CC_REGISTERCOMPARATOR_Lose_OutLow == 1'b0)
		CC_REGISTERCOMPARATOR_NN_Outlow = 1'b1;
	
	if (((CC_REGISTERCOMPARATOR_NN_Outlow == 1'b1) && (|CC_POINTREG_7))) // nivel anidado
		CC_REGISTERCOMPARATOR_WinF_OutLow = (CC_BACKREG_7 | CC_POINTREG_7);
		
	// se reinicio luego de anidar
	
	else if ((|CC_POINTREG_0)) // AQUI VA 0, 6 POR SIMULACION
		CC_REGISTERCOMPARATOR_NN_Outlow = 1'b0; 
	
	// gane nivel
		
	if (CC_BACKREG_7 == 8'b11111111 && CC_REGISTERCOMPARATOR_Lose_OutLow == 1'b0)
		CC_REGISTERCOMPARATOR_WinL_OutLow = 1'b1;
	else if (CC_BACKREG_7 !== 8'b11111111)
		CC_REGISTERCOMPARATOR_WinL_OutLow = 1'b0;
		
		
//	$display ("perdi? = %b", CC_REGISTERCOMPARATOR_Lose_OutLow);
//	$display ("anide? = %b", CC_REGISTERCOMPARATOR_NN_Outlow);
//	$display ("gane? = %b", CC_REGISTERCOMPARATOR_WinL_OutLow);
		
	end
	

endmodule
