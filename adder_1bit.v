/**********************************

Name:- Chaitanya Chhichhia (19BEC018
		 Digvijaysingh Chudasama (19BEC029)
		 
**********************************/
module adder_1bit(a,b,cin,sum,cout);

	input a,b,cin;     //a,b are the 1 bit no.s to be added
							 //cin is the input carry
	output sum,cout;	//sum is the final result of addition
							//cout is the generated output carry

	assign sum=a^b^cin;
	assign cout=a&b | cin&(a^b);

endmodule