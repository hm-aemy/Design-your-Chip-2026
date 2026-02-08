module controller(
    input logic clk,
    input logic rst_n,
    input logic button,

    output logic save_A,
    output logic save_B,
    output logic show_result
);

    enum {IDLE, WAIT_B, WAIT_RESULT} state, next_state;

    always_comb begin : control_logic
        save_A = 0;
        save_B = 0;
        show_result = 0;

        next_state = state;

        case (state)
            IDLE: begin
                if (button) begin
                    save_A = 1;
                    next_state = WAIT_B;
                end
            end
            WAIT_B: begin
                if (button) begin
                    save_B = 1;
                    next_state = WAIT_RESULT;
                end
            end
            WAIT_RESULT: begin
                if (button) begin
                    show_result = 1;
                    next_state = IDLE;
                end
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

endmodule