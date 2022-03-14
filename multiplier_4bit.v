/**************************************

Name:-Chaitanya Chhichhia (19BEC018)
		Digvijaysinh Chudasama (19BEC029)
		
***************************************/

module multiplier_4bit(a,b,pro);
   input[3:0]a;    // 4-bit multiplicand.
   input[3:0]b;    // 4-bit multiplier.
	output[7:0]pro; // final 8-bit result of  proroduct.

   wire [3:0] 	aug0; // augend of intermediate stage 0 addition
   wire [3:0] 	add0; // addend of intermediate stage 0 addition
   wire [3:0] 	sum0; // result of intermediate stage 0 addition
	wire [3:0] 	aug1; // addend of intermediate stage 1 addition
   wire 	carry0;     // output carry of intermediate stage 0 addition
   wire [3:0] 	add1; // augend of intermediate stage 1 addition
   wire [3:0] 	sum1; //result of intermediate stage 1 addition
   wire 	carry1;     // output carry of intermediate stage 1 addition
   wire [3:0] 	aug2; // augend of intermediate stage 2 addition
   wire [3:0] 	add2; // addend of intermediate stage 2 addition
   
   // multiplication of 1st bit of mulplier to each bit of multiplicand
	//which becomes the augend for intermediate stage 0 adder (s0)
   
   and(pro[0], a[0], b[0]);    //first bit of multiplication is directly the LSB of pro.
   and(aug0[0], a[1], b[0]);   //storing the product of multiplication of
	                            // a[1] and b[0] in aug[1] as we need a right shift in additon
   and(aug0[1], a[2], b[0]);
   and(aug0[2], a[3], b[0]);
   assign aug0[3] = 0;

   //  multiplication of 2nd bit of mulplier to each bit of multiplicand
   //  which becomes the addend of intermediate stage 0 adder (s0)
   and(add0[0], a[0], b[1]);
   and(add0[1], a[1], b[1]);
   and(add0[2], a[2], b[1]);
   and(add0[3], a[3], b[1]);

   adder_4bit s0(aug0, add0,0,sum0, carry0); //intermediate stage 0 addition
   assign pro[1] = sum0[0];                  //the first bit of stage 0 addition becomes the 2nd bit of pro.
   
   //  output of stage 0 addition becomes the augend for stage 1 addition after a right shift
   //
   assign aug1[0] = sum0[1];
   assign aug1[1] = sum0[2];
   assign aug1[2] = sum0[3];
   assign aug1[3] = carry0;
   
   //  multiplication of 3rd bit of mulplier to each bit of multiplicand
   //  which becomes the addend for intermediate stage 1 adder (s1)
	
   and(add1[0], a[0], b[2]);
   and(add1[1], a[1], b[2]);
   and(add1[2], a[2], b[2]);
   and(add1[3], a[3], b[2]);

   adder_4bit s1(aug1, add1,0, sum1, carry1); //intermediate stage 1 addition
   assign pro[2] = sum1[0];                   //the first bit of stage 1 addition becomes the 3rd bit of pro.
   
   
   // output of stage 1 addition becomes the augend for final stage 2 (s2) addition after a right shift
   
   assign aug2[0] = sum1[1];
   assign aug2[1] = sum1[2];
   assign aug2[2] = sum1[3];
   assign aug2[3] = carry1;
   
   //
   // multiplication of 4th bit of mulplier to each bit of multiplicand
   //  which becomes the addend for final stage 2 adder (s2)
   //
   and(add2[0], a[0], b[3]);
   and(add2[1], a[1], b[3]);
   and(add2[2], a[2], b[3]);
   and(add2[3], a[3], b[3]);

   adder_4bit s2(aug2, add2,0,pro[6:3], pro[7]); // the final stage 2 result gives the remaining bits of the pro.
endmodule 