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
///Q=======================================================
//  MODULE Definition
//=======================================================
module CC_MUX (
//////////// OUTPUTS //////////
	CC_MUX_z_Out,
	//////////// INPUTS //////////
	CC_MUX_select_InBUS,
	CC_MUX_data_InBUS_0,
	CC_MUX_data_InBUS_1,
	CC_MUX_data_InBUS_2,
	CC_MUX_data_InBUS_3,
	CC_MUX_data_InBUS_4,
	CC_MUX_data_InBUS_5,
	CC_MUX_data_InBUS_6,
	CC_MUX_data_InBUS_7,
	CC_MUX_data_InBUS_8,
	CC_MUX_data_InBUS_9
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output   reg [7:0] CC_MUX_z_Out;
input 	[3:0] CC_MUX_select_InBUS;
input 	[7:0] CC_MUX_data_InBUS_0;
input 	[7:0] CC_MUX_data_InBUS_1;
input 	[7:0] CC_MUX_data_InBUS_2;
input 	[7:0] CC_MUX_data_InBUS_3;
input 	[7:0] CC_MUX_data_InBUS_4;
input 	[7:0] CC_MUX_data_InBUS_5;
input 	[7:0] CC_MUX_data_InBUS_6;
input 	[7:0] CC_MUX_data_InBUS_7;
input 	[7:0] CC_MUX_data_InBUS_8;
input 	[7:0] CC_MUX_data_InBUS_9;
//=======================================================Q/
///A=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
always @(*)
begin
   if (CC_MUX_select_InBUS == 4'b0000)
		CC_MUX_z_Out = CC_MUX_data_InBUS_0;
	else if (CC_MUX_select_InBUS == 4'b0001)
		CC_MUX_z_Out = CC_MUX_data_InBUS_1;
	else if (CC_MUX_select_InBUS == 4'b0010)
		CC_MUX_z_Out = CC_MUX_data_InBUS_2;
	else if (CC_MUX_select_InBUS == 4'b0011)
		CC_MUX_z_Out = CC_MUX_data_InBUS_3;
	else if (CC_MUX_select_InBUS == 4'b0100)
		CC_MUX_z_Out = CC_MUX_data_InBUS_4;
	else if (CC_MUX_select_InBUS == 4'b0101)
		CC_MUX_z_Out = CC_MUX_data_InBUS_5;
	else if (CC_MUX_select_InBUS == 4'b0110)
		CC_MUX_z_Out = CC_MUX_data_InBUS_6;
	else if (CC_MUX_select_InBUS == 4'b0111)
		CC_MUX_z_Out = CC_MUX_data_InBUS_7;
	else if (CC_MUX_select_InBUS == 4'b1000)
		CC_MUX_z_Out = CC_MUX_data_InBUS_8;
	else if (CC_MUX_select_InBUS == 4'b1001)
		CC_MUX_z_Out = CC_MUX_data_InBUS_9;
	else
		CC_MUX_z_Out = CC_MUX_data_InBUS_0;
	
	$display ("XD = %b", CC_MUX_data_InBUS_0);
		
end
//assign CC_MUX_z_Out = ( CC_MUX_select_InBUS == 0 ) ? CC_MUX_data_InBUS_0 : ( CC_MUX_select_InBUS == 1 )? CC_MUX_data_InBUS_1 : ( CC_MUX_select_InBUS == 2 )? CC_MUX_data_InBUS_2 : ( CC_MUX_select_InBUS == 3 )? CC_MUX_data_InBUS_3 : ( CC_MUX_select_InBUS == 4 )? CC_MUX_data_InBUS_4 : ( CC_MUX_select_InBUS == 5 )? CC_MUX_data_InBUS_5 : ( CC_MUX_select_InBUS == 6 )? CC_MUX_data_InBUS_6 : ( CC_MUX_select_InBUS == 7 )? CC_MUX_data_InBUS_7 : ( CC_MUX_select_InBUS == 8 )? CC_MUX_data_InBUS_8 : CC_MUX_data_InBUS_9;

endmodule
//=======================================================A/

