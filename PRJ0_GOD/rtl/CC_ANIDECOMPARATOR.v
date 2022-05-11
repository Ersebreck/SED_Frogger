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
module CC_ANIDECOMPARATOR (
//////////// OUTPUTS //////////
	CC_ANIDECOMPARATOR_WinF_OutLow,
	CC_ANIDECOMPARATOR_Lose_inLow,
	CC_ANIDECOMPARATOR_NN_Outlow,
//////////// INPUTS //////////

	CC_BACKREG_7,
	CC_POINTREG_7
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output	reg [7:0] CC_ANIDECOMPARATOR_WinF_OutLow;
input		CC_ANIDECOMPARATOR_Lose_inLow;
output	reg [7:0] CC_ANIDECOMPARATOR_NN_Outlow;

input 	[7:0] CC_BACKREG_7;
input 	[7:0] CC_POINTREG_7;
//=======================================================
//  REG/WIRE declarations
//=======================================================
//=======================================================
//  Structural coding
//=======================================================
always @(*)
begin
		
	// anidé (llegue al 7 y no perdi)
	
	if (|CC_POINTREG_7 && CC_ANIDECOMPARATOR_Lose_inLow==1'b0)
		CC_ANIDECOMPARATOR_NN_Outlow = 1'b1;
		
	else
		CC_ANIDECOMPARATOR_NN_Outlow = 1'b0; 
	
	// llevar nuevo valor del registro 7
	
	if (((CC_ANIDECOMPARATOR_NN_Outlow == 1'b1) && (|CC_POINTREG_7))) // nivel anidado
		CC_ANIDECOMPARATOR_WinF_OutLow = (CC_BACKREG_7 | CC_POINTREG_7); 
		
		
//	$display ("gane? = %b", CC_ANIDECOMPARATOR_WinL_OutLow);
		
	end
	

endmodule
