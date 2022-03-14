/******subtractor using 2's compliment *********/
/***********************************

Name:-Chaitanya Chhichhia (19BEC018)
		Digvijaysingh Chudasama (19BEC029)

**********************************/

module subtractor_4bit(a,b,diff,sgn);

	input[3:0]a,b;        //a is the minuend, b is the subtrahend
	output[3:0]diff;
	output sgn;           //sign of result, 1 for '+'ve no. and 0 for '-'ve no.
	wire boutin;          //generated borrow, which is to be ignored  /***********/

	wire[3:0]b_bar;     //complimenting the subtrahend
	wire[2:0]boin;      //internal borrows generated in stage 1 
	wire bin=1'b1;      //input borrow for stage 1 adder
	wire cin1=1'b0;     //input carry for stage 2 adder
	wire [3:0]diffin;   //output of stage 1 adder 
	wire[3:0]b1;        //augend to stage 2 addder (s5)   
	wire [3:0]diffin1;  //addend to stage 2 addder (s5)          

	//performing the 1st stage of subtraction

	not(b_bar[0],b[0]);  //complimenting each bit of subtrahend to get its 1's compliment
	adder_1bit s1(a[0],b_bar[0],bin,diffin[0],boin[0]);  //b_bar is converted to 2's compliment form due to input carry as 1 to the adder
																		  //then performing the addition
	not(b_bar[1],b[1]);
	adder_1bit s2(a[1],b_bar[1],boin[0],diffin[1],boin[1]);
	not(b_bar[2],b[2]);
	adder_1bit s3(a[2],b_bar[2],boin[1],diffin[2],boin[2]);
	not(b_bar[3],b[3]);
	adder_1bit s4(a[3],b_bar[3],boin[2],diffin[3],boutin);

	// if output carry (boutin) of stage 1 adder is 1, then the result is +ve and the carry is to be neglectted
	// if output carry (boutin) of stage 1 adder is 0, then the result is -ve and is in 2's compliment form
	// xnor gate will work as a not gate if the boutin is 0, and we wil get the 1's compliment of diffin
	
	xnor (diffin1[0],boutin,diffin[0]);
	xnor (diffin1[1],boutin,diffin[1]);
	xnor (diffin1[2],boutin,diffin[2]);
	xnor (diffin1[3],boutin,diffin[3]);
	
	not(b1[0],boutin); 
	assign sgn=b1[0];    
	assign b1[3:1]=3'b0;  

	// diffin1 is the 1's compliment of diffin
	// if boutin is 0, adding 0001 to diffin1(complimented by xnor) to get the 2's compliment of diffin
	// if boutin is 1, adding 0000 to diffin1(not complimentedby xnor) so that we get the direct result diffin
	//diffin1 acts as addend to the stage 2 4bit adder (s5)
	
	adder_4bit s5(diffin1,b1,cin1,diff,bout);
endmodule

