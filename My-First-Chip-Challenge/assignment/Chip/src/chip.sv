module chip(
    input clk,
    input rst_n,
    input button,

    input [3:0] X,

    output [6:0] seg0,
    output [6:0] seg1
);

    controller u_ctrl(
        .clk(clk),
        .rst_n(rst_n),
        .button(button)
    );

    

endmodule