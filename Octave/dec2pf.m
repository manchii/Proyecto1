## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Function: dec2pf 
## Description: It maps from signed decimal number to signed fixed point
##		from an arbitrary lenght of p and f format.
## Created: April 2015
## Version: 0.1

function stroutput = dec2pf(dec,f,n,s)
	stroutput = '0';
	integer = round(dec/(2**(-f)));
	if(s==0)
		stroutput = dec2bin(integer,n);
	else
		if(integer<0)
			stroutput = strcat('1',dec2bin((integer+2**(n-1)),(n-1)));
		else
			stroutput = strcat('0',dec2bin(integer,(n-1)));
		endif
	endif
endfunction
