//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Sun May 18 20:49:03 2025
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
    phase_start_value,
    phase_step_value,
    phase_stop_value,
    rstn,
    start_en);
  input clk_i;
  output [31:0]m_axis_data_tdata;
  output m_axis_data_tvalid;
  output [31:0]m_axis_phase_tdata;
  output m_axis_phase_tvalid;
  input [31:0]phase_start_value;
  input [31:0]phase_step_value;
  input [31:0]phase_stop_value;
  input rstn;
  input start_en;

  wire clk_i;
  wire [31:0]m_axis_data_tdata;
  wire m_axis_data_tvalid;
  wire [31:0]m_axis_phase_tdata;
  wire m_axis_phase_tvalid;
  wire [31:0]phase_start_value;
  wire [31:0]phase_step_value;
  wire [31:0]phase_stop_value;
  wire rstn;
  wire start_en;

  design_1 design_1_i
       (.clk_i(clk_i),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_phase_tdata(m_axis_phase_tdata),
        .m_axis_phase_tvalid(m_axis_phase_tvalid),
        .phase_start_value(phase_start_value),
        .phase_step_value(phase_step_value),
        .phase_stop_value(phase_stop_value),
        .rstn(rstn),
        .start_en(start_en));
endmodule
