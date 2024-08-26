\m4_TLV_version 1d: tl-x.org
\SV
   `include "sqrt32.v";
   m4_makerchip_module
\TLV
   
   |calc
      
      // Pythagora's Theorem
      @1
         $aa_sq[7:0] = $aa[3:0] ** 2;
         $bb_sq[7:0] = $bb[3:0] ** 2;
      // [+] @2
         $cc_sq[8:0] = $aa_sq + $bb_sq;
      // [+] @3
         $cc[4:0] = sqrt($cc_sq);


      // Print
         \SV_plus
            always_ff @(posedge clk) begin
               \$display("sqrt((\%2d ^ 2) + (\%2d ^ 2)) = \%2d", $aa, $bb, $cc);
            end

   // Stop simulation.
   *passed = *cyc_cnt > 40;
\SV
endmodule
