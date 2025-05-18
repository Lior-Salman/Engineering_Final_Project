`timescale 1ns / 1ps


module tb_AXI4S(

    );

//////////////////////////////////////////////////////////////////////////////////
// Test Bench Signals
//////////////////////////////////////////////////////////////////////////////////
// Clock and Reset
bit clk_i = 0, rstn = 0;


logic  [31:0]   m_axis_data_tdata;
// logic           m_axis_data_tready;
logic           m_axis_data_tvalid;

logic  [15:0]   m_axis_SIN;
logic  [15:0]   m_axis_COS;


logic  [31:0]   m_axis_phase_tdata;
// logic           m_axis_phase_tready;
logic           m_axis_phase_tvalid;




logic    start_en;                 // Start enable signal
logic    [31:0] phase_start_value; // Starting value for phase
logic    [31:0] phase_stop_value;  // Stopping value for phase
logic    [31:0] phase_step_value; 

// Generate the clock : 100 MHz    
always #5ns clk_i = ~clk_i;



// Instantiation of the Unit Under Test (UUT)
design_1_wrapper UUT
(
    .clk_i                	(clk_i),
    .rstn               (rstn),

    .start_en           (start_en),
    .phase_start_value  (phase_start_value),
    .phase_stop_value   (phase_stop_value),
    .phase_step_value   (phase_step_value),

    .m_axis_data_tdata     	({m_axis_SIN,m_axis_COS}),
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

        start_en            = 1;
        phase_start_value   = 32'h28F;
        phase_stop_value    = 32'h51E;
        phase_step_value    = 32'h1A;

    #500ns
        // Release the reset
        rstn                = 1;
        start_en            = 1;



end


endmodule
