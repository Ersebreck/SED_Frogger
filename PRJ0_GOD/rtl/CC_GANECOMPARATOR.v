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
module CC_GANECOMPARATOR (
//////////// OUTPUTS //////////
	CC_GANECOMPARATOR_WinL_OutLow,
//////////// INPUTS //////////
	CC_BACKREG_7,
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output	reg CC_GANECOMPARATOR_WinL_OutLow;
input 	[7:0] CC_BACKREG_7;
//=======================================================
//  REG/WIRE declarations
//=======================================================
//=======================================================
//  Structural coding
//=======================================================
always @(*)
begin	
	// gane nivel
		
	if (CC_BACKREG_7 == 8'b11111111)
		CC_GANECOMPARATOR_WinL_OutLow = 1'b1;
	else
		CC_GANECOMPARATOR_WinL_OutLow = 1'b0;
		
//	$display ("gane? = %b", CC_GANECOMPARATOR_WinL_OutLow);
		
	end
	

endmodule
