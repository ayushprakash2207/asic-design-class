/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module opt_check4(a, b, c, y);
  wire _0_;
  wire _1_;
  wire _2_;
  input a;
  wire a;
  input b;
  wire b;
  input c;
  wire c;
  output y;
  wire y;
  sky130_fd_sc_hd__xnor2_1 _3_ (
    .A(_0_),
    .B(_1_),
    .Y(_2_)
  );
  assign _0_ = a;
  assign _1_ = c;
  assign y = _2_;
endmodule
