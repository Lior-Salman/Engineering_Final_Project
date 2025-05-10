//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Sat May 10 19:41:23 2025
//Host        : Lior-PC running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk_i,
    m_axis_data_tdata,
    m_axis_data_tvalid,
    m_axis_phase_tdata,
    m_axis_phase_tvalid,
    rstn);
  input clk_i;
  output [7:0]m_axis_data_tdata;
  output m_axis_data_tvalid;
  output [31:0]m_axis_phase_tdata;
  output m_axis_phase_tvalid;
  input rstn;

  wire clk_i;
  wire [7:0]m_axis_data_tdata;
  wire m_axis_data_tvalid;
  wire [31:0]m_axis_phase_tdata;
  wire m_axis_phase_tvalid;
  wire rstn;

  design_1 design_1_i
       (.clk_i(clk_i),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_phase_tdata(m_axis_phase_tdata),
        .m_axis_phase_tvalid(m_axis_phase_tvalid),
        .rstn(rstn));
endmodule
