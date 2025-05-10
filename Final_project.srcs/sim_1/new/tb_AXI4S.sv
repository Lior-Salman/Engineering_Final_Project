`timescale 1ns / 1ps


module tb_AXI4S(

    );

//////////////////////////////////////////////////////////////////////////////////
// Test Bench Signals
//////////////////////////////////////////////////////////////////////////////////
// Clock and Reset
bit clk_i = 0, rstn = 0;


logic  [15:0]   m_axis_data_tdata;
// logic           m_axis_data_tready;
logic           m_axis_data_tvalid;


logic  [31:0]   m_axis_phase_tdata;
// logic           m_axis_phase_tready;
logic           m_axis_phase_tvalid;

// Generate the clock : 100 MHz    
always #5ns clk_i = ~clk_i;



// Instantiation of the Unit Under Test (UUT)
design_1_wrapper UUT
(
    .clk_i                	(clk_i),
    .rstn               (rstn),

    .m_axis_data_tdata     	(m_axis_data_tdata),
    // .m_axis_data_tready     (m_axis_data_tready),
    .m_axis_data_tvalid    	(m_axis_data_tvalid),

    .m_axis_phase_tdata     (m_axis_phase_tdata),
    // .m_axis_phase_tready    (m_axis_phase_tready),
    .m_axis_phase_tvalid    (m_axis_phase_tvalid)


);

//////////////////////////////////////////////////////////////////////////////////
// Main Process. Wait to the first frame to be written and stop the simulation
// The simulation succeed if the size of the output frame is the same as configured
// in the TPG
//////////////////////////////////////////////////////////////////////////////////
//
initial begin
    #50ns
    // Release the reset
    rstn = 1;



end


endmodule
