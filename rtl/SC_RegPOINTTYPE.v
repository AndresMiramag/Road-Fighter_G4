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
module SC_RegPOINTTYPE #(parameter RegPOINTTYPE_DATAWIDTH=8, parameter DATA_FIXED_INITREGPOINT=8'b00000000, parameter DATA_FIXED_INITREGPOINT_1=8'b00000000)(
	//////////// OUTPUTS //////////
	SC_RegPOINTTYPE_data_OutBUS,
	
	//////////// INPUTS //////////
	SC_RegPOINTTYPE_CLOCK_50,
	SC_RegPOINTTYPE_RESET_InHigh,
	SC_RegPOINTTYPE_clear_InLow, 
	SC_RegPOINTTYPE_load0_InLow, 
	SC_RegPOINTTYPE_load1_InLow, 
	SC_RegPOINTTYPE_shiftselection_In,
	SC_RegPOINTTYPE_clear_InLow_2, 
	SC_RegPOINTTYPE_load0_InLow_2, 
	SC_RegPOINTTYPE_load1_InLow_2, 
	SC_RegPOINTTYPE_shiftselection_In_2,
	SC_RegPOINTTYPE_data0_InBUS,
	SC_RegPOINTTYPE_data1_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output		[RegPOINTTYPE_DATAWIDTH-1:0]	SC_RegPOINTTYPE_data_OutBUS;
input		SC_RegPOINTTYPE_CLOCK_50;
input		SC_RegPOINTTYPE_RESET_InHigh;
input		SC_RegPOINTTYPE_clear_InLow;
input		SC_RegPOINTTYPE_load0_InLow;	
input		SC_RegPOINTTYPE_load1_InLow;
input		SC_RegPOINTTYPE_clear_InLow_2;
input		SC_RegPOINTTYPE_load0_InLow_2;	
input		SC_RegPOINTTYPE_load1_InLow_2;	
input		[1:0] SC_RegPOINTTYPE_shiftselection_In;
input		[1:0] SC_RegPOINTTYPE_shiftselection_In_2;
input		[RegPOINTTYPE_DATAWIDTH-1:0]	SC_RegPOINTTYPE_data0_InBUS;
input		[RegPOINTTYPE_DATAWIDTH-1:0]	SC_RegPOINTTYPE_data1_InBUS;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [RegPOINTTYPE_DATAWIDTH-1:0] RegPOINTTYPE_Register;
reg [RegPOINTTYPE_DATAWIDTH-1:0] RegPOINTTYPE_Signal;
reg [RegPOINTTYPE_DATAWIDTH-1:0] RegPOINTTYPE_Register_2;
reg [RegPOINTTYPE_DATAWIDTH-1:0] RegPOINTTYPE_Signal_2;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	if (SC_RegPOINTTYPE_clear_InLow == 1'b0)
		RegPOINTTYPE_Signal = DATA_FIXED_INITREGPOINT;
	else if (SC_RegPOINTTYPE_load0_InLow == 1'b0)
		RegPOINTTYPE_Signal = SC_RegPOINTTYPE_data0_InBUS;
	else if (SC_RegPOINTTYPE_load1_InLow == 1'b0)
		RegPOINTTYPE_Signal = SC_RegPOINTTYPE_data1_InBUS;
	else if (SC_RegPOINTTYPE_shiftselection_In == 2'b01 && RegPOINTTYPE_Register!= 8'b10000000)
		RegPOINTTYPE_Signal = {RegPOINTTYPE_Register[RegPOINTTYPE_DATAWIDTH-2:0],RegPOINTTYPE_Register[RegPOINTTYPE_DATAWIDTH-1]};
	else if (SC_RegPOINTTYPE_shiftselection_In == 2'b10 && RegPOINTTYPE_Register!= 8'b00010000)
		RegPOINTTYPE_Signal = {RegPOINTTYPE_Register[0],RegPOINTTYPE_Register[RegPOINTTYPE_DATAWIDTH-1:1]};
	else
		RegPOINTTYPE_Signal = RegPOINTTYPE_Register;
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge SC_RegPOINTTYPE_CLOCK_50, posedge SC_RegPOINTTYPE_RESET_InHigh)
begin
	if (SC_RegPOINTTYPE_RESET_InHigh == 1'b1)
		RegPOINTTYPE_Register <= 0;
	else
		RegPOINTTYPE_Register <= RegPOINTTYPE_Signal;
end
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	if (SC_RegPOINTTYPE_clear_InLow_2 == 1'b0)
		RegPOINTTYPE_Signal_2 = DATA_FIXED_INITREGPOINT_1;
	else if (SC_RegPOINTTYPE_load0_InLow_2 == 1'b0)
		RegPOINTTYPE_Signal_2 = SC_RegPOINTTYPE_data0_InBUS;
	else if (SC_RegPOINTTYPE_load1_InLow_2 == 1'b0)
		RegPOINTTYPE_Signal_2 = SC_RegPOINTTYPE_data1_InBUS;
	else if (SC_RegPOINTTYPE_shiftselection_In_2 == 2'b01 && RegPOINTTYPE_Register_2 != 8'b00001000)
		RegPOINTTYPE_Signal_2 = {RegPOINTTYPE_Register_2[RegPOINTTYPE_DATAWIDTH-2:0],RegPOINTTYPE_Register_2[RegPOINTTYPE_DATAWIDTH-1]};
	else if (SC_RegPOINTTYPE_shiftselection_In_2 == 2'b10 && RegPOINTTYPE_Register_2 != 8'b00000001)
		RegPOINTTYPE_Signal_2 = {RegPOINTTYPE_Register_2[0],RegPOINTTYPE_Register_2[RegPOINTTYPE_DATAWIDTH-1:1]};
	else
		RegPOINTTYPE_Signal_2 = RegPOINTTYPE_Register_2;
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge SC_RegPOINTTYPE_CLOCK_50, posedge SC_RegPOINTTYPE_RESET_InHigh)
begin
	if (SC_RegPOINTTYPE_RESET_InHigh == 1'b1)
		RegPOINTTYPE_Register_2 <= 0;
	else
		RegPOINTTYPE_Register_2 <= RegPOINTTYPE_Signal_2;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign SC_RegPOINTTYPE_data_OutBUS = RegPOINTTYPE_Register|RegPOINTTYPE_Register_2;

endmodule
