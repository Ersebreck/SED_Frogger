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
module CC_PERDICOMPARATOR (
//////////// OUTPUTS //////////
	CC_PERDICOMPARATOR_Lose_OutLow,
//////////// INPUTS //////////
	CC_BACKREG_1,
	CC_BACKREG_3,
	CC_BACKREG_5,
	CC_BACKREG_7,
	
	CC_POINTREG_0,
	CC_POINTREG_1,
	CC_POINTREG_3,
	CC_POINTREG_5,
	CC_POINTREG_7,
	CC_PERDICOMPARATOR_NN_Inlow,
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output	reg CC_PERDICOMPARATOR_Lose_OutLow;
input	  	CC_PERDICOMPARATOR_NN_Inlow;

input 	[7:0] CC_BACKREG_1;
input 	[7:0] CC_BACKREG_3;
input 	[7:0] CC_BACKREG_5;
input 	[7:0] CC_BACKREG_7;


input 	[7:0] CC_POINTREG_0;
input 	[7:0] CC_POINTREG_1;
input 	[7:0] CC_POINTREG_3;
input 	[7:0] CC_POINTREG_5;
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
	
	if (|(CC_BACKREG_1 & CC_POINTREG_1 | CC_BACKREG_3 & CC_POINTREG_3 | CC_BACKREG_5 & CC_POINTREG_5 | CC_BACKREG_7 & CC_POINTREG_7) && CC_PERDICOMPARATOR_NN_Inlow == 1'b0)
		CC_PERDICOMPARATOR_Lose_OutLow = 1'b1;
	
	// no he perdido
	
	else
		CC_PERDICOMPARATOR_Lose_OutLow = 1'b0;
		
	end
	

endmodule
