`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 
// Design Name: 
// Module Name: axis_sm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Enhanced state machine with configurable start, stop, and step values
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axis_sm(
    input clk,
    input rstn,
    input start_en,                 // Start enable signal
    input [31:0] phase_start_value, // Starting value for phase
    input [31:0] phase_stop_value,  // Stopping value for phase
    input [31:0] phase_step_value,  // Step value for phase increments
    output reg s_axis_phase_tvalid,
    input s_axis_phase_tready,
    output reg [63:0] s_axis_phase_tdata,
    output reg m_axis_phase_tready,
    output reg m_axis_data_tready,
    output reg [4:0] state_reg
    );
    
    reg [31:0] freq_phase_incr, period_wait_cnt;
    reg sweep_complete;
    
    wire [31:0] freq_period;
    assign freq_period = 32'd100;
    
    parameter init               = 5'd0;
    parameter Start              = 5'd1;
    parameter SetTvalidHigh      = 5'd2;
    parameter SetSlavePhaseValue = 5'd3;
    parameter CheckTready        = 5'd4;
    parameter WaitState          = 5'd5;
    parameter CheckLoopCntr      = 5'd6;
    parameter CheckSweepComplete = 5'd7;
    
    always @ (posedge clk)
        begin                    
            // Default Outputs  
            
            if (!rstn)
                begin
                    m_axis_phase_tready <= 1'b0;
                    s_axis_phase_tdata  <= {64{1'b0}};
                    m_axis_data_tready  <= 1'b0;
                    state_reg <= init;
                    sweep_complete <= 1'b0;
                end
            else
                begin
                    case(state_reg)
                        init : //0
                            begin
                                freq_phase_incr <= 32'd0;
                                s_axis_phase_tvalid <= 1'b0;
                                period_wait_cnt <= 32'd0;
                                sweep_complete <= 1'b0;
                                
                                if (start_en)
                                    begin
                                        freq_phase_incr <= phase_start_value;  // Initialize with start value
                                        state_reg <= Start;
                                    end
                                else
                                    state_reg <= init;
                            end
                            
                        Start : //1
                            begin
                                m_axis_phase_tready <= 1'b1;
                                m_axis_data_tready <= 1'b1;
                                state_reg <= SetTvalidHigh;
                            end
                            
                        SetTvalidHigh : //2
                            begin
                                s_axis_phase_tvalid <= 1'b1; //per PG141 - tvalid is set before tready goes high
                                state_reg <= SetSlavePhaseValue;
                            end
                            
                        SetSlavePhaseValue : //3
                            begin
                                begin
                                    s_axis_phase_tdata[63:32] <= 32'h0000_0000;
                                    s_axis_phase_tdata[31:0] <= freq_phase_incr;
                                    state_reg <= CheckTready;
                                end
                            end
                            
                        CheckTready : //4
                            begin
                                if (s_axis_phase_tready == 1'b1)
                                    begin
                                        state_reg <= WaitState;
                                    end
                                else    
                                    begin
                                        state_reg <= CheckTready;
                                    end
                            end
                            
                        WaitState : //5
                            begin
                                if (period_wait_cnt >= freq_period)
                                    begin
                                        period_wait_cnt <= 32'd0; 
                                        state_reg <= CheckSweepComplete;
                                    end
                                else
                                    begin
                                        period_wait_cnt <= period_wait_cnt + 1;
                                        state_reg <= WaitState;
                                    end
                            end
                        
                        CheckSweepComplete : //7
                            begin
                                // Check if we've reached or exceeded the stop value
                                if (freq_phase_incr >= phase_stop_value)
                                    begin
                                        sweep_complete <= 1'b1;
                                        state_reg <= CheckLoopCntr;
                                    end
                                else
                                    begin
                                        // Increment by step value
                                        freq_phase_incr <= freq_phase_incr + phase_step_value;
                                        state_reg <= CheckLoopCntr;
                                    end
                            end
                            
                        CheckLoopCntr : //6
                            begin
                                if( sweep_complete)
                                    begin
                                        freq_phase_incr <= phase_start_value;  // Reset to start value
                                        sweep_complete <= 1'b0;
                                        
                                        if (start_en)
                                            state_reg <= Start;
                                        else
                                            state_reg <= init;
                                    end
                                else
                                    begin
                                        state_reg <= Start;
                                    end
                            end
                            
                    endcase 
                end
        end
endmodule