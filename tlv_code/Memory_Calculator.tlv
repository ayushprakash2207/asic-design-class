\m5_TLV_version 1d: tl-x.org
\m5
   
   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc
      @0
         $reset = *reset;
      @1
         $valid = $reset ? 0 : >>1$valid+1;
         $valid_or_reset = $valid || $reset; 
   
      ?$valid_or_reset
         @1   
            $val1[31:0] = >>2$out[31:0];
            $val2[31:0] = $rand2[3:0];
            $sel[2:0] = $rand3[2:0];
            
            $sum[31:0] = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];  
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
            
         
         @2
            $mem[31:0] = $reset ? '0 : ($sel == 3'd5) ? >>2$out[31:0]
                                                      : >>2$mem[31:0];
            $recall[31:0] = >>2$mem[31:0];
            
            $out[31:0] = $reset ? '0 : ($sel == 3'd0) ? $sum[31:0]
                                     : ($sel == 3'd1) ? $diff[31:0]
                                     : ($sel == 3'd2) ? $prod[31:0]
                                     : ($sel == 3'd3) ? $quot[31:0]
                                     : ($sel == 3'd4) ? $recall[31:0]
                                     : '0;
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
