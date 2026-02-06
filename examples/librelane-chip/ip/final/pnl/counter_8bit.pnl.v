module counter_8bit (clk_i,
    rst_ni,
    VPWR,
    VGND,
    count_o);
 input clk_i;
 input rst_ni;
 inout VPWR;
 inout VGND;
 output [7:0] count_o;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire _09_;
 wire _10_;
 wire _11_;
 wire _12_;
 wire _13_;
 wire _14_;
 wire _15_;
 wire _16_;
 wire _17_;
 wire _18_;
 wire _19_;
 wire _20_;
 wire _21_;
 wire _22_;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire clknet_0_clk_i;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net1;
 wire net;
 wire clknet_1_0__leaf_clk_i;
 wire clknet_1_1__leaf_clk_i;
 wire net17;
 wire net18;
 wire net19;
 wire net20;
 wire net21;
 wire net22;
 wire net23;
 wire net24;
 wire net25;
 wire net26;
 wire net27;
 wire net28;
 wire net29;
 wire net30;
 wire net31;
 wire net32;
 wire net33;

 sg13g2_inv_1 _31_ (.VDD(VPWR),
    .Y(_08_),
    .A(net17),
    .VSS(VGND));
 sg13g2_inv_1 _32_ (.VDD(VPWR),
    .Y(_09_),
    .A(net1),
    .VSS(VGND));
 sg13g2_nor2_1 _33_ (.A(net22),
    .B(_09_),
    .Y(_00_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_o21ai_1 _34_ (.B1(net1),
    .VDD(VPWR),
    .Y(_10_),
    .VSS(VGND),
    .A1(net22),
    .A2(net29));
 sg13g2_a21oi_1 _35_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(net22),
    .A2(net29),
    .Y(_01_),
    .B1(_10_));
 sg13g2_a21oi_1 _36_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(net2),
    .A2(net3),
    .Y(_11_),
    .B1(net19));
 sg13g2_nand3_1 _37_ (.B(net3),
    .C(net19),
    .A(net22),
    .Y(_12_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _38_ (.Y(_13_),
    .A(net1),
    .B(_12_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2_1 _39_ (.A(net20),
    .B(_13_),
    .Y(_02_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2b_1 _40_ (.A(net23),
    .B_N(_12_),
    .Y(_14_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_and4_1 _41_ (.A(net22),
    .B(net29),
    .C(net19),
    .D(net23),
    .X(_15_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor3_1 _42_ (.A(_09_),
    .B(net24),
    .C(_15_),
    .Y(_03_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_xor2_1 _43_ (.B(_15_),
    .A(net33),
    .X(_16_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_and2_1 _44_ (.A(net1),
    .B(_16_),
    .X(_04_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_a21oi_1 _45_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(net6),
    .A2(_15_),
    .Y(_17_),
    .B1(net26));
 sg13g2_nand3_1 _46_ (.B(net26),
    .C(_15_),
    .A(net6),
    .Y(_18_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2_1 _47_ (.Y(_19_),
    .A(net1),
    .B(_18_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nor2_1 _48_ (.A(net27),
    .B(_19_),
    .Y(_05_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand2b_1 _49_ (.Y(_20_),
    .B(_18_),
    .A_N(net30),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_nand4_1 _50_ (.B(net26),
    .C(net30),
    .A(net6),
    .Y(_21_),
    .VDD(VPWR),
    .VSS(VGND),
    .D(_15_));
 sg13g2_and3_1 _51_ (.X(_06_),
    .A(net1),
    .B(net31),
    .C(_21_),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_o21ai_1 _52_ (.B1(net1),
    .VDD(VPWR),
    .Y(_22_),
    .VSS(VGND),
    .A1(_08_),
    .A2(_21_));
 sg13g2_a21oi_1 _53_ (.VSS(VGND),
    .VDD(VPWR),
    .A1(_08_),
    .A2(_21_),
    .Y(_07_),
    .B1(_22_));
 sg13g2_dfrbpq_1 _54_ (.RESET_B(net),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_00_),
    .Q(net2),
    .CLK(clknet_1_0__leaf_clk_i));
 sg13g2_dfrbpq_1 _55_ (.RESET_B(net16),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_01_),
    .Q(net3),
    .CLK(clknet_1_0__leaf_clk_i));
 sg13g2_dfrbpq_1 _56_ (.RESET_B(net15),
    .VSS(VGND),
    .VDD(VPWR),
    .D(net21),
    .Q(net4),
    .CLK(clknet_1_0__leaf_clk_i));
 sg13g2_dfrbpq_1 _57_ (.RESET_B(net14),
    .VSS(VGND),
    .VDD(VPWR),
    .D(net25),
    .Q(net5),
    .CLK(clknet_1_0__leaf_clk_i));
 sg13g2_dfrbpq_1 _58_ (.RESET_B(net13),
    .VSS(VGND),
    .VDD(VPWR),
    .D(_04_),
    .Q(net6),
    .CLK(clknet_1_1__leaf_clk_i));
 sg13g2_dfrbpq_1 _59_ (.RESET_B(net12),
    .VSS(VGND),
    .VDD(VPWR),
    .D(net28),
    .Q(net7),
    .CLK(clknet_1_1__leaf_clk_i));
 sg13g2_dfrbpq_1 _60_ (.RESET_B(net11),
    .VSS(VGND),
    .VDD(VPWR),
    .D(net32),
    .Q(net8),
    .CLK(clknet_1_1__leaf_clk_i));
 sg13g2_dfrbpq_1 _61_ (.RESET_B(net10),
    .VSS(VGND),
    .VDD(VPWR),
    .D(net18),
    .Q(net9),
    .CLK(clknet_1_1__leaf_clk_i));
 sg13g2_tiehi _61__11 (.VDD(VPWR),
    .VSS(VGND),
    .L_HI(net10));
 sg13g2_tiehi _60__12 (.VDD(VPWR),
    .VSS(VGND),
    .L_HI(net11));
 sg13g2_tiehi _59__13 (.VDD(VPWR),
    .VSS(VGND),
    .L_HI(net12));
 sg13g2_tiehi _58__14 (.VDD(VPWR),
    .VSS(VGND),
    .L_HI(net13));
 sg13g2_tiehi _57__15 (.VDD(VPWR),
    .VSS(VGND),
    .L_HI(net14));
 sg13g2_tiehi _56__16 (.VDD(VPWR),
    .VSS(VGND),
    .L_HI(net15));
 sg13g2_tiehi _55__17 (.VDD(VPWR),
    .VSS(VGND),
    .L_HI(net16));
 sg13g2_buf_16 clkbuf_0_clk_i (.X(clknet_0_clk_i),
    .A(clk_i),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 input1 (.A(rst_ni),
    .X(net1),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output2 (.A(net2),
    .X(count_o[0]),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output3 (.A(net3),
    .X(count_o[1]),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output4 (.A(net4),
    .X(count_o[2]),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output5 (.A(net5),
    .X(count_o[3]),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output6 (.A(net6),
    .X(count_o[4]),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output7 (.A(net7),
    .X(count_o[5]),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output8 (.A(net8),
    .X(count_o[6]),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_1 output9 (.A(net9),
    .X(count_o[7]),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_tiehi _54__10 (.VDD(VPWR),
    .VSS(VGND),
    .L_HI(net));
 sg13g2_buf_16 clkbuf_1_0__f_clk_i (.X(clknet_1_0__leaf_clk_i),
    .A(clknet_0_clk_i),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_buf_16 clkbuf_1_1__f_clk_i (.X(clknet_1_1__leaf_clk_i),
    .A(clknet_0_clk_i),
    .VDD(VPWR),
    .VSS(VGND));
 sg13g2_dlygate4sd3_1 hold18 (.A(net9),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net17));
 sg13g2_dlygate4sd3_1 hold19 (.A(_07_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net18));
 sg13g2_dlygate4sd3_1 hold20 (.A(net4),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net19));
 sg13g2_dlygate4sd3_1 hold21 (.A(_11_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net20));
 sg13g2_dlygate4sd3_1 hold22 (.A(_02_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net21));
 sg13g2_dlygate4sd3_1 hold23 (.A(net2),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net22));
 sg13g2_dlygate4sd3_1 hold24 (.A(net5),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net23));
 sg13g2_dlygate4sd3_1 hold25 (.A(_14_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net24));
 sg13g2_dlygate4sd3_1 hold26 (.A(_03_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net25));
 sg13g2_dlygate4sd3_1 hold27 (.A(net7),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net26));
 sg13g2_dlygate4sd3_1 hold28 (.A(_17_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net27));
 sg13g2_dlygate4sd3_1 hold29 (.A(_05_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net28));
 sg13g2_dlygate4sd3_1 hold30 (.A(net3),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net29));
 sg13g2_dlygate4sd3_1 hold31 (.A(net8),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net30));
 sg13g2_dlygate4sd3_1 hold32 (.A(_20_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net31));
 sg13g2_dlygate4sd3_1 hold33 (.A(_06_),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net32));
 sg13g2_dlygate4sd3_1 hold34 (.A(net6),
    .VDD(VPWR),
    .VSS(VGND),
    .X(net33));
 sg13g2_decap_4 FILLER_0_4 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_0_73 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_1_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_1_2 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_1_7 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_1_9 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_1_37 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_1_46 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_2_38 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_3_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_3_24 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_4_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_4_2 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_5_8 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_5_37 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_5_39 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_5_47 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_6_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_6_38 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_7_0 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_7_2 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_7_11 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_decap_4 FILLER_8_4 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_8_8 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_8_14 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_8_23 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_8_25 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_8_31 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_1 FILLER_8_33 (.VDD(VPWR),
    .VSS(VGND));
 sg13g2_fill_2 FILLER_8_73 (.VDD(VPWR),
    .VSS(VGND));
endmodule
