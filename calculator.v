/************************************

Name:- Chaitanya Chhichhia (19BEC018)
		 Digvijaysingh Chudasama (19BEC029)
	
*************************************/

module calculator_19BEC018_19BEC029(mode,a,b,c,addon,sum,carry,subon,diff,sgn,mulon,pro);

	input[1:0]mode; //for selecting the operation to be performed on the no.s
							// 00 for performing addition
							// 01 for performing subtraction
							// 10 for performing multiplication
							// 11 is an invalid state, all o/p as zero
	input[3:0]a,b;     //input 4bit no.s on which operation is to be performed
	input c;				//input carry to 4bit full adder
	
	output addon; //bit indicating state of adder
						//1 means addition is performed
						//0 means adder is off
	reg addon;
	output[3:0]sum;
	output carry;   //output carry of 4bit full adder
	
	output subon; //bit indicating state of subtractor
						//1 means subtraction is performed
						//0 means subtractor is off
	reg subon;
	output[3:0]diff;
	output sgn;  // bit to denote sign of subtraction operation
					//1 denotes a -ve result and 0 denotes +ve result
	output mulon; //bit indicating state of multiplier
						//1 means multiplication is performed
						//0 means multiplier is off
	reg mulon;
	output[7:0]pro; //result of multiplication of a and b
	
	reg[3:0]adda,addb,suba,subb,mula,mulb; 
	reg ca;
	always @(mode or a or b or c)
	begin
	if (mode==2'b00)  // supplying input no.s a,b,c to adder and remaining modules will give 0 as o/p
	begin
		addon=1'b1;
		adda=a;
		addb=b;
		ca=c;
		subon=1'b0;
		suba=4'b0;
		subb=4'b0;
		mulon=1'b0;
		mula=4'b0;
		mulb=4'b0;
	end
	
	else if(mode==2'b01) // supplying input no.s a,b to subtractor and remaining modules will give 0 as o/p
	begin
		addon=1'b0;
		adda=4'b0;
		addb=4'b0;
		ca=1'b0;
		subon=1'b1;
		suba=a;
		subb=b;
		mulon=1'b0;
		mula=4'b0;
		mulb=4'b0;
	end
	
	else if(mode==2'b10)  //supplying input no.s a,b to mutltiplier and remaining modules will give 0 as o/p
	begin
		addon=1'b0;
		adda=4'b0;
		addb=4'b0;
		ca=1'b0;
		subon=1'b0;
		suba=4'b0;
		subb=4'b0;
		mulon=1'b1;
		mula=a;
		mulb=b;
	end
	
	else            // 11 is an invalid state and all the modules will give 0 as o/p
	begin
		addon=1'b0;
		adda=4'b0;
		addb=4'b0;
		ca=1'b0;
		subon=1'b0;
		suba=4'b0;
		subb=4'b0;
		mulon=1'b0;
		mula=4'b0;
		mulb=4'b0;
	end
	end
adder_4bit add(adda,addb,ca,sum,carry);   // instantiating the 4bit full adder
subtractor_4bit sub(suba,subb,diff,sgn);  // instantiating the 4bit subtractor
multiplier_4bit mul(mula,mulb,pro);       // instantiating the 4bit multiplier

endmodule
	
	